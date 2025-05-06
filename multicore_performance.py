#!/usr/bin/env python3
import subprocess
import re
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import time
import os


def compile_program():
    """Compile the matrix multiplication program"""
    print("Compiling matrix multiplication program...")
    subprocess.run("make clean", shell=True, check=True)
    subprocess.run("make", shell=True, check=True)
    print("Compilation complete.")


def run_matrix_multiply(L, M, N, threads, seed=42, trials=3):
    """Run matrix multiplication with given dimensions, thread count and calculate FLOPS"""
    results = []

    # Formula for calculating number of floating point operations
    # FLOP = LN(2M - 1) as per the assignment description
    flop = L * N * (2 * M - 1)

    # Set OMP_NUM_THREADS environment variable
    env = os.environ.copy()
    env["OMP_NUM_THREADS"] = str(threads)

    for trial in range(trials):
        cmd = f"./matrix_multiply.out {L} {M} {N} {seed}"
        try:
            result = subprocess.run(cmd, shell=True, check=True,
                                    capture_output=True, text=True, env=env)
            output = result.stdout

            # Extract execution time using regex
            time_match = re.search(r"EXEC TIME: (\d+)\.(\d+)", output)
            if time_match:
                seconds = int(time_match.group(1))
                microseconds = int(time_match.group(2))
                time_seconds = seconds + microseconds / 1000000
                flops = flop / time_seconds  # FLOPS = FLOP / time
                mflops = flops / 1000000  # Convert to MFLOPS
                results.append(mflops)
                print(f"Trial {trial + 1}/{trials} for size {L}x{M}x{N} with {threads} threads: {mflops:.2f} MFLOPS")
            else:
                print(f"Could not extract time for {L}x{M}x{N}")
                print(f"Output: {output}")
        except subprocess.CalledProcessError as e:
            print(f"Error running command: {e}")
            print(f"Output: {e.stdout}")
            print(f"Error: {e.stderr}")

        # Wait briefly between trials
        time.sleep(0.5)

    # Return average MFLOPS and standard deviation if we have results
    if results:
        return np.mean(results), np.std(results), flop
    else:
        return 0, 0, flop


def run_thread_experiments(start_size, end_size, step_size, thread_counts, trials=3):
    """Run experiments for square matrices of different sizes with different thread counts"""
    results = []

    # First compile the program
    compile_program()

    # For each thread count
    for threads in thread_counts:
        print(f"\n===== Testing with {threads} thread(s) =====")

        # For each matrix size
        for size in range(start_size, end_size + 1, step_size):
            print(f"\nTesting matrix size {size}x{size}x{size} with {threads} threads...")
            mflops_avg, mflops_std, flop = run_matrix_multiply(size, size, size, threads, trials=trials)

            results.append({
                'Size': size,
                'Threads': threads,
                'MFLOPS_avg': mflops_avg,
                'MFLOPS_std': mflops_std,
                'FLOP': flop
            })

    # Convert results to DataFrame
    df = pd.DataFrame(results)

    # Save results to CSV
    df.to_csv('csv/matrix_multiply_thread_results.csv', index=False)
    print("\nResults saved to matrix_multiply_thread_results.csv")

    return df


def plot_thread_results(df, thread_counts):
    """Plot MFLOPS vs Matrix Dimensions for different thread counts"""
    plt.figure(figsize=(12, 8))

    # Colors for different thread counts
    colors = ['blue', 'orange', 'green', 'red', 'purple', 'brown', 'pink', 'gray']

    # For each thread count, plot a line
    for i, threads in enumerate(thread_counts):
        # Filter data for this thread count
        thread_data = df[df['Threads'] == threads]

        # Sort by size to ensure correct line plotting
        thread_data = thread_data.sort_values('Size')

        # Plot with error bars
        plt.errorbar(
            thread_data['Size'],
            thread_data['MFLOPS_avg'],
            yerr=thread_data['MFLOPS_std'],
            fmt='o-',
            linewidth=2,
            capsize=5,
            label=f'THREADS={threads}',
            color=colors[i % len(colors)]
        )

    plt.title('Matrix Multiplication Performance vs. Number of Threads', fontsize=16)
    plt.xlabel('Matrix Dimension (N for NxN matrices)', fontsize=14)
    plt.ylabel('Performance (MFLOPS)', fontsize=14)
    plt.grid(True, linestyle='--', alpha=0.7)
    plt.legend(fontsize=12)
    plt.tight_layout()

    # Save the plot
    plt.savefig('plots/matrix_multiply_thread_performance.png', dpi=300)
    print("Plot saved to matrix_multiply_thread_performance.png")

    # Also display the plot
    plt.show()


def main():
    # Parameters matching your original code
    start_size = 32  # Starting matrix size
    end_size = 1024  # Ending matrix size
    step_size = 32  # Increment between sizes

    # Thread counts to test
    thread_counts = [1, 2, 4, 8, 16]

    # Number of trials per configuration
    trials = 3

    print("Matrix Multiplication Thread Performance Analysis")
    print("================================================")

    # Run thread experiments
    df_threads = run_thread_experiments(start_size, end_size, step_size, thread_counts, trials)

    # Plot results
    plot_thread_results(df_threads, thread_counts)


if __name__ == "__main__":
    main()