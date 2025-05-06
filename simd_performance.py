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

def run_matrix_multiply(L, M, N, seed=42, trials=3):
    """Run matrix multiplication with given dimensions and calculate FLOPS"""
    results = []

    # Formula for calculating number of floating point operations
    # FLOP = LN(2M - 1) as per the assignment description
    flop = L * N * (2 * M - 1)

    for trial in range(trials):
        cmd = f"./matrix_multiply.out {L} {M} {N} {seed}"
        try:
            result = subprocess.run(cmd, shell=True, check=True,
                                    capture_output=True, text=True)
            output = result.stdout

            # Extract execution time using regex
            time_match = re.search(r"EXEC TIME: (\d+)\.(\d+)", output)
            if time_match:
                seconds = int(time_match.group(1))
                microseconds = int(time_match.group(2))
                time_seconds = seconds + microseconds / 1000000
                flops = flop / time_seconds  # FLOPS = FLOP / time
                results.append(flops)
                print(f"Trial {trial+1}/{trials} for size {L}x{M}x{N}: {flops:.2f} FLOPS")
            else:
                print(f"Could not extract time for {L}x{M}x{N}")
                print(f"Output: {output}")
        except subprocess.CalledProcessError as e:
            print(f"Error running command: {e}")
            print(f"Output: {e.stdout}")
            print(f"Error: {e.stderr}")

        # Wait briefly between trials
        time.sleep(0.5)

    # Return average FLOPS and standard deviation if we have results
    if results:
        return np.mean(results), np.std(results), flop
    else:
        return 0, 0, flop

def run_experiments(start_size, end_size, step_size, trials=3):
    """Run experiments for square matrices of different sizes"""
    results = []

    # First compile the program
    compile_program()

    # Run matrix multiply for each size
    for size in range(start_size, end_size + 1, step_size):
        print(f"\nTesting matrix size {size}x{size}x{size}...")
        flops_avg, flops_std, flop = run_matrix_multiply(size, size, size, trials=trials)

        results.append({
            'Size': size,
            'FLOPS_avg': flops_avg,
            'FLOPS_std': flops_std,
            'FLOP': flop,
            'Time_avg': flop / flops_avg if flops_avg > 0 else 0
        })

    # Convert results to DataFrame
    df = pd.DataFrame(results)

    # Save results to CSV
    df.to_csv('csv/matrix_multiply_simd_results.csv', index=False)
    print("\nResults saved to matrix_multiply_results.csv")

    return df

def plot_results(df):
    """Plot MFLOPS vs Matrix Dimensions"""
    plt.figure(figsize=(10, 6))

    # Calculate MFLOPS
    mflops_avg = df['FLOPS_avg'] / 1e6
    mflops_std = df['FLOPS_std'] / 1e6

    # Plot with error bars
    plt.errorbar(df['Size'], mflops_avg, yerr=mflops_std,
                 fmt='o-', linewidth=2, markersize=8, capsize=5)

    plt.title('Matrix Multiplication Performance (simd)', fontsize=16)
    plt.xlabel('Matrix Dimension (N for NxN matrices)', fontsize=14)
    plt.ylabel('Performance (MFLOPS)', fontsize=14)
    plt.grid(True, linestyle='--', alpha=0.7)
    plt.tight_layout()

    # Save the plot
    plt.savefig('plots/matrix_multiply_simd_performance_mflops.png', dpi=300)
    print("Plot saved to matrix_multiply_baseline_performance_mflops.png")

    # Also display the plot
    plt.show()

def main():
    # Parameters
    start_size = 32     # Starting matrix size
    end_size = 1024    # Ending matrix size
    step_size = 32      # Increment between sizes
    trials = 3          # Number of trials per size for averaging

    print("Matrix Multiplication Performance Analysis")
    print("==========================================")

    # First run square matrix experiments
    df_square = run_experiments(start_size, end_size, step_size, trials)
    plot_results(df_square)

if __name__ == "__main__":
    main()