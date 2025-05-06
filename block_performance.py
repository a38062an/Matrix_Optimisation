#!/usr/bin/env python3
import subprocess
import re
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import time
import os


def compile_program(block_size):
    """Compile the matrix multiplication program with BLOCK_SIZE as a flag"""
    print(f"Compiling matrix multiplication program with BLOCK_SIZE={block_size}...")
    subprocess.run("make clean", shell=True, check=True)
    cflags = f"-O3 -mavx -fopenmp -DBLOCK_SIZE={block_size}"
    subprocess.run(f"make CFLAGS='{cflags}'", shell=True, check=True)
    print("Compilation complete.")


def run_matrix_multiply(L, M, N, seed=42, trials=3):
    """Run matrix multiplication with given dimensions and calculate FLOPS"""
    results = []
    flop = L * N * (2 * M - 1)
    cmd = f"./matrix_multiply.out {L} {M} {N} {seed}"
    for trial in range(trials):
        try:
            result = subprocess.run(cmd, shell=True, check=True,
                                    capture_output=True, text=True)
            output = result.stdout
            time_match = re.search(r"EXEC TIME: (\d+)\.(\d+)", output)
            if time_match:
                seconds = int(time_match.group(1))
                microseconds = int(time_match.group(2))
                time_seconds = seconds + microseconds / 1000000
                mflops = flop / time_seconds / 1e6
                results.append(mflops)
                print(f"Trial {trial + 1}/{trials} for size {L}x{M}x{N}: {mflops:.2f} MFLOPS")
            else:
                print(f"Could not extract time for {L}x{M}x{N}")
                print(f"Output: {output}")
        except subprocess.CalledProcessError as e:
            print(f"Error running command: {e}")
            print(f"Stdout: {e.stdout}")
            print(f"Stderr: {e.stderr}")
        time.sleep(0.5)
    return np.mean(results) if results else 0, np.std(results) if results else 0, flop


def run_block_size_experiments(start_size, end_size, step_size, block_sizes, trials=3):
    """Run experiments for square matrices of different sizes with different block sizes"""
    results = []
    for block_size in block_sizes:
        print(f"\n===== Testing with BLOCK_SIZE={block_size} (via flag) =====")
        compile_program(block_size)
        for size in range(start_size, end_size + 1, step_size):
            # Check for compatibility (crude check to avoid large steps)
            if size % block_size != 0 and block_size > 32:
                print(f"Skipping size {size} for BLOCK_SIZE {block_size} (potential incompatibility).")
                continue
            print(f"\nTesting matrix size {size}x{size}x{size} with BLOCK_SIZE={block_size}...")
            try:
                mflops_avg, mflops_std, flop = run_matrix_multiply(size, size, size, trials=trials)
                results.append({
                    'Size': size,
                    'BlockSize': block_size,
                    'MFLOPS_avg': mflops_avg,
                    'MFLOPS_std': mflops_std,
                    'FLOP': flop
                })
            except subprocess.CalledProcessError as e:
                print(f"Execution failed for size {size} and BLOCK_SIZE {block_size}: {e}")
                print(f"Stderr: {e.stderr}")
            except Exception as e:
                print(f"An unexpected error occurred: {e}")

    df = pd.DataFrame(results)
    df.to_csv('csv/matrix_multiply_block_size_results.csv', index=False)
    print("\nResults saved to matrix_multiply_block_size_results.csv")
    return df


def plot_block_size_results(df, block_sizes):
    """Plot MFLOPS vs Matrix Dimensions for different block sizes"""
    plt.figure(figsize=(12, 8))
    colors = ['blue', 'orange', 'green', 'red', 'purple', 'brown', 'pink', 'gray']
    for i, block_size in enumerate(block_sizes):
        block_data = df[df['BlockSize'] == block_size].sort_values('Size')
        plt.errorbar(
            block_data['Size'],
            block_data['MFLOPS_avg'],
            yerr=block_data['MFLOPS_std'],
            fmt='o-',
            linewidth=2,
            capsize=5,
            label=f'BLOCK_SIZE={block_size}',
            color=colors[i % len(colors)]
        )
    plt.title('Matrix Multiplication Performance vs. Block Size', fontsize=16)
    plt.xlabel('Matrix Dimension (N for NxN matrices)', fontsize=14)
    plt.ylabel('Performance (MFLOPS)', fontsize=14)
    plt.grid(True, linestyle='--', alpha=0.7)
    plt.legend(fontsize=12)
    plt.tight_layout()
    plt.savefig('plots/smatrix_multiply_block_size_performance_fixed_sizes.png', dpi=300)
    print("Plot saved to matrix_multiply_block_size_performance_fixed_sizes.png")
    plt.show()


def main():
    # Parameters
    start_size = 32
    end_size = 1024
    step_size = 32
    block_sizes = [2, 4, 8, 16, 32, 64, 128]
    trials = 3

    print("Matrix Multiplication Block Size Performance Analysis (Avoiding Incompatible Sizes)")
    print("===============================================================================")

    df_blocks = run_block_size_experiments(start_size, end_size, step_size, block_sizes, trials)
    plot_block_size_results(df_blocks, block_sizes)


if __name__ == "__main__":
    main()