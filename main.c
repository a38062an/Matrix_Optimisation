#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <sys/time.h>
#include <x86intrin.h>
#include <omp.h>

#define PRINT_MATRICES 0 // Determines whether to print matrices
#define MIN 0.0 // Min value in matrix
#define MAX 1.0 // Max value in matrix
//#define UNROLL 4 // Number of times to unroll loop in unrolled_matrix_multiply()

#ifndef UNROLL
#define UNROLL 4
#endif

#define OMP_THREADS 4 // Number of threads to use with omp pragma
// #define BLOCK_SIZE 8 // Block size when using blocked_matrix_multiply()

#ifndef BLOCK_SIZE
#define BLOCK_SIZE 32 // Default block size if not defined by flag
#endif

#define MM256_STRIDE 4 // Number of doubles operated on simultaneously in AVX instructions
#define MEM_ALIGN 32 // Memory alignment required for _mm256 instructions



void print_help_and_exit(char **argv) {
    printf("usage: %s <L> <M> <N> <seed>\n", argv[0]);
    exit(0);
}

void print_matrix(double **mat, int rows, int cols) {
   for(int i=0; i<rows; i++) {
        for(int j=0; j<cols; j++){
           printf("%f ", mat[i][j]);
        }
        printf("\n");
   }
}

double drand(double min, double max){ //
    double random_double = (double) rand() / RAND_MAX; 
    random_double = (random_double * (max - min)) + min;
    return random_double;
}

/* Multiply two matrices
 * size of A is LxM
 * size of B is MxN
 * C should be allocated of size LxN
 */
void matrix_multiply(double **A, double **B, double **C, int L, int M, int N) {
    /* iterate over the rows of A */
    for(int i=0; i<L; i++) {
        /* Iterate over the columns of B */
        for(int j=0; j<N; j++) {
            /* Iterate over the rows of B */
            for(int k=0; k<M; k++){
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
}

/* Multiply two matrices using loop unrolling
 * size of A is LxM
 * size of B is MxN
 * C should be allocated of size LxN
 */
void unrolled_matrix_multiply(double **A, double **B, double **C, int L, int M, int N) {
    /* iterate over the rows of A */
    for(int i=0; i<L; i++) {
        /* Iterate over the columns of B */
        for(int j=0; j<N; j+=UNROLL) {
            double C_temp[UNROLL];
	    for (int u=0; u<UNROLL; u++){
                C_temp[u] = C[i][j+u];
	    }
	    for (int u=0; u<UNROLL; u++){
	    /* Iterate over the rows of B */
            	for(int k=0; k<M; k++){
                    C_temp[u] += A[i][k] * B[k][j+u];
	    	}
            }
	    for (int u=0; u<UNROLL; u++){
	        C[i][j+u] = C_temp[u];
            }
        }
    }
}

/* Multiply two matrices using multiple cores via OMP
 * size of A is LxM
 * size of B is MxN
 * C should be allocated of size LxN
 */
void multicore_matrix_multiply(double **A, double **B, double **C, int L, int M, int N) {
    #pragma omp parallel for
    /* iterate over the rows of A */
    for(int i=0; i<L; i++) {
        /* Iterate over the columns of B */
        for(int j=0; j<N; j++) {
            /* Iterate over the rows of B */
            for(int k=0; k<M; k++){
                C[i][j] += A[i][k] * B[k][j];
	    }
        }
    }
}

void do_block(int si, int sj, int sk, double **A, double **B, double **C){
    // printf("do_block: si %u sj %u sk %u\n", si, sj, sk);
    for (int i=si; i<si+BLOCK_SIZE; i++){
        for (int j=sj; j<sj+BLOCK_SIZE; j++){
	    double C_ij = C[i][j];
            for (int k=sk; k<sk+BLOCK_SIZE; k++){
		// printf("i %u, j %u, k %u\n", i, j, k);
		C_ij += A[i][k] * B[k][j]; 
            }
            C[i][j] = C_ij;
        }
    }	 
}

/* Multiply two matrices using blocking to improve cache performance
 * size of A is LxM
 * size of B is MxN
 * C should be allocated of size LxN
 */
void blocked_matrix_multiply(double **A, double **B, double **C, int L, int M, int N) {
    /* iterate over the rows of A */
    for(int sj=0; sj<L; sj+=BLOCK_SIZE) {
        /* Iterate over the columns of B */
        for(int si=0; si<N; si+=BLOCK_SIZE) {
            /* Iterate over the rows of B */
            for(int sk=0; sk<M; sk+=BLOCK_SIZE){
                do_block(si, sj, sk, A, B, C);
            }
        }
    }
}

/* Multiply two matrices using subword parallelism via AVX instructions
 * size of A is LxM
 * size of B is MxN
 * C should be allocated of size LxN
 */
void subword_parallelism_matrix_multiply(double **A, double **B, double **C, int L, int M, int N) {
    /* iterate over the rows of A */
    for(int i=0; i<L; i++) {
        /* Iterate over the columns of B */
        for(int j=0; j<N; j+=MM256_STRIDE) {
            // printf("starting vectorised section: %p. i %u, j %u \n", &C[i][j], i, j);
            __m256d c0 = _mm256_load_pd(&C[i][j]);
            /* Iterate over the rows of B */
            for(int k=0; k<M; k++){
                // printf("i %u j %u k %u\n", i, j, k);
                c0 = _mm256_add_pd(c0,
                                   _mm256_mul_pd(_mm256_load_pd(&B[k][j]), 
  		                   _mm256_broadcast_sd(&A[i][k])));
            }
	    // printf("Ending vectorised section: %p. \n", &C[i][j]);
	    _mm256_store_pd(&C[i][j], c0);
        }
    }
}


/* Optimized matrix multiplication combining multiple optimization techniques
 * size of A is LxM
 * size of B is MxN
 * C should be allocated of size LxN
 */
void optimized_matrix_multiply(double **A, double **B, double **C, int L, int M, int N) {
    // Define optimal block size based on benchmark data
    const int OPTIMAL_BLOCK_SIZE = 8;

    // Memory padding and alignment for better AVX performance
    // We use aligned_alloc for matrices A, B, C in the main function

    // Use OpenMP for parallelization across blocks
    #pragma omp parallel for num_threads(12)
    for(int si=0; si<L; si+=OPTIMAL_BLOCK_SIZE) {
        for(int sj=0; sj<N; sj+=OPTIMAL_BLOCK_SIZE) {
            // Process one block at a time for better cache usage
            for(int sk=0; sk<M; sk+=OPTIMAL_BLOCK_SIZE) {
                // Block boundaries with limit checking
                int imax = (si+OPTIMAL_BLOCK_SIZE < L) ? si+OPTIMAL_BLOCK_SIZE : L;
                int jmax = (sj+OPTIMAL_BLOCK_SIZE < N) ? sj+OPTIMAL_BLOCK_SIZE : N;
                int kmax = (sk+OPTIMAL_BLOCK_SIZE < M) ? sk+OPTIMAL_BLOCK_SIZE : M;

                // Process each block
                for(int i=si; i<imax; i++) {
                    for(int j=sj; j<jmax; j+=MM256_STRIDE) {
                        // Use AVX intrinsics for SIMD parallelism
                        __m256d c0 = _mm256_load_pd(&C[i][j]);

                        // Inner loop with unrolling factor of 4
                        for(int k=sk; k<kmax; k+=4) {
                            // Process 4 elements at once (loop unrolling)
                            for(int u=0; u<4 && k+u<kmax; u++) {
                                c0 = _mm256_add_pd(c0,
                                        _mm256_mul_pd(_mm256_load_pd(&B[k+u][j]),
                                        _mm256_broadcast_sd(&A[i][k+u])));
                            }
                        }

                        // Store the result back to memory
                        _mm256_store_pd(&C[i][j], c0);
                    }
                }
            }
        }
    }
}



/*
 * Free:
 * - A of size LxM
 * - B of size MxN
 * - C of size LxN
 */
void free_matrices(double **A, double **B, double **C, int L, int M, int N) {
    for(int i=0; i<L; i++) {
        free(A[i]);
        free(C[i]);
    }
    for(int i=0; i<M; i++) {
        free(B[i]);
    }
    free(A);
    free(B);
    free(C);
}

int main(int argc, char **argv) {

    // ######################################################
    // Read and check program arguments  
    // ######################################################
    int L, M, N, seed;
    double **A, **B, **C;
    struct timeval start, stop, total;

    if(argc != 5) {
        printf("ERROR: incorrect number of arguments\n");
        print_help_and_exit(argv);
    }

    L = atoi(argv[1]);
    M = atoi(argv[2]);
    N = atoi(argv[3]);
    seed = atoi(argv[4]);
    srand(seed);

    if( !L || !M || !N ) {
        printf("ERROR: invalid arguments\n");
        print_help_and_exit(argv);
    }
    
    // Set number of threads when using omp pragma
    omp_set_num_threads(OMP_THREADS);

    // ######################################################
    // Initialise datastructures
    // ######################################################
    // A: LxM matrix, i.e. L rows and M colums
    A = aligned_alloc(MEM_ALIGN, L * sizeof(double *));
    if(A == NULL) {
        printf("ERROR: cannot allocate memory for matrix A\n");
        return 0;
    }
    for(int i=0; i<L; i++) {
        A[i] = aligned_alloc(MEM_ALIGN, M * sizeof(double));
        if(A[i] == NULL) {
            printf("ERROR: cannot allocate memory for matrix A\n");
            return 0;
        }
    }

    // B: MxN matrix, i.e. M rows and N columns
    B = aligned_alloc(MEM_ALIGN, M * sizeof(double *));
    if(B == NULL) {
        printf("ERROR: cannot allocate memory for matrix B\n");
        return 0;
    }
    for(int i=0; i<M; i++) {
        B[i] = aligned_alloc(MEM_ALIGN, N * sizeof(double));
        if(B[i] == NULL) {
            printf("ERROR: cannot allocate memory for matrix B\n");
            return 0;
        }
    }

    for(int i=0; i<L; i++)
        for(int j=0; j<M; j++)
            A[i][j] = drand(MIN, MAX);

    for(int i=0; i<M; i++)
        for(int j=0; j<N; j++)
            B[i][j] = drand(MIN, MAX);

    // Allocate C matrix and initialise to zeros, its size will be LxN
    C = aligned_alloc(MEM_ALIGN, L * sizeof(double *));
    if(C == NULL) {
        printf("ERROR: cannot allocate memory for matrix C\n");
        return 0;
    }
    for(int i=0; i<L; i++) {
        C[i] = aligned_alloc(MEM_ALIGN, N * sizeof(double));
        if(C[i] == NULL) {
            printf("ERROR: cannot allocate memory for matrix C\n");
            return 0;
        }
        /* Initialise with zeros */
        for(int j=0; j<N; j++){
            C[i][j] = 0.0;    
	}
    }
    
    if (PRINT_MATRICES){	
        printf("\nMATRIX A:\n");
        print_matrix(A, L, M);

        printf("\nMATRIX B:\n");
        print_matrix(B, M, N);
        
        printf("\nMATRIX C (init to zero):\n");
        print_matrix(C, L, N);
    }
    
    // ######################################################
    // Perform matrix multiply
    // ######################################################
    gettimeofday(&start, NULL);

    // Call one of the matrix multiply functions below:
    //matrix_multiply(A, B, C, L, M, N);
    //unrolled_matrix_multiply(A, B, C, L, M, N);
    //multicore_matrix_multiply(A, B, C, L, M, N);
    //blocked_matrix_multiply(A, B, C, L, M, N);
    //subword_parallelism_matrix_multiply(A, B, C, L, M, N);
    optimized_matrix_multiply(A, B, C, L, M, N);

    gettimeofday(&stop, NULL);
    timersub(&stop, &start, &total);

    // ######################################################
    // Report performance and free datastructures
    // ###################################################### 
    if (PRINT_MATRICES){
        printf("\nOutput C:\n");
        print_matrix(C, L, N);
    }
    
    if (PRINT_MATRICES){
        // Reset C to zeros to enable calculation check
        for(int i=0; i<L; i++){
            for(int j=0; j<N; j++){
                C[i][j] = 0.0;    
            }
        }
        matrix_multiply(A, B, C, L, M, N);
        printf("\nBaseline Output C from matrix_multiply():\n");
        print_matrix(C, L, N);
        printf("\n");
    }
 
    // Print timing results
    printf("L = %u, M = %u, N = %u, EXEC TIME: %ld.%06ld\n", L, M, N, total.tv_sec, total.tv_usec);
    
    // Free datastructures
    free_matrices(A, B, C, L, M, N);

    return 0;
}

