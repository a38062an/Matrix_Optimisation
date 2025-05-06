#!/usr/bin/env python3
import subprocess
import re
import numpy as np
import matplotlib.pyplot as plt
import pandas as pd
import time
import os


def compile_unrolled_program(unroll_factor):
    """Compile the matrix multiplication program with a specific UNROLL factor and no optimizations"""
    executable_name = f"unrolled_matrix_multiply_unopt_{unroll_factor}.out"
    print(f"Compiling {executable_name} with UNROLL={unroll_factor} and no optimizations...")
    try:
        compile_command = [
            "gcc",
            f"-DUNROLL={unroll_factor}",
            "-fopenmp",
            "-mavx",
            "-O3",  # Explicitly disable optimizations
            "-o",
            executable_name,
            "main.c"  # Assuming your C code is in main.c
        ]
        subprocess.run(compile_command, check=True)
        print("Compilation complete.")
        return executable_name
    except subprocess.CalledProcessError as e:
        print(f"Error during compilation with UNROLL={unroll_factor} (no opt): {e}")
        return None

def run_unrolled_matrix_multiply(executable, L, M, N, seed=42, inner_trials=3):
    """Run the matrix multiplication multiple times and return the average FLOPS"""
    all_flops = []
    flop_count = L * N * (2 * M - 1)

    for trial in range(inner_trials):
        cmd = f"./{executable} {L} {M} {N} {seed}"
        try:
            result = subprocess.run(cmd, shell=True, check=True,
                                    capture_output=True, text=True)
            output = result.stdout
            time_match = re.search(r"EXEC TIME: (\d+\.\d+)", output)

            if time_match:
                time_seconds = float(time_match.group(1))
                flops_achieved = flop_count / time_seconds
                all_flops.append(flops_achieved)
                print(
                    f"  Inner Trial {trial + 1}/{inner_trials} for size {L}x{M}x{N} (UNROLL={executable.split('_')[-1].split('.')[0]}): {flops_achieved:.2f} FLOPS")
            else:
                print(f"  Could not extract time for {L}x{M}x{N} (UNROLL={executable.split('_')[-1].split('.')[0]})")
                print(f"  Output:\n{output}")
        except subprocess.CalledProcessError as e:
            print(f"  Error running command: {e}")
            print(f"  Output:\n{e.stdout}")
            print(f"  Error:\n{e.stderr}")
        time.sleep(0.1)

    if all_flops:
        return np.mean(all_flops), np.std(all_flops)
    else:
        return 0, 0


def run_unroll_experiments(start_size, end_size, step_size, unroll_factors, outer_trials=3, inner_trials=3):
    """Run experiments for square matrices with different UNROLL factors, repeating the entire experiment."""
    all_aggregated_results = []
    for experiment in range(outer_trials):
        print(f"\n==================== Experiment {experiment + 1}/{outer_trials} ====================")
        all_results = []
        compiled_executables = {}

        for unroll in unroll_factors:
            executable = compile_unrolled_program(unroll)
            if executable:
                compiled_executables[unroll] = executable

        for unroll, executable in compiled_executables.items():
            results = []
            print(f"\nRunning experiments with UNROLL={unroll}...")
            for size in range(start_size, end_size + 1, step_size):
                print(f"Testing matrix size {size}x{size}x{size}...")
                flops_avg, flops_std = run_unrolled_matrix_multiply(executable, size, size, size, inner_trials=inner_trials)
                results.append({
                    'Size': size,
                    'FLOPS_avg': flops_avg,
                    'FLOPS_std': flops_std,
                    'UNROLL': unroll,
                    'Experiment': experiment + 1
                })
            all_results.extend(results)

        df_unrolled_experiment = pd.DataFrame(all_results)
        all_aggregated_results.append(df_unrolled_experiment)

        # Clean up executables after each experiment
        for executable in compiled_executables.values():
            try:
                os.remove(executable)
            except OSError as e:
                print(f"Error deleting {executable}: {e}")

    # Combine results from all experiments
    df_all_experiments = pd.concat(all_aggregated_results)

    # Calculate the average and standard deviation of FLOPS across all outer trials
    df_averaged = df_all_experiments.groupby(['Size', 'UNROLL'])[['FLOPS_avg', 'FLOPS_std']].mean().reset_index()
    df_std_across_trials = df_all_experiments.groupby(['Size', 'UNROLL'])['FLOPS_avg'].std().reset_index(name='FLOPS_std_across_trials')
    df_averaged = pd.merge(df_averaged, df_std_across_trials, on=['Size', 'UNROLL'])

    df_averaged.to_csv('csv/matrix_multiply_unrolled_averaged_results.csv', index=False)
    print("\nAveraged unrolled results saved to matrix_multiply_unrolled_averaged_results.csv")

    return df_averaged


def plot_averaged_unrolled_results(df):
    """Plot averaged FLOPS vs Matrix Dimensions for different UNROLL factors"""
    plt.figure(figsize=(12, 7))
    unroll_factors = sorted(df['UNROLL'].unique())

    for unroll in unroll_factors:
        df_unroll = df[df['UNROLL'] == unroll]
        plt.errorbar(df_unroll['Size'], df_unroll['FLOPS_avg'] / 1e6,
                     yerr=df_unroll['FLOPS_std_across_trials'] / 1e6,  # Use std across trials for error bars
                     fmt='o-', label=f'UNROLL={unroll}', linewidth=2, markersize=6, capsize=4)

    plt.title('Average Matrix Multiplication Performance vs. Loop Unrolling (Averaged over Trials)', fontsize=16)
    plt.xlabel('Matrix Dimension (N for NxN matrices)', fontsize=14)
    plt.ylabel('Performance (MFLOPS)', fontsize=14)
    plt.grid(True, linestyle='--', alpha=0.7)
    plt.legend(fontsize=12)
    plt.tight_layout()
    plt.savefig('plots/matrix_multiply_performance_unrolled_averaged.png', dpi=300)
    print("Plot of averaged performance with loop unrolling saved to matrix_multiply_performance_unrolled_averaged.png")
    plt.show()


def main():
    # Parameters
    start_size = 32     # Starting matrix size
    end_size = 1024    # Increased end size back to 1024
    step_size = 128     # Adjusted step size for more data points
    unroll_factors = [1, 2, 4, 8, 16]
    outer_trials = 1    # Number of times to repeat the entire experiment
    inner_trials = 3    # Number of trials per matrix size within each experiment

    print("Matrix Multiplication Performance Analysis with Loop Unrolling (Averaged)")
    print("=======================================================================")

    df_averaged_results = run_unroll_experiments(start_size, end_size, step_size, unroll_factors, outer_trials, inner_trials)
    if not df_averaged_results.empty:
        plot_averaged_unrolled_results(df_averaged_results)

if __name__ == "__main__":
    main()