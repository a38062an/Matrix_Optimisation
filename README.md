# Matrix_Optimisation

# baseline_performance.py

This Python script is designed to benchmark the performance of a separate C/C++ program (`matrix_multiply.out`) that performs matrix multiplication. It automates the process of running the compiled program with various matrix dimensions, calculates the achieved Floating Point Operations Per Second (FLOPS), and visualizes the results.

## Functionality

The script performs the following key actions:

1.  **Compilation:** It first attempts to compile the C/C++ matrix multiplication program using the `make` command. This ensures that the executable `matrix_multiply.out` is up-to-date.

2.  **Square Matrix Experiments:**
    * It runs the `matrix_multiply.out` program for a range of square matrix sizes. The dimensions L, M, and N are all equal and vary from a `start_size` (default: 32) to an `end_size` (default: 1024) with a `step_size` (default: 32).
    * For each size, it executes the multiplication multiple times (`trials`, default: 3) to get an average performance.
    * It calculates the total number of floating-point operations (FLOPs) using the formula:
        $\text{FLOP} = L \times N \times (2 \times M - 1)$
        where $L$, $M$, and $N$ are the matrix dimensions. For square matrices, $L = M = N = \text{size}$.
    * It extracts the execution time from the output of `matrix_multiply.out` using regular expressions.
    * It calculates the achieved FLOPS by dividing the total FLOPs by the execution time in seconds.
    * The results (size, average FLOPS, standard deviation) are stored in a Pandas DataFrame and saved to a CSV file named `matrix_multiply_results.csv`.
    * A plot of FLOPS against the matrix dimension for square matrices is generated and saved as `matrix_multiply_performance.png`.

3.  **Non-Square Matrix Experiments:**
    * It runs experiments to test the effect of varying each of the dimensions (L, M, and N) independently while keeping the other two at a larger `base_size` (default: 256).
    * It iterates through a range of values for L (while M and N are fixed), then M (while L and N are fixed), and finally N (while L and M are fixed).
    * For each non-square configuration, it calculates the FLOPs and the achieved FLOPS in the same way as for square matrices.
    * The results are stored in a Pandas DataFrame and saved to `matrix_multiply_non_square_results.csv`.
    * A plot showing how FLOPS changes as L, M, or N are varied is generated and saved as `matrix_dimensions_effect_large_base.png`.

4.  **Plotting:** The script uses `matplotlib.pyplot` to generate plots visualizing the performance (FLOPS) against the matrix dimensions for both square and non-square matrix experiments. Error bars are included to show the standard deviation of the measurements.

## Purpose

The primary purpose of this script is to:

* Establish a baseline performance for the unoptimized `matrix_multiply()` function implemented in C/C++.
* Explore how the performance (achieved FLOPS) scales with increasing square matrix dimensions.
* Investigate the impact of individual dimension variations (L, M, and N) on the performance of matrix multiplication when the overall matrix sizes are larger.
* Provide data and visualizations that can be used as a comparison for future optimized implementations of matrix multiplication.

By running this script and analyzing the generated data and plots, you can gain insights into the fundamental performance characteristics of matrix multiplication on your hardware before any optimizations are applied.