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
    df.to_csv('matrix_multiply_results.csv', index=False)
    print("\nResults saved to matrix_multiply_results.csv")

    return df

def run_non_square_experiments(trials=3):
    """Run experiments for non-square matrices to test effect of L, M, N variations"""
    results = []

    # Vary L while keeping M and N constant
    base_size = 100
    for L in range(50, 301, 50):
        M = base_size
        N = base_size
        print(f"\nTesting matrix size {L}x{M}x{N}...")
        flops_avg, flops_std, flop = run_matrix_multiply(L, M, N, trials=trials)
        results.append({
            'L': L, 'M': M, 'N': N,
            'FLOPS_avg': flops_avg,
            'FLOPS_std': flops_std,
            'FLOP': flop,
            'Time_avg': flop / flops_avg if flops_avg > 0 else 0,
            'Variation': 'L'
        })

    # Vary M while keeping L and N constant
    for M in range(50, 301, 50):
        L = base_size
        N = base_size
        print(f"\nTesting matrix size {L}x{M}x{N}...")
        flops_avg, flops_std, flop = run_matrix_multiply(L, M, N, trials=trials)
        results.append({
            'L': L, 'M': M, 'N': N,
            'FLOPS_avg': flops_avg,
            'FLOPS_std': flops_std,
            'FLOP': flop,
            'Time_avg': flop / flops_avg if flops_avg > 0 else 0,
            'Variation': 'M'
        })

    # Vary N while keeping L and M constant
    for N in range(50, 301, 50):
        L = base_size
        M = base_size
        print(f"\nTesting matrix size {L}x{M}x{N}...")
        flops_avg, flops_std, flop = run_matrix_multiply(L, M, N, trials=trials)
        results.append({
            'L': L, 'M': M, 'N': N,
            'FLOPS_avg': flops_avg,
            'FLOPS_std': flops_std,
            'FLOP': flop,
            'Time_avg': flop / flops_avg if flops_avg > 0 else 0,
            'Variation': 'N'
        })

    # Convert results to DataFrame
    df = pd.DataFrame(results)

    # Save results to CSV
    df.to_csv('matrix_multiply_non_square_results.csv', index=False)
    print("\nNon-square results saved to matrix_multiply_non_square_results.csv")

    return df

def plot_results(df):
    """Plot FLOPS vs Matrix Dimensions"""
    plt.figure(figsize=(10, 6))

    # Plot with error bars
    plt.errorbar(df['Size'], df['FLOPS_avg'] / 1e6, yerr=df['FLOPS_std'] / 1e6,
                 fmt='o-', linewidth=2, markersize=8, capsize=5)

    plt.title('Matrix Multiplication Performance (Baseline)', fontsize=16)
    plt.xlabel('Matrix Dimension (N for NxN matrices)', fontsize=14)
    plt.ylabel('Performance (MFLOPS)', fontsize=14)
    plt.grid(True, linestyle='--', alpha=0.7)
    plt.tight_layout()

    # Save the plot
    plt.savefig('matrix_multiply_performance.png', dpi=300)
    print("Plot saved to matrix_multiply_performance.png")

    # Also display the plot
    plt.show()

def plot_non_square_results(df):
    """Plot FLOPS vs different dimension variations"""
    plt.figure(figsize=(12, 8))

    # Group by variation type
    variation_groups = df.groupby('Variation')

    for variation, group in variation_groups:
        if variation == 'L':
            plt.plot(group['L'], group['FLOPS_avg'] / 1e6, 'o-', label=f'Varying L (M=N={group["M"].iloc[0]})')
        elif variation == 'M':
            plt.plot(group['M'], group['FLOPS_avg'] / 1e6, 's-', label=f'Varying M (L=N={group["L"].iloc[0]})')
        elif variation == 'N':
            plt.plot(group['N'], group['FLOPS_avg'] / 1e6, '^-', label=f'Varying N (L=M={group["L"].iloc[0]})')

    plt.title('Effect of Different Matrix Dimensions on Performance', fontsize=16)
    plt.xlabel('Dimension Size', fontsize=14)
    plt.ylabel('Performance (MFLOPS)', fontsize=14)
    plt.grid(True, linestyle='--', alpha=0.7)
    plt.legend(fontsize=12)
    plt.tight_layout()

    # Save the plot
    plt.savefig('matrix_dimensions_effect.png', dpi=300)
    print("Plot saved to matrix_dimensions_effect.png")

    # Also display the plot
    plt.show()

def main():
    # Parameters
    start_size = 32    # Starting matrix size
    end_size = 1024    # Ending matrix size
    step_size = 32     # Increment between sizes
    trials = 3         # Number of trials per size for averaging

    print("Matrix Multiplication Performance Analysis")
    print("==========================================")

    # First run square matrix experiments
    df_square = run_experiments(start_size, end_size, step_size, trials)
    plot_results(df_square)

    # Then run non-square matrix experiments to test effect of L, M, N variations
    df_non_square = run_non_square_experiments(trials)
    plot_non_square_results(df_non_square)

if __name__ == "__main__":
    main()