#!/usr/bin/env python3
import subprocess
import re
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import time
import os

def compile_program(opt_level):
    """Compile the matrix multiplication program with a specific optimization level"""
    print(f"Compiling matrix multiplication program with OPT={opt_level}...")
    try:
        # Update the makefile with the optimization level
        with open('makefile', 'r') as f:
            makefile_content = f.readlines()
        with open('makefile', 'w') as f:
            for line in makefile_content:
                if line.startswith('OPT='):
                    f.write(f'OPT={opt_level}\n')
                else:
                    f.write(line)

        subprocess.run("make clean", shell=True, check=True)
        subprocess.run("make", shell=True, check=True)
        print("Compilation complete.")
        return True
    except subprocess.CalledProcessError as e:
        print(f"Error during compilation with OPT={opt_level}: {e}")
        return False
    except Exception as e:
        print(f"Error updating makefile: {e}")
        return False

def run_matrix_multiply(L, M, N, seed=42, trials=3):
    """Run matrix multiplication with given dimensions and calculate FLOPS"""
    results = []
    flop = L * N * (2 * M - 1)

    for trial in range(trials):
        cmd = f"./matrix_multiply.out {L} {M} {N} {seed}"
        try:
            result = subprocess.run(cmd, shell=True, check=True,
                                    capture_output=True, text=True)
            output = result.stdout
            time_match = re.search(r"EXEC TIME: (\d+)\.(\d+)", output)
            if time_match:
                seconds = int(time_match.group(1))
                microseconds = int(time_match.group(2))
                time_seconds = seconds + microseconds / 1000000
                flops_achieved = flop / time_seconds
                results.append(flops_achieved / 1e6)  # Store MFLOPS
                print(f"  Trial {trial+1}/{trials} for size {L}x{M}x{N}: {flops_achieved / 1e6:.2f} MFLOPS")
            else:
                print(f"  Could not extract time for {L}x{M}x{N}")
                print(f"  Output: {output}")
        except subprocess.CalledProcessError as e:
            print(f"  Error running command: {e}")
            print(f"  Output: {e.stdout}")
            print(f"  Error: {e.stderr}")
        time.sleep(0.1)
    if results:
        return np.mean(results), np.std(results)
    else:
        return 0, 0

def run_optimized_experiments(start_size, end_size, step_size, trials=3):
    """Run experiments for square matrices with different compiler optimization levels"""
    optimization_levels = ["-O", "-O1", "-O2", "-O3"]
    all_results = []

    for opt_level in optimization_levels:
        if compile_program(opt_level):
            results = []
            print(f"\nRunning experiments with OPT={opt_level}...")
            for size in range(start_size, end_size + 1, step_size):
                print(f"Testing matrix size {size}x{size}x{size}...")
                mflops_avg, mflops_std = run_matrix_multiply(size, size, size, trials=trials)
                flop_theoretical = size * size * (2 * size - 1)
                results.append({
                    'Size': size,
                    'MFLOPS_avg': mflops_avg,
                    'MFLOPS_std': mflops_std,
                    'OPT': opt_level,
                    'FLOP_theoretical': flop_theoretical / 1e6  # Store theoretical MFLOPS
                })
            all_results.extend(results)
        else:
            print(f"Skipping experiments for OPT={opt_level} due to compilation failure.")

    df_optimized = pd.DataFrame(all_results)
    df_optimized.to_csv('csv/matrix_multiply_optimized_results_mflops.csv', index=False)
    print("\nOptimized results saved to matrix_multiply_optimized_results_mflops.csv")
    return df_optimized

def plot_optimized_results(df):
    """Plot MFLOPS vs Matrix Dimensions for different optimization levels"""
    plt.figure(figsize=(12, 7))
    optimization_levels = df['OPT'].unique()

    for opt_level in optimization_levels:
        df_opt = df[df['OPT'] == opt_level]
        plt.errorbar(df_opt['Size'], df_opt['MFLOPS_avg'], yerr=df_opt['MFLOPS_std'],
                     fmt='o-', label=f'OPT={opt_level}', linewidth=2, markersize=6, capsize=4)

    plt.title('Matrix Multiplication Performance vs. Compiler Optimization', fontsize=16)
    plt.xlabel('Matrix Dimension (N for NxN matrices)', fontsize=14)
    plt.ylabel('Performance (MFLOPS)', fontsize=14)
    plt.grid(True, linestyle='--', alpha=0.7)
    plt.legend(fontsize=12)
    plt.tight_layout()
    plt.savefig('plots/matrix_multiply_performance_optimized_mflops.png', dpi=300)
    print("Plot of optimized performance saved to matrix_multiply_performance_optimized_mflops.png")
    plt.show()

def main():
    # Parameters
    start_size = 32    # Starting matrix size
    end_size = 1024   # Same end size as baseline
    step_size = 32     # Same step size as baseline
    trials = 3       # Number of trials per size

    print("Matrix Multiplication Performance Analysis with Compiler Optimizations")
    print("===================================================================")

    df_optimized = run_optimized_experiments(start_size, end_size, step_size, trials)
    if not df_optimized.empty:
        plot_optimized_results(df_optimized)

if __name__ == "__main__":
    main()