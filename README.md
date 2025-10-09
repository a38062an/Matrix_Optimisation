# Matrix_Optimisation

High-performance matrix multiplication benchmarks and optimization experiments in C and Python. This repository demonstrates various optimization techniques for matrix multiplication, comparing their performance impacts and providing comprehensive benchmarking data.

## System Architecture & Hardware Context

**Test System**: Razer Blade 15 (2019) with Intel Core i7-10750H (Comet Lake)

- **Cores**: 6 physical cores, 12 logical threads (hyperthreading)
- **Cache**: 12MB L3 shared cache, 64-byte cache lines
- **Clock**: 2.60 GHz base frequency
- **SIMD**: AVX2 support for vectorized operations
- **Architecture**: x86-64 with 39-bit physical addressing

Matrix multiplication optimization is highly dependent on underlying hardware architecture. Results and optimal parameters are specific to this Intel mobile processor configuration.

## Performance Limitations & Hardware Dependencies

### Cache Effects
- Performance drops significantly when matrices exceed cache capacity
- Sharp decline at N=800-1000 when data no longer fits in 12MB L3 cache
- Block size optimization (8x8) specifically targets L1 cache utilization

### Memory Bandwidth Bottlenecks
- Large matrices become memory-bound regardless of optimization technique
- All optimization levels converge to similar poor performance (300-400 MFLOPS) for N=1000
- Memory access patterns become dominant constraint over computational optimizations

### Architecture-Specific Tuning
- Optimal parameters are hardware-dependent:
  - Block size matches cache hierarchy (L1: 8x8 blocks)
  - Thread count aligns with physical cores (6-8 threads optimal)
  - SIMD utilization requires AVX2 support
  - Unroll factors depend on register file size

### Portability Challenges
- Optimization parameters tuned for Intel i7-10750H may not transfer to other architectures
- Different CPU families (AMD, ARM) would require re-tuning
- Cache sizes, SIMD capabilities, and memory controllers vary significantly across systems

## Optimization Methods Implemented

### 1. **Compiler Optimizations** (`optimised_compiler_performance.py`)

- **Technique**: GCC optimization flags (-O, -O1, -O2, -O3)
- **Results**: -O2 and -O3 achieve 2x performance improvement over baseline
- **Hardware Impact**: -O2 enables loop unrolling and vectorization that matches CPU capabilities
- **Performance**: Peak 2800 MFLOPS (small matrices), converging to 300-400 MFLOPS (large matrices)

### 2. **Loop Unrolling** (`loop_unrolling_performance.py`)

- **Technique**: Manual loop unrolling with factors 2x, 4x, 8x, 16x
- **Optimal Factor**: UNROLL=8 provides best performance (560 MFLOPS peak)
- **Hardware Impact**: Balances register utilization without causing register spilling
- **Architecture Dependency**: Optimal factor varies with CPU register file size

### 3. **Cache-Aware Block Matrix Multiplication** (`block_performance.py`)

- **Technique**: Matrix blocking/tiling for cache optimization
- **Optimal Block Size**: 8x8 blocks (512 bytes) fit optimally in L1 cache
- **Performance**: 10,000 MFLOPS peak, 3-5x improvement over other block sizes
- **Hardware Impact**:
  - 8x8 blocks utilize 64-byte cache lines efficiently
  - Larger blocks (64x64, 128x128) cause cache thrashing
  - Smaller blocks (2x2, 4x4) have excessive overhead

### 4. **SIMD Vectorization** (`simd_performance.py`)

- **Technique**: AVX2 instructions processing 4 doubles simultaneously
- **Performance**: 4-4.5x speedup, peak 11,000 MFLOPS (small matrices)
- **Hardware Utilization**: Leverages 256-bit AVX2 registers for parallel computation
- **Memory Alignment**: 32-byte alignment ensures optimal SIMD performance

### 5. **Multithreading/Multicore Optimization** (`multicore_performance.py`)

- **Technique**: OpenMP parallelization across CPU cores
- **Optimal Threads**: 8-12 threads show best performance on 6-core/12-thread system
- **Performance**: Peak 9,000 MFLOPS with 8 threads
- **Scaling**: Diminishing returns beyond physical core count due to hyperthreading overhead

### 6. **Algorithmic Optimizations** (`optimised_performance.py`)

- **Technique**: Combined approach using multiple optimization strategies
- **Implementation**: Cache blocking + SIMD + threading + loop unrolling
- **Expected Performance**: 8,000-10,000 MFLOPS (small), 3,000-5,000 MFLOPS (large matrices)

## Performance Analysis and Benchmarking

### Comprehensive Measurement Framework

- **Automated Testing**: Python scripts that compile, execute, and measure C implementations
- **Statistical Rigor**: Multiple trial runs with mean and standard deviation calculations
- **FLOPS Calculation**: Accurate floating-point operations per second measurement
- **Scalability Analysis**: Performance testing across various matrix sizes (32×32 to 1024×1024+)

### Data Collection and Visualization

- **CSV Output**: Structured data in `csv/` directory for further analysis
- **Performance Plots**: Visual comparisons in `plots/` directory showing:
  - MFLOPS vs matrix size for each optimization
  - Speedup factors and efficiency metrics
  - Thread scaling and parallel performance
  - Block size optimization curves

### Professional Development Value

This project demonstrates:

- **Systems Programming**: Low-level C optimization and understanding of computer architecture
- **Performance Engineering**: Systematic approach to identifying and eliminating bottlenecks
- **Scientific Computing**: Mathematical algorithms and numerical computing expertise
- **Data Analysis**: Benchmarking methodology and statistical analysis of performance data
- **Software Engineering**: Modular code organization, automated testing, and reproducible results

## Technical Skills Showcased

- **Languages**: C (core implementations), Python (automation and analysis)
- **Optimization**: Compiler flags, manual code optimization, algorithmic improvements
- **Parallel Computing**: Multithreading, SIMD vectorization, scalability analysis
- **Systems Knowledge**: CPU architecture, memory hierarchy, cache optimization
- **Tools**: Make, GCC, profiling tools, statistical analysis libraries
- **Methodology**: Benchmarking, performance measurement, experimental design

## baseline_performance.py

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