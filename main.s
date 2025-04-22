	.file	"main.c"
# GNU C17 (Ubuntu 13.3.0-6ubuntu2~24.04) version 13.3.0 (x86_64-linux-gnu)
#	compiled by GNU C version 13.3.0, GMP version 6.3.0, MPFR version 4.2.1, MPC version 1.3.1, isl version isl-0.26-GMP

# GGC heuristics: --param ggc-min-expand=100 --param ggc-min-heapsize=131072
# options passed: -mavx -mtune=generic -march=x86-64 -fopenmp -fasynchronous-unwind-tables -fstack-protector-strong -fstack-clash-protection -fcf-protection
	.text
	.section	.rodata
.LC0:
	.string	"usage: %s <L> <M> <N> <seed>\n"
	.text
	.globl	print_help_and_exit
	.type	print_help_and_exit, @function
print_help_and_exit:
.LFB5039:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$16, %rsp	#,
	movq	%rdi, -8(%rbp)	# argv, argv
# main.c:18:     printf("usage: %s <L> <M> <N> <seed>\n", argv[0]);
	movq	-8(%rbp), %rax	# argv, tmp83
	movq	(%rax), %rax	# *argv_3(D), _1
	movq	%rax, %rsi	# _1,
	leaq	.LC0(%rip), %rax	#, tmp84
	movq	%rax, %rdi	# tmp84,
	movl	$0, %eax	#,
	call	printf@PLT	#
# main.c:19:     exit(0);
	movl	$0, %edi	#,
	call	exit@PLT	#
	.cfi_endproc
.LFE5039:
	.size	print_help_and_exit, .-print_help_and_exit
	.section	.rodata
.LC1:
	.string	"%f "
	.text
	.globl	print_matrix
	.type	print_matrix, @function
print_matrix:
.LFB5040:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$32, %rsp	#,
	movq	%rdi, -24(%rbp)	# mat, mat
	movl	%esi, -28(%rbp)	# rows, rows
	movl	%edx, -32(%rbp)	# cols, cols
# main.c:23:    for(int i=0; i<rows; i++) {
	movl	$0, -8(%rbp)	#, i
# main.c:23:    for(int i=0; i<rows; i++) {
	jmp	.L3	#
.L6:
# main.c:24:         for(int j=0; j<cols; j++){
	movl	$0, -4(%rbp)	#, j
# main.c:24:         for(int j=0; j<cols; j++){
	jmp	.L4	#
.L5:
# main.c:25:            printf("%f ", mat[i][j]);
	movl	-8(%rbp), %eax	# i, tmp90
	cltq
	leaq	0(,%rax,8), %rdx	#, _2
	movq	-24(%rbp), %rax	# mat, tmp91
	addq	%rdx, %rax	# _2, _3
	movq	(%rax), %rax	# *_3, _4
# main.c:25:            printf("%f ", mat[i][j]);
	movl	-4(%rbp), %edx	# j, tmp92
	movslq	%edx, %rdx	# tmp92, _5
	salq	$3, %rdx	#, _6
	addq	%rdx, %rax	# _6, _7
# main.c:25:            printf("%f ", mat[i][j]);
	movq	(%rax), %rax	# *_7, _8
	vmovq	%rax, %xmm0	# _8,
	leaq	.LC1(%rip), %rax	#, tmp93
	movq	%rax, %rdi	# tmp93,
	movl	$1, %eax	#,
	call	printf@PLT	#
# main.c:24:         for(int j=0; j<cols; j++){
	addl	$1, -4(%rbp)	#, j
.L4:
# main.c:24:         for(int j=0; j<cols; j++){
	movl	-4(%rbp), %eax	# j, tmp94
	cmpl	-32(%rbp), %eax	# cols, tmp94
	jl	.L5	#,
# main.c:27:         printf("\n");
	movl	$10, %edi	#,
	call	putchar@PLT	#
# main.c:23:    for(int i=0; i<rows; i++) {
	addl	$1, -8(%rbp)	#, i
.L3:
# main.c:23:    for(int i=0; i<rows; i++) {
	movl	-8(%rbp), %eax	# i, tmp95
	cmpl	-28(%rbp), %eax	# rows, tmp95
	jl	.L6	#,
# main.c:29: }
	nop	
	nop	
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE5040:
	.size	print_matrix, .-print_matrix
	.globl	drand
	.type	drand, @function
drand:
.LFB5041:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$32, %rsp	#,
	vmovsd	%xmm0, -24(%rbp)	# min, min
	vmovsd	%xmm1, -32(%rbp)	# max, max
# main.c:32:     double random_double = (double) rand() / RAND_MAX; 
	call	rand@PLT	#
# main.c:32:     double random_double = (double) rand() / RAND_MAX; 
	vcvtsi2sdl	%eax, %xmm0, %xmm0	# _1, _2
# main.c:32:     double random_double = (double) rand() / RAND_MAX; 
	vmovsd	.LC2(%rip), %xmm1	#, tmp89
	vdivsd	%xmm1, %xmm0, %xmm0	# tmp89, _2, tmp88
	vmovsd	%xmm0, -8(%rbp)	# tmp88, random_double
# main.c:33:     random_double = (random_double * (max - min)) + min;
	vmovsd	-32(%rbp), %xmm0	# max, tmp90
	vsubsd	-24(%rbp), %xmm0, %xmm0	# min, tmp90, _3
# main.c:33:     random_double = (random_double * (max - min)) + min;
	vmulsd	-8(%rbp), %xmm0, %xmm0	# random_double, _3, _4
# main.c:33:     random_double = (random_double * (max - min)) + min;
	vmovsd	-24(%rbp), %xmm1	# min, tmp92
	vaddsd	%xmm0, %xmm1, %xmm0	# _4, tmp92, tmp91
	vmovsd	%xmm0, -8(%rbp)	# tmp91, random_double
# main.c:34:     return random_double;
	vmovsd	-8(%rbp), %xmm0	# random_double, _11
# main.c:35: }
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE5041:
	.size	drand, .-drand
	.globl	matrix_multiply
	.type	matrix_multiply, @function
matrix_multiply:
.LFB5042:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)	# A, A
	movq	%rsi, -32(%rbp)	# B, B
	movq	%rdx, -40(%rbp)	# C, C
	movl	%ecx, -44(%rbp)	# L, L
	movl	%r8d, -48(%rbp)	# M, M
	movl	%r9d, -52(%rbp)	# N, N
# main.c:44:     for(int i=0; i<L; i++) {
	movl	$0, -12(%rbp)	#, i
# main.c:44:     for(int i=0; i<L; i++) {
	jmp	.L10	#
.L15:
# main.c:46:         for(int j=0; j<N; j++) {
	movl	$0, -8(%rbp)	#, j
# main.c:46:         for(int j=0; j<N; j++) {
	jmp	.L11	#
.L14:
# main.c:48:             for(int k=0; k<M; k++){
	movl	$0, -4(%rbp)	#, k
# main.c:48:             for(int k=0; k<M; k++){
	jmp	.L12	#
.L13:
# main.c:49:                 C[i][j] += A[i][k] * B[k][j];
	movl	-12(%rbp), %eax	# i, tmp115
	cltq
	leaq	0(,%rax,8), %rdx	#, _2
	movq	-40(%rbp), %rax	# C, tmp116
	addq	%rdx, %rax	# _2, _3
	movq	(%rax), %rax	# *_3, _4
# main.c:49:                 C[i][j] += A[i][k] * B[k][j];
	movl	-8(%rbp), %edx	# j, tmp117
	movslq	%edx, %rdx	# tmp117, _5
	salq	$3, %rdx	#, _6
	addq	%rdx, %rax	# _6, _7
	vmovsd	(%rax), %xmm1	# *_7, _8
# main.c:49:                 C[i][j] += A[i][k] * B[k][j];
	movl	-12(%rbp), %eax	# i, tmp118
	cltq
	leaq	0(,%rax,8), %rdx	#, _10
	movq	-24(%rbp), %rax	# A, tmp119
	addq	%rdx, %rax	# _10, _11
	movq	(%rax), %rax	# *_11, _12
# main.c:49:                 C[i][j] += A[i][k] * B[k][j];
	movl	-4(%rbp), %edx	# k, tmp120
	movslq	%edx, %rdx	# tmp120, _13
	salq	$3, %rdx	#, _14
	addq	%rdx, %rax	# _14, _15
	vmovsd	(%rax), %xmm2	# *_15, _16
# main.c:49:                 C[i][j] += A[i][k] * B[k][j];
	movl	-4(%rbp), %eax	# k, tmp121
	cltq
	leaq	0(,%rax,8), %rdx	#, _18
	movq	-32(%rbp), %rax	# B, tmp122
	addq	%rdx, %rax	# _18, _19
	movq	(%rax), %rax	# *_19, _20
# main.c:49:                 C[i][j] += A[i][k] * B[k][j];
	movl	-8(%rbp), %edx	# j, tmp123
	movslq	%edx, %rdx	# tmp123, _21
	salq	$3, %rdx	#, _22
	addq	%rdx, %rax	# _22, _23
	vmovsd	(%rax), %xmm0	# *_23, _24
# main.c:49:                 C[i][j] += A[i][k] * B[k][j];
	vmulsd	%xmm0, %xmm2, %xmm0	# _24, _16, _25
# main.c:49:                 C[i][j] += A[i][k] * B[k][j];
	movl	-12(%rbp), %eax	# i, tmp124
	cltq
	leaq	0(,%rax,8), %rdx	#, _27
	movq	-40(%rbp), %rax	# C, tmp125
	addq	%rdx, %rax	# _27, _28
	movq	(%rax), %rax	# *_28, _29
# main.c:49:                 C[i][j] += A[i][k] * B[k][j];
	movl	-8(%rbp), %edx	# j, tmp126
	movslq	%edx, %rdx	# tmp126, _30
	salq	$3, %rdx	#, _31
	addq	%rdx, %rax	# _31, _32
# main.c:49:                 C[i][j] += A[i][k] * B[k][j];
	vaddsd	%xmm0, %xmm1, %xmm0	# _25, _8, _33
	vmovsd	%xmm0, (%rax)	# _33, *_32
# main.c:48:             for(int k=0; k<M; k++){
	addl	$1, -4(%rbp)	#, k
.L12:
# main.c:48:             for(int k=0; k<M; k++){
	movl	-4(%rbp), %eax	# k, tmp127
	cmpl	-48(%rbp), %eax	# M, tmp127
	jl	.L13	#,
# main.c:46:         for(int j=0; j<N; j++) {
	addl	$1, -8(%rbp)	#, j
.L11:
# main.c:46:         for(int j=0; j<N; j++) {
	movl	-8(%rbp), %eax	# j, tmp128
	cmpl	-52(%rbp), %eax	# N, tmp128
	jl	.L14	#,
# main.c:44:     for(int i=0; i<L; i++) {
	addl	$1, -12(%rbp)	#, i
.L10:
# main.c:44:     for(int i=0; i<L; i++) {
	movl	-12(%rbp), %eax	# i, tmp129
	cmpl	-44(%rbp), %eax	# L, tmp129
	jl	.L15	#,
# main.c:53: }
	nop	
	nop	
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE5042:
	.size	matrix_multiply, .-matrix_multiply
	.globl	unrolled_matrix_multiply
	.type	unrolled_matrix_multiply, @function
unrolled_matrix_multiply:
.LFB5043:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	addq	$-128, %rsp	#,
	movq	%rdi, -88(%rbp)	# A, A
	movq	%rsi, -96(%rbp)	# B, B
	movq	%rdx, -104(%rbp)	# C, C
	movl	%ecx, -108(%rbp)	# L, L
	movl	%r8d, -112(%rbp)	# M, M
	movl	%r9d, -116(%rbp)	# N, N
# main.c:60: void unrolled_matrix_multiply(double **A, double **B, double **C, int L, int M, int N) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp146
	movq	%rax, -8(%rbp)	# tmp146, D.31561
	xorl	%eax, %eax	# tmp146
# main.c:62:     for(int i=0; i<L; i++) {
	movl	$0, -72(%rbp)	#, i
# main.c:62:     for(int i=0; i<L; i++) {
	jmp	.L17	#
.L28:
# main.c:64:         for(int j=0; j<N; j+=UNROLL) {
	movl	$0, -68(%rbp)	#, j
# main.c:64:         for(int j=0; j<N; j+=UNROLL) {
	jmp	.L18	#
.L27:
# main.c:66: 	    for (int u=0; u<UNROLL; u++){
	movl	$0, -64(%rbp)	#, u
# main.c:66: 	    for (int u=0; u<UNROLL; u++){
	jmp	.L19	#
.L20:
# main.c:67:                 C_temp[u] = C[i][j+u];
	movl	-72(%rbp), %eax	# i, tmp120
	cltq
	leaq	0(,%rax,8), %rdx	#, _2
	movq	-104(%rbp), %rax	# C, tmp121
	addq	%rdx, %rax	# _2, _3
	movq	(%rax), %rax	# *_3, _4
# main.c:67:                 C_temp[u] = C[i][j+u];
	movl	-68(%rbp), %ecx	# j, tmp122
	movl	-64(%rbp), %edx	# u, tmp123
	addl	%ecx, %edx	# tmp122, _5
	movslq	%edx, %rdx	# _5, _6
# main.c:67:                 C_temp[u] = C[i][j+u];
	salq	$3, %rdx	#, _7
	addq	%rdx, %rax	# _7, _8
	vmovsd	(%rax), %xmm0	# *_8, _9
# main.c:67:                 C_temp[u] = C[i][j+u];
	movl	-64(%rbp), %eax	# u, tmp125
	cltq
	vmovsd	%xmm0, -48(%rbp,%rax,8)	# _9, C_temp[u_41]
# main.c:66: 	    for (int u=0; u<UNROLL; u++){
	addl	$1, -64(%rbp)	#, u
.L19:
# main.c:66: 	    for (int u=0; u<UNROLL; u++){
	cmpl	$3, -64(%rbp)	#, u
	jle	.L20	#,
# main.c:69: 	    for (int u=0; u<UNROLL; u++){
	movl	$0, -60(%rbp)	#, u
# main.c:69: 	    for (int u=0; u<UNROLL; u++){
	jmp	.L21	#
.L24:
# main.c:71:             	for(int k=0; k<M; k++){
	movl	$0, -56(%rbp)	#, k
# main.c:71:             	for(int k=0; k<M; k++){
	jmp	.L22	#
.L23:
# main.c:72:                     C_temp[u] += A[i][k] * B[k][j+u];
	movl	-60(%rbp), %eax	# u, tmp127
	cltq
	vmovsd	-48(%rbp,%rax,8), %xmm1	# C_temp[u_42], _10
# main.c:72:                     C_temp[u] += A[i][k] * B[k][j+u];
	movl	-72(%rbp), %eax	# i, tmp128
	cltq
	leaq	0(,%rax,8), %rdx	#, _12
	movq	-88(%rbp), %rax	# A, tmp129
	addq	%rdx, %rax	# _12, _13
	movq	(%rax), %rax	# *_13, _14
# main.c:72:                     C_temp[u] += A[i][k] * B[k][j+u];
	movl	-56(%rbp), %edx	# k, tmp130
	movslq	%edx, %rdx	# tmp130, _15
	salq	$3, %rdx	#, _16
	addq	%rdx, %rax	# _16, _17
	vmovsd	(%rax), %xmm2	# *_17, _18
# main.c:72:                     C_temp[u] += A[i][k] * B[k][j+u];
	movl	-56(%rbp), %eax	# k, tmp131
	cltq
	leaq	0(,%rax,8), %rdx	#, _20
	movq	-96(%rbp), %rax	# B, tmp132
	addq	%rdx, %rax	# _20, _21
	movq	(%rax), %rax	# *_21, _22
# main.c:72:                     C_temp[u] += A[i][k] * B[k][j+u];
	movl	-68(%rbp), %ecx	# j, tmp133
	movl	-60(%rbp), %edx	# u, tmp134
	addl	%ecx, %edx	# tmp133, _23
	movslq	%edx, %rdx	# _23, _24
# main.c:72:                     C_temp[u] += A[i][k] * B[k][j+u];
	salq	$3, %rdx	#, _25
	addq	%rdx, %rax	# _25, _26
	vmovsd	(%rax), %xmm0	# *_26, _27
# main.c:72:                     C_temp[u] += A[i][k] * B[k][j+u];
	vmulsd	%xmm0, %xmm2, %xmm0	# _27, _18, _28
# main.c:72:                     C_temp[u] += A[i][k] * B[k][j+u];
	vaddsd	%xmm0, %xmm1, %xmm0	# _28, _10, _29
	movl	-60(%rbp), %eax	# u, tmp136
	cltq
	vmovsd	%xmm0, -48(%rbp,%rax,8)	# _29, C_temp[u_42]
# main.c:71:             	for(int k=0; k<M; k++){
	addl	$1, -56(%rbp)	#, k
.L22:
# main.c:71:             	for(int k=0; k<M; k++){
	movl	-56(%rbp), %eax	# k, tmp137
	cmpl	-112(%rbp), %eax	# M, tmp137
	jl	.L23	#,
# main.c:69: 	    for (int u=0; u<UNROLL; u++){
	addl	$1, -60(%rbp)	#, u
.L21:
# main.c:69: 	    for (int u=0; u<UNROLL; u++){
	cmpl	$3, -60(%rbp)	#, u
	jle	.L24	#,
# main.c:75: 	    for (int u=0; u<UNROLL; u++){
	movl	$0, -52(%rbp)	#, u
# main.c:75: 	    for (int u=0; u<UNROLL; u++){
	jmp	.L25	#
.L26:
# main.c:76: 	        C[i][j+u] = C_temp[u];
	movl	-72(%rbp), %eax	# i, tmp138
	cltq
	leaq	0(,%rax,8), %rdx	#, _31
	movq	-104(%rbp), %rax	# C, tmp139
	addq	%rdx, %rax	# _31, _32
	movq	(%rax), %rax	# *_32, _33
# main.c:76: 	        C[i][j+u] = C_temp[u];
	movl	-68(%rbp), %ecx	# j, tmp140
	movl	-52(%rbp), %edx	# u, tmp141
	addl	%ecx, %edx	# tmp140, _34
	movslq	%edx, %rdx	# _34, _35
# main.c:76: 	        C[i][j+u] = C_temp[u];
	salq	$3, %rdx	#, _36
	addq	%rax, %rdx	# _33, _37
# main.c:76: 	        C[i][j+u] = C_temp[u];
	movl	-52(%rbp), %eax	# u, tmp143
	cltq
	vmovsd	-48(%rbp,%rax,8), %xmm0	# C_temp[u_44], _38
# main.c:76: 	        C[i][j+u] = C_temp[u];
	vmovsd	%xmm0, (%rdx)	# _38, *_37
# main.c:75: 	    for (int u=0; u<UNROLL; u++){
	addl	$1, -52(%rbp)	#, u
.L25:
# main.c:75: 	    for (int u=0; u<UNROLL; u++){
	cmpl	$3, -52(%rbp)	#, u
	jle	.L26	#,
# main.c:64:         for(int j=0; j<N; j+=UNROLL) {
	addl	$4, -68(%rbp)	#, j
.L18:
# main.c:64:         for(int j=0; j<N; j+=UNROLL) {
	movl	-68(%rbp), %eax	# j, tmp144
	cmpl	-116(%rbp), %eax	# N, tmp144
	jl	.L27	#,
# main.c:62:     for(int i=0; i<L; i++) {
	addl	$1, -72(%rbp)	#, i
.L17:
# main.c:62:     for(int i=0; i<L; i++) {
	movl	-72(%rbp), %eax	# i, tmp145
	cmpl	-108(%rbp), %eax	# L, tmp145
	jl	.L28	#,
# main.c:80: }
	nop	
	movq	-8(%rbp), %rax	# D.31561, tmp147
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp147
	je	.L29	#,
	call	__stack_chk_fail@PLT	#
.L29:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE5043:
	.size	unrolled_matrix_multiply, .-unrolled_matrix_multiply
	.globl	multicore_matrix_multiply
	.type	multicore_matrix_multiply, @function
multicore_matrix_multiply:
.LFB5044:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$96, %rsp	#,
	movq	%rdi, -56(%rbp)	# A, A
	movq	%rsi, -64(%rbp)	# B, B
	movq	%rdx, -72(%rbp)	# C, C
	movl	%ecx, -76(%rbp)	# L, L
	movl	%r8d, -80(%rbp)	# M, M
	movl	%r9d, -84(%rbp)	# N, N
# main.c:87: void multicore_matrix_multiply(double **A, double **B, double **C, int L, int M, int N) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp90
	movq	%rax, -8(%rbp)	# tmp90, D.31563
	xorl	%eax, %eax	# tmp90
# main.c:88:     #pragma omp parallel for
	movl	-84(%rbp), %eax	# N, tmp82
	movl	%eax, -16(%rbp)	# tmp82, .omp_data_o.2.N
	movl	-80(%rbp), %eax	# M, tmp83
	movl	%eax, -20(%rbp)	# tmp83, .omp_data_o.2.M
	movl	-76(%rbp), %eax	# L, tmp84
	movl	%eax, -24(%rbp)	# tmp84, .omp_data_o.2.L
	movq	-72(%rbp), %rax	# C, tmp85
	movq	%rax, -32(%rbp)	# tmp85, .omp_data_o.2.C
	movq	-64(%rbp), %rax	# B, tmp86
	movq	%rax, -40(%rbp)	# tmp86, .omp_data_o.2.B
	movq	-56(%rbp), %rax	# A, tmp87
	movq	%rax, -48(%rbp)	# tmp87, .omp_data_o.2.A
	leaq	-48(%rbp), %rax	#, tmp88
	movl	$0, %ecx	#,
	movl	$0, %edx	#,
	movq	%rax, %rsi	# tmp88,
	leaq	multicore_matrix_multiply._omp_fn.0(%rip), %rax	#, tmp89
	movq	%rax, %rdi	# tmp89,
	call	GOMP_parallel@PLT	#
# main.c:99: }
	nop	
	movq	-8(%rbp), %rax	# D.31563, tmp91
	subq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp91
	je	.L31	#,
	call	__stack_chk_fail@PLT	#
.L31:
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE5044:
	.size	multicore_matrix_multiply, .-multicore_matrix_multiply
	.globl	do_block
	.type	do_block, @function
do_block:
.LFB5045:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	movl	%edi, -36(%rbp)	# si, si
	movl	%esi, -40(%rbp)	# sj, sj
	movl	%edx, -44(%rbp)	# sk, sk
	movq	%rcx, -56(%rbp)	# A, A
	movq	%r8, -64(%rbp)	# B, B
	movq	%r9, -72(%rbp)	# C, C
# main.c:103:     for (int i=si; i<si+BLOCK_SIZE; i++){
	movl	-36(%rbp), %eax	# si, tmp116
	movl	%eax, -20(%rbp)	# tmp116, i
# main.c:103:     for (int i=si; i<si+BLOCK_SIZE; i++){
	jmp	.L33	#
.L38:
# main.c:104:         for (int j=sj; j<sj+BLOCK_SIZE; j++){
	movl	-40(%rbp), %eax	# sj, tmp117
	movl	%eax, -16(%rbp)	# tmp117, j
# main.c:104:         for (int j=sj; j<sj+BLOCK_SIZE; j++){
	jmp	.L34	#
.L37:
# main.c:105: 	    double C_ij = C[i][j];
	movl	-20(%rbp), %eax	# i, tmp118
	cltq
	leaq	0(,%rax,8), %rdx	#, _2
	movq	-72(%rbp), %rax	# C, tmp119
	addq	%rdx, %rax	# _2, _3
	movq	(%rax), %rax	# *_3, _4
# main.c:105: 	    double C_ij = C[i][j];
	movl	-16(%rbp), %edx	# j, tmp120
	movslq	%edx, %rdx	# tmp120, _5
	salq	$3, %rdx	#, _6
	addq	%rdx, %rax	# _6, _7
# main.c:105: 	    double C_ij = C[i][j];
	vmovsd	(%rax), %xmm0	# *_7, tmp121
	vmovsd	%xmm0, -8(%rbp)	# tmp121, C_ij
# main.c:106:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	movl	-44(%rbp), %eax	# sk, tmp122
	movl	%eax, -12(%rbp)	# tmp122, k
# main.c:106:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	jmp	.L35	#
.L36:
# main.c:108: 		C_ij += A[i][k] * B[k][j]; 
	movl	-20(%rbp), %eax	# i, tmp123
	cltq
	leaq	0(,%rax,8), %rdx	#, _9
	movq	-56(%rbp), %rax	# A, tmp124
	addq	%rdx, %rax	# _9, _10
	movq	(%rax), %rax	# *_10, _11
# main.c:108: 		C_ij += A[i][k] * B[k][j]; 
	movl	-12(%rbp), %edx	# k, tmp125
	movslq	%edx, %rdx	# tmp125, _12
	salq	$3, %rdx	#, _13
	addq	%rdx, %rax	# _13, _14
	vmovsd	(%rax), %xmm1	# *_14, _15
# main.c:108: 		C_ij += A[i][k] * B[k][j]; 
	movl	-12(%rbp), %eax	# k, tmp126
	cltq
	leaq	0(,%rax,8), %rdx	#, _17
	movq	-64(%rbp), %rax	# B, tmp127
	addq	%rdx, %rax	# _17, _18
	movq	(%rax), %rax	# *_18, _19
# main.c:108: 		C_ij += A[i][k] * B[k][j]; 
	movl	-16(%rbp), %edx	# j, tmp128
	movslq	%edx, %rdx	# tmp128, _20
	salq	$3, %rdx	#, _21
	addq	%rdx, %rax	# _21, _22
	vmovsd	(%rax), %xmm0	# *_22, _23
# main.c:108: 		C_ij += A[i][k] * B[k][j]; 
	vmulsd	%xmm0, %xmm1, %xmm0	# _23, _15, _24
# main.c:108: 		C_ij += A[i][k] * B[k][j]; 
	vmovsd	-8(%rbp), %xmm1	# C_ij, tmp130
	vaddsd	%xmm0, %xmm1, %xmm0	# _24, tmp130, tmp129
	vmovsd	%xmm0, -8(%rbp)	# tmp129, C_ij
# main.c:106:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	addl	$1, -12(%rbp)	#, k
.L35:
# main.c:106:             for (int k=sk; k<sk+BLOCK_SIZE; k++){
	movl	-44(%rbp), %eax	# sk, tmp131
	addl	$31, %eax	#, _25
	cmpl	%eax, -12(%rbp)	# _25, k
	jle	.L36	#,
# main.c:110:             C[i][j] = C_ij;
	movl	-20(%rbp), %eax	# i, tmp132
	cltq
	leaq	0(,%rax,8), %rdx	#, _27
	movq	-72(%rbp), %rax	# C, tmp133
	addq	%rdx, %rax	# _27, _28
	movq	(%rax), %rax	# *_28, _29
# main.c:110:             C[i][j] = C_ij;
	movl	-16(%rbp), %edx	# j, tmp134
	movslq	%edx, %rdx	# tmp134, _30
	salq	$3, %rdx	#, _31
	addq	%rdx, %rax	# _31, _32
# main.c:110:             C[i][j] = C_ij;
	vmovsd	-8(%rbp), %xmm0	# C_ij, tmp135
	vmovsd	%xmm0, (%rax)	# tmp135, *_32
# main.c:104:         for (int j=sj; j<sj+BLOCK_SIZE; j++){
	addl	$1, -16(%rbp)	#, j
.L34:
# main.c:104:         for (int j=sj; j<sj+BLOCK_SIZE; j++){
	movl	-40(%rbp), %eax	# sj, tmp136
	addl	$31, %eax	#, _33
	cmpl	%eax, -16(%rbp)	# _33, j
	jle	.L37	#,
# main.c:103:     for (int i=si; i<si+BLOCK_SIZE; i++){
	addl	$1, -20(%rbp)	#, i
.L33:
# main.c:103:     for (int i=si; i<si+BLOCK_SIZE; i++){
	movl	-36(%rbp), %eax	# si, tmp137
	addl	$31, %eax	#, _34
	cmpl	%eax, -20(%rbp)	# _34, i
	jle	.L38	#,
# main.c:113: }
	nop	
	nop	
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE5045:
	.size	do_block, .-do_block
	.globl	blocked_matrix_multiply
	.type	blocked_matrix_multiply, @function
blocked_matrix_multiply:
.LFB5046:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$56, %rsp	#,
	movq	%rdi, -24(%rbp)	# A, A
	movq	%rsi, -32(%rbp)	# B, B
	movq	%rdx, -40(%rbp)	# C, C
	movl	%ecx, -44(%rbp)	# L, L
	movl	%r8d, -48(%rbp)	# M, M
	movl	%r9d, -52(%rbp)	# N, N
# main.c:122:     for(int sj=0; sj<L; sj+=BLOCK_SIZE) {
	movl	$0, -12(%rbp)	#, sj
# main.c:122:     for(int sj=0; sj<L; sj+=BLOCK_SIZE) {
	jmp	.L40	#
.L45:
# main.c:124:         for(int si=0; si<N; si+=BLOCK_SIZE) {
	movl	$0, -8(%rbp)	#, si
# main.c:124:         for(int si=0; si<N; si+=BLOCK_SIZE) {
	jmp	.L41	#
.L44:
# main.c:126:             for(int sk=0; sk<M; sk+=BLOCK_SIZE){
	movl	$0, -4(%rbp)	#, sk
# main.c:126:             for(int sk=0; sk<M; sk+=BLOCK_SIZE){
	jmp	.L42	#
.L43:
# main.c:127:                 do_block(si, sj, sk, A, B, C);
	movq	-40(%rbp), %r8	# C, tmp82
	movq	-32(%rbp), %rdi	# B, tmp83
	movq	-24(%rbp), %rcx	# A, tmp84
	movl	-4(%rbp), %edx	# sk, tmp85
	movl	-12(%rbp), %esi	# sj, tmp86
	movl	-8(%rbp), %eax	# si, tmp87
	movq	%r8, %r9	# tmp82,
	movq	%rdi, %r8	# tmp83,
	movl	%eax, %edi	# tmp87,
	call	do_block	#
# main.c:126:             for(int sk=0; sk<M; sk+=BLOCK_SIZE){
	addl	$32, -4(%rbp)	#, sk
.L42:
# main.c:126:             for(int sk=0; sk<M; sk+=BLOCK_SIZE){
	movl	-4(%rbp), %eax	# sk, tmp88
	cmpl	-48(%rbp), %eax	# M, tmp88
	jl	.L43	#,
# main.c:124:         for(int si=0; si<N; si+=BLOCK_SIZE) {
	addl	$32, -8(%rbp)	#, si
.L41:
# main.c:124:         for(int si=0; si<N; si+=BLOCK_SIZE) {
	movl	-8(%rbp), %eax	# si, tmp89
	cmpl	-52(%rbp), %eax	# N, tmp89
	jl	.L44	#,
# main.c:122:     for(int sj=0; sj<L; sj+=BLOCK_SIZE) {
	addl	$32, -12(%rbp)	#, sj
.L40:
# main.c:122:     for(int sj=0; sj<L; sj+=BLOCK_SIZE) {
	movl	-12(%rbp), %eax	# sj, tmp90
	cmpl	-44(%rbp), %eax	# L, tmp90
	jl	.L45	#,
# main.c:131: }
	nop	
	nop	
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE5046:
	.size	blocked_matrix_multiply, .-blocked_matrix_multiply
	.globl	subword_parallelism_matrix_multiply
	.type	subword_parallelism_matrix_multiply, @function
subword_parallelism_matrix_multiply:
.LFB5047:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	andq	$-32, %rsp	#,
	subq	$168, %rsp	#,
	movq	%rdi, -80(%rsp)	# A, A
	movq	%rsi, -88(%rsp)	# B, B
	movq	%rdx, -96(%rsp)	# C, C
	movl	%ecx, -100(%rsp)	# L, L
	movl	%r8d, -104(%rsp)	# M, M
	movl	%r9d, -108(%rsp)	# N, N
# main.c:140:     for(int i=0; i<L; i++) {
	movl	$0, -68(%rsp)	#, i
# main.c:140:     for(int i=0; i<L; i++) {
	jmp	.L47	#
.L57:
# main.c:142:         for(int j=0; j<N; j+=MM256_STRIDE) {
	movl	$0, -64(%rsp)	#, j
# main.c:142:         for(int j=0; j<N; j+=MM256_STRIDE) {
	jmp	.L48	#
.L56:
# main.c:144:             __m256d c0 = _mm256_load_pd(&C[i][j]);
	movl	-68(%rsp), %eax	# i, tmp115
	cltq
	leaq	0(,%rax,8), %rdx	#, _2
	movq	-96(%rsp), %rax	# C, tmp116
	addq	%rdx, %rax	# _2, _3
	movq	(%rax), %rax	# *_3, _4
# main.c:144:             __m256d c0 = _mm256_load_pd(&C[i][j]);
	movl	-64(%rsp), %edx	# j, tmp117
	movslq	%edx, %rdx	# tmp117, _5
	salq	$3, %rdx	#, _6
# main.c:144:             __m256d c0 = _mm256_load_pd(&C[i][j]);
	addq	%rdx, %rax	# _6, _7
	movq	%rax, -56(%rsp)	# _7, __P
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	-56(%rsp), %rax	# __P, tmp118
	vmovapd	(%rax), %ymm0	# MEM[(__m256d * {ref-all})__P_54], D.31536
# main.c:144:             __m256d c0 = _mm256_load_pd(&C[i][j]);
	vmovapd	%ymm0, -24(%rsp)	# D.31536, c0
# main.c:146:             for(int k=0; k<M; k++){
	movl	$0, -60(%rsp)	#, k
# main.c:146:             for(int k=0; k<M; k++){
	jmp	.L50	#
.L55:
# main.c:150:   		                   _mm256_broadcast_sd(&A[i][k])));
	movl	-68(%rsp), %eax	# i, tmp119
	cltq
	leaq	0(,%rax,8), %rdx	#, _9
	movq	-80(%rsp), %rax	# A, tmp120
	addq	%rdx, %rax	# _9, _10
	movq	(%rax), %rax	# *_10, _11
# main.c:150:   		                   _mm256_broadcast_sd(&A[i][k])));
	movl	-60(%rsp), %edx	# k, tmp121
	movslq	%edx, %rdx	# tmp121, _12
	salq	$3, %rdx	#, _13
# main.c:150:   		                   _mm256_broadcast_sd(&A[i][k])));
	addq	%rdx, %rax	# _13, _14
	movq	%rax, -40(%rsp)	# _14, __X
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	movq	-40(%rsp), %rax	# __X, tmp122
	vbroadcastsd	(%rax), %ymm0	#, D.31554
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:736:   return (__m256d) __builtin_ia32_vbroadcastsd256 (__X);
	nop	
# main.c:149:                                    _mm256_mul_pd(_mm256_load_pd(&B[k][j]), 
	movl	-60(%rsp), %eax	# k, tmp123
	cltq
	leaq	0(,%rax,8), %rdx	#, _17
	movq	-88(%rsp), %rax	# B, tmp124
	addq	%rdx, %rax	# _17, _18
	movq	(%rax), %rax	# *_18, _19
# main.c:149:                                    _mm256_mul_pd(_mm256_load_pd(&B[k][j]), 
	movl	-64(%rsp), %edx	# j, tmp125
	movslq	%edx, %rdx	# tmp125, _20
	salq	$3, %rdx	#, _21
# main.c:149:                                    _mm256_mul_pd(_mm256_load_pd(&B[k][j]), 
	addq	%rdx, %rax	# _21, _22
	movq	%rax, -48(%rsp)	# _22, __P
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:869:   return *(__m256d *)__P;
	movq	-48(%rsp), %rax	# __P, tmp126
	vmovapd	(%rax), %ymm1	# MEM[(__m256d * {ref-all})__P_62], D.31550
	vmovapd	%ymm1, 72(%rsp)	# D.31550, __A
	vmovapd	%ymm0, 104(%rsp)	# D.31554, __B
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:314:   return (__m256d) ((__v4df)__A * (__v4df)__B);
	vmovapd	72(%rsp), %ymm0	# __A, tmp127
	vmulpd	104(%rsp), %ymm0, %ymm0	# __B, tmp127, D.31546
	vmovapd	-24(%rsp), %ymm1	# c0, tmp128
	vmovapd	%ymm1, 8(%rsp)	# tmp128, __A
	vmovapd	%ymm0, 40(%rsp)	# D.31546, __B
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:143:   return (__m256d) ((__v4df)__A + (__v4df)__B);
	vmovapd	8(%rsp), %ymm0	# __A, tmp129
	vaddpd	40(%rsp), %ymm0, %ymm0	# __B, tmp129, D.31541
# main.c:148:                 c0 = _mm256_add_pd(c0,
	vmovapd	%ymm0, -24(%rsp)	# D.31541, c0
# main.c:146:             for(int k=0; k<M; k++){
	addl	$1, -60(%rsp)	#, k
.L50:
# main.c:146:             for(int k=0; k<M; k++){
	movl	-60(%rsp), %eax	# k, tmp130
	cmpl	-104(%rsp), %eax	# M, tmp130
	jl	.L55	#,
# main.c:153: 	    _mm256_store_pd(&C[i][j], c0);
	movl	-68(%rsp), %eax	# i, tmp131
	cltq
	leaq	0(,%rax,8), %rdx	#, _26
	movq	-96(%rsp), %rax	# C, tmp132
	addq	%rdx, %rax	# _26, _27
	movq	(%rax), %rax	# *_27, _28
# main.c:153: 	    _mm256_store_pd(&C[i][j], c0);
	movl	-64(%rsp), %edx	# j, tmp133
	movslq	%edx, %rdx	# tmp133, _29
	salq	$3, %rdx	#, _30
# main.c:153: 	    _mm256_store_pd(&C[i][j], c0);
	addq	%rdx, %rax	# _30, _31
	movq	%rax, -32(%rsp)	# _31, __P
	vmovapd	-24(%rsp), %ymm0	# c0, tmp134
	vmovapd	%ymm0, 136(%rsp)	# tmp134, __A
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:875:   *(__m256d *)__P = __A;
	movq	-32(%rsp), %rax	# __P, tmp135
	vmovapd	136(%rsp), %ymm0	# __A, tmp136
	vmovapd	%ymm0, (%rax)	# tmp136, MEM[(__m256d * {ref-all})__P_66]
# /usr/lib/gcc/x86_64-linux-gnu/13/include/avxintrin.h:876: }
	nop	
# main.c:142:         for(int j=0; j<N; j+=MM256_STRIDE) {
	addl	$4, -64(%rsp)	#, j
.L48:
# main.c:142:         for(int j=0; j<N; j+=MM256_STRIDE) {
	movl	-64(%rsp), %eax	# j, tmp137
	cmpl	-108(%rsp), %eax	# N, tmp137
	jl	.L56	#,
# main.c:140:     for(int i=0; i<L; i++) {
	addl	$1, -68(%rsp)	#, i
.L47:
# main.c:140:     for(int i=0; i<L; i++) {
	movl	-68(%rsp), %eax	# i, tmp138
	cmpl	-100(%rsp), %eax	# L, tmp138
	jl	.L57	#,
# main.c:156: }
	nop	
	nop	
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE5047:
	.size	subword_parallelism_matrix_multiply, .-subword_parallelism_matrix_multiply
	.globl	free_matrices
	.type	free_matrices, @function
free_matrices:
.LFB5048:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	subq	$64, %rsp	#,
	movq	%rdi, -24(%rbp)	# A, A
	movq	%rsi, -32(%rbp)	# B, B
	movq	%rdx, -40(%rbp)	# C, C
	movl	%ecx, -44(%rbp)	# L, L
	movl	%r8d, -48(%rbp)	# M, M
	movl	%r9d, -52(%rbp)	# N, N
# main.c:165:     for(int i=0; i<L; i++) {
	movl	$0, -8(%rbp)	#, i
# main.c:165:     for(int i=0; i<L; i++) {
	jmp	.L59	#
.L60:
# main.c:166:         free(A[i]);
	movl	-8(%rbp), %eax	# i, tmp94
	cltq
	leaq	0(,%rax,8), %rdx	#, _2
	movq	-24(%rbp), %rax	# A, tmp95
	addq	%rdx, %rax	# _2, _3
# main.c:166:         free(A[i]);
	movq	(%rax), %rax	# *_3, _4
	movq	%rax, %rdi	# _4,
	call	free@PLT	#
# main.c:167:         free(C[i]);
	movl	-8(%rbp), %eax	# i, tmp96
	cltq
	leaq	0(,%rax,8), %rdx	#, _6
	movq	-40(%rbp), %rax	# C, tmp97
	addq	%rdx, %rax	# _6, _7
# main.c:167:         free(C[i]);
	movq	(%rax), %rax	# *_7, _8
	movq	%rax, %rdi	# _8,
	call	free@PLT	#
# main.c:165:     for(int i=0; i<L; i++) {
	addl	$1, -8(%rbp)	#, i
.L59:
# main.c:165:     for(int i=0; i<L; i++) {
	movl	-8(%rbp), %eax	# i, tmp98
	cmpl	-44(%rbp), %eax	# L, tmp98
	jl	.L60	#,
# main.c:169:     for(int i=0; i<M; i++) {
	movl	$0, -4(%rbp)	#, i
# main.c:169:     for(int i=0; i<M; i++) {
	jmp	.L61	#
.L62:
# main.c:170:         free(B[i]);
	movl	-4(%rbp), %eax	# i, tmp99
	cltq
	leaq	0(,%rax,8), %rdx	#, _10
	movq	-32(%rbp), %rax	# B, tmp100
	addq	%rdx, %rax	# _10, _11
# main.c:170:         free(B[i]);
	movq	(%rax), %rax	# *_11, _12
	movq	%rax, %rdi	# _12,
	call	free@PLT	#
# main.c:169:     for(int i=0; i<M; i++) {
	addl	$1, -4(%rbp)	#, i
.L61:
# main.c:169:     for(int i=0; i<M; i++) {
	movl	-4(%rbp), %eax	# i, tmp101
	cmpl	-48(%rbp), %eax	# M, tmp101
	jl	.L62	#,
# main.c:172:     free(A);
	movq	-24(%rbp), %rax	# A, tmp102
	movq	%rax, %rdi	# tmp102,
	call	free@PLT	#
# main.c:173:     free(B);
	movq	-32(%rbp), %rax	# B, tmp103
	movq	%rax, %rdi	# tmp103,
	call	free@PLT	#
# main.c:174:     free(C);
	movq	-40(%rbp), %rax	# C, tmp104
	movq	%rax, %rdi	# tmp104,
	call	free@PLT	#
# main.c:175: }
	nop	
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE5048:
	.size	free_matrices, .-free_matrices
	.section	.rodata
	.align 8
.LC3:
	.string	"ERROR: incorrect number of arguments"
.LC4:
	.string	"ERROR: invalid arguments"
	.align 8
.LC5:
	.string	"ERROR: cannot allocate memory for matrix A"
	.align 8
.LC6:
	.string	"ERROR: cannot allocate memory for matrix B"
	.align 8
.LC9:
	.string	"ERROR: cannot allocate memory for matrix C"
	.align 8
.LC10:
	.string	"L = %u, M = %u, N = %u, EXEC TIME: %ld.%06ld\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB5049:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%rbx	#
	subq	$168, %rsp	#,
	.cfi_offset 3, -24
	movl	%edi, -164(%rbp)	# argc, argc
	movq	%rsi, -176(%rbp)	# argv, argv
# main.c:177: int main(int argc, char **argv) {
	movq	%fs:40, %rax	# MEM[(<address-space-1> long unsigned int *)40B], tmp248
	movq	%rax, -24(%rbp)	# tmp248, D.31564
	xorl	%eax, %eax	# tmp248
# main.c:186:     if(argc != 5) {
	cmpl	$5, -164(%rbp)	#, argc
	je	.L64	#,
# main.c:187:         printf("ERROR: incorrect number of arguments\n");
	leaq	.LC3(%rip), %rax	#, tmp165
	movq	%rax, %rdi	# tmp165,
	call	puts@PLT	#
# main.c:188:         print_help_and_exit(argv);
	movq	-176(%rbp), %rax	# argv, tmp166
	movq	%rax, %rdi	# tmp166,
	call	print_help_and_exit	#
.L64:
# main.c:191:     L = atoi(argv[1]);
	movq	-176(%rbp), %rax	# argv, tmp167
	addq	$8, %rax	#, _1
# main.c:191:     L = atoi(argv[1]);
	movq	(%rax), %rax	# *_1, _2
	movq	%rax, %rdi	# _2,
	call	atoi@PLT	#
	movl	%eax, -120(%rbp)	# tmp168, L
# main.c:192:     M = atoi(argv[2]);
	movq	-176(%rbp), %rax	# argv, tmp169
	addq	$16, %rax	#, _3
# main.c:192:     M = atoi(argv[2]);
	movq	(%rax), %rax	# *_3, _4
	movq	%rax, %rdi	# _4,
	call	atoi@PLT	#
	movl	%eax, -116(%rbp)	# tmp170, M
# main.c:193:     N = atoi(argv[3]);
	movq	-176(%rbp), %rax	# argv, tmp171
	addq	$24, %rax	#, _5
# main.c:193:     N = atoi(argv[3]);
	movq	(%rax), %rax	# *_5, _6
	movq	%rax, %rdi	# _6,
	call	atoi@PLT	#
	movl	%eax, -112(%rbp)	# tmp172, N
# main.c:194:     seed = atoi(argv[4]);
	movq	-176(%rbp), %rax	# argv, tmp173
	addq	$32, %rax	#, _7
# main.c:194:     seed = atoi(argv[4]);
	movq	(%rax), %rax	# *_7, _8
	movq	%rax, %rdi	# _8,
	call	atoi@PLT	#
	movl	%eax, -108(%rbp)	# tmp174, seed
# main.c:195:     srand(seed);
	movl	-108(%rbp), %eax	# seed, seed.5_9
	movl	%eax, %edi	# seed.5_9,
	call	srand@PLT	#
# main.c:197:     if( !L || !M || !N ) {
	cmpl	$0, -120(%rbp)	#, L
	je	.L65	#,
# main.c:197:     if( !L || !M || !N ) {
	cmpl	$0, -116(%rbp)	#, M
	je	.L65	#,
# main.c:197:     if( !L || !M || !N ) {
	cmpl	$0, -112(%rbp)	#, N
	jne	.L66	#,
.L65:
# main.c:198:         printf("ERROR: invalid arguments\n");
	leaq	.LC4(%rip), %rax	#, tmp175
	movq	%rax, %rdi	# tmp175,
	call	puts@PLT	#
# main.c:199:         print_help_and_exit(argv);
	movq	-176(%rbp), %rax	# argv, tmp176
	movq	%rax, %rdi	# tmp176,
	call	print_help_and_exit	#
.L66:
# main.c:203:     omp_set_num_threads(OMP_THREADS);
	movl	$4, %edi	#,
	call	omp_set_num_threads@PLT	#
# main.c:209:     A = aligned_alloc(MEM_ALIGN, L * sizeof(double *));
	movl	-120(%rbp), %eax	# L, tmp177
	cltq
	salq	$3, %rax	#, _11
	movq	%rax, %rsi	# _11,
	movl	$32, %edi	#,
	call	aligned_alloc@PLT	#
	movq	%rax, -104(%rbp)	# tmp178, A
# main.c:210:     if(A == NULL) {
	cmpq	$0, -104(%rbp)	#, A
	jne	.L67	#,
# main.c:211:         printf("ERROR: cannot allocate memory for matrix A\n");
	leaq	.LC5(%rip), %rax	#, tmp179
	movq	%rax, %rdi	# tmp179,
	call	puts@PLT	#
# main.c:212:         return 0;
	movl	$0, %eax	#, _90
	jmp	.L91	#
.L67:
# main.c:214:     for(int i=0; i<L; i++) {
	movl	$0, -152(%rbp)	#, i
# main.c:214:     for(int i=0; i<L; i++) {
	jmp	.L69	#
.L71:
# main.c:215:         A[i] = aligned_alloc(MEM_ALIGN, M * sizeof(double));
	movl	-116(%rbp), %eax	# M, tmp180
	cltq
	salq	$3, %rax	#, _13
# main.c:215:         A[i] = aligned_alloc(MEM_ALIGN, M * sizeof(double));
	movl	-152(%rbp), %edx	# i, tmp181
	movslq	%edx, %rdx	# tmp181, _14
	leaq	0(,%rdx,8), %rcx	#, _15
	movq	-104(%rbp), %rdx	# A, tmp182
	leaq	(%rcx,%rdx), %rbx	#, _16
# main.c:215:         A[i] = aligned_alloc(MEM_ALIGN, M * sizeof(double));
	movq	%rax, %rsi	# _13,
	movl	$32, %edi	#,
	call	aligned_alloc@PLT	#
# main.c:215:         A[i] = aligned_alloc(MEM_ALIGN, M * sizeof(double));
	movq	%rax, (%rbx)	# _17, *_16
# main.c:216:         if(A[i] == NULL) {
	movl	-152(%rbp), %eax	# i, tmp184
	cltq
	leaq	0(,%rax,8), %rdx	#, _19
	movq	-104(%rbp), %rax	# A, tmp185
	addq	%rdx, %rax	# _19, _20
	movq	(%rax), %rax	# *_20, _21
# main.c:216:         if(A[i] == NULL) {
	testq	%rax, %rax	# _21
	jne	.L70	#,
# main.c:217:             printf("ERROR: cannot allocate memory for matrix A\n");
	leaq	.LC5(%rip), %rax	#, tmp186
	movq	%rax, %rdi	# tmp186,
	call	puts@PLT	#
# main.c:218:             return 0;
	movl	$0, %eax	#, _90
	jmp	.L91	#
.L70:
# main.c:214:     for(int i=0; i<L; i++) {
	addl	$1, -152(%rbp)	#, i
.L69:
# main.c:214:     for(int i=0; i<L; i++) {
	movl	-152(%rbp), %eax	# i, tmp187
	cmpl	-120(%rbp), %eax	# L, tmp187
	jl	.L71	#,
# main.c:223:     B = aligned_alloc(MEM_ALIGN, M * sizeof(double *));
	movl	-116(%rbp), %eax	# M, tmp188
	cltq
	salq	$3, %rax	#, _23
	movq	%rax, %rsi	# _23,
	movl	$32, %edi	#,
	call	aligned_alloc@PLT	#
	movq	%rax, -96(%rbp)	# tmp189, B
# main.c:224:     if(B == NULL) {
	cmpq	$0, -96(%rbp)	#, B
	jne	.L72	#,
# main.c:225:         printf("ERROR: cannot allocate memory for matrix B\n");
	leaq	.LC6(%rip), %rax	#, tmp190
	movq	%rax, %rdi	# tmp190,
	call	puts@PLT	#
# main.c:226:         return 0;
	movl	$0, %eax	#, _90
	jmp	.L91	#
.L72:
# main.c:228:     for(int i=0; i<M; i++) {
	movl	$0, -148(%rbp)	#, i
# main.c:228:     for(int i=0; i<M; i++) {
	jmp	.L73	#
.L75:
# main.c:229:         B[i] = aligned_alloc(MEM_ALIGN, N * sizeof(double));
	movl	-112(%rbp), %eax	# N, tmp191
	cltq
	salq	$3, %rax	#, _25
# main.c:229:         B[i] = aligned_alloc(MEM_ALIGN, N * sizeof(double));
	movl	-148(%rbp), %edx	# i, tmp192
	movslq	%edx, %rdx	# tmp192, _26
	leaq	0(,%rdx,8), %rcx	#, _27
	movq	-96(%rbp), %rdx	# B, tmp193
	leaq	(%rcx,%rdx), %rbx	#, _28
# main.c:229:         B[i] = aligned_alloc(MEM_ALIGN, N * sizeof(double));
	movq	%rax, %rsi	# _25,
	movl	$32, %edi	#,
	call	aligned_alloc@PLT	#
# main.c:229:         B[i] = aligned_alloc(MEM_ALIGN, N * sizeof(double));
	movq	%rax, (%rbx)	# _29, *_28
# main.c:230:         if(B[i] == NULL) {
	movl	-148(%rbp), %eax	# i, tmp195
	cltq
	leaq	0(,%rax,8), %rdx	#, _31
	movq	-96(%rbp), %rax	# B, tmp196
	addq	%rdx, %rax	# _31, _32
	movq	(%rax), %rax	# *_32, _33
# main.c:230:         if(B[i] == NULL) {
	testq	%rax, %rax	# _33
	jne	.L74	#,
# main.c:231:             printf("ERROR: cannot allocate memory for matrix B\n");
	leaq	.LC6(%rip), %rax	#, tmp197
	movq	%rax, %rdi	# tmp197,
	call	puts@PLT	#
# main.c:232:             return 0;
	movl	$0, %eax	#, _90
	jmp	.L91	#
.L74:
# main.c:228:     for(int i=0; i<M; i++) {
	addl	$1, -148(%rbp)	#, i
.L73:
# main.c:228:     for(int i=0; i<M; i++) {
	movl	-148(%rbp), %eax	# i, tmp198
	cmpl	-116(%rbp), %eax	# M, tmp198
	jl	.L75	#,
# main.c:236:     for(int i=0; i<L; i++)
	movl	$0, -144(%rbp)	#, i
# main.c:236:     for(int i=0; i<L; i++)
	jmp	.L76	#
.L79:
# main.c:237:         for(int j=0; j<M; j++)
	movl	$0, -140(%rbp)	#, j
# main.c:237:         for(int j=0; j<M; j++)
	jmp	.L77	#
.L78:
# main.c:238:             A[i][j] = drand(MIN, MAX);
	movl	-144(%rbp), %eax	# i, tmp199
	cltq
	leaq	0(,%rax,8), %rdx	#, _35
	movq	-104(%rbp), %rax	# A, tmp200
	addq	%rdx, %rax	# _35, _36
	movq	(%rax), %rax	# *_36, _37
# main.c:238:             A[i][j] = drand(MIN, MAX);
	movl	-140(%rbp), %edx	# j, tmp201
	movslq	%edx, %rdx	# tmp201, _38
	salq	$3, %rdx	#, _39
	leaq	(%rax,%rdx), %rbx	#, _40
# main.c:238:             A[i][j] = drand(MIN, MAX);
	vmovsd	.LC7(%rip), %xmm0	#, tmp202
	vmovsd	%xmm0, %xmm0, %xmm1	# tmp202,
	movq	.LC8(%rip), %rax	#, tmp203
	vmovq	%rax, %xmm0	# tmp203,
	call	drand	#
	vmovq	%xmm0, %rax	#, _41
# main.c:238:             A[i][j] = drand(MIN, MAX);
	movq	%rax, (%rbx)	# _41, *_40
# main.c:237:         for(int j=0; j<M; j++)
	addl	$1, -140(%rbp)	#, j
.L77:
# main.c:237:         for(int j=0; j<M; j++)
	movl	-140(%rbp), %eax	# j, tmp204
	cmpl	-116(%rbp), %eax	# M, tmp204
	jl	.L78	#,
# main.c:236:     for(int i=0; i<L; i++)
	addl	$1, -144(%rbp)	#, i
.L76:
# main.c:236:     for(int i=0; i<L; i++)
	movl	-144(%rbp), %eax	# i, tmp205
	cmpl	-120(%rbp), %eax	# L, tmp205
	jl	.L79	#,
# main.c:240:     for(int i=0; i<M; i++)
	movl	$0, -136(%rbp)	#, i
# main.c:240:     for(int i=0; i<M; i++)
	jmp	.L80	#
.L83:
# main.c:241:         for(int j=0; j<N; j++)
	movl	$0, -132(%rbp)	#, j
# main.c:241:         for(int j=0; j<N; j++)
	jmp	.L81	#
.L82:
# main.c:242:             B[i][j] = drand(MIN, MAX);
	movl	-136(%rbp), %eax	# i, tmp206
	cltq
	leaq	0(,%rax,8), %rdx	#, _43
	movq	-96(%rbp), %rax	# B, tmp207
	addq	%rdx, %rax	# _43, _44
	movq	(%rax), %rax	# *_44, _45
# main.c:242:             B[i][j] = drand(MIN, MAX);
	movl	-132(%rbp), %edx	# j, tmp208
	movslq	%edx, %rdx	# tmp208, _46
	salq	$3, %rdx	#, _47
	leaq	(%rax,%rdx), %rbx	#, _48
# main.c:242:             B[i][j] = drand(MIN, MAX);
	vmovsd	.LC7(%rip), %xmm0	#, tmp209
	vmovsd	%xmm0, %xmm0, %xmm1	# tmp209,
	movq	.LC8(%rip), %rax	#, tmp210
	vmovq	%rax, %xmm0	# tmp210,
	call	drand	#
	vmovq	%xmm0, %rax	#, _49
# main.c:242:             B[i][j] = drand(MIN, MAX);
	movq	%rax, (%rbx)	# _49, *_48
# main.c:241:         for(int j=0; j<N; j++)
	addl	$1, -132(%rbp)	#, j
.L81:
# main.c:241:         for(int j=0; j<N; j++)
	movl	-132(%rbp), %eax	# j, tmp211
	cmpl	-112(%rbp), %eax	# N, tmp211
	jl	.L82	#,
# main.c:240:     for(int i=0; i<M; i++)
	addl	$1, -136(%rbp)	#, i
.L80:
# main.c:240:     for(int i=0; i<M; i++)
	movl	-136(%rbp), %eax	# i, tmp212
	cmpl	-116(%rbp), %eax	# M, tmp212
	jl	.L83	#,
# main.c:245:     C = aligned_alloc(MEM_ALIGN, L * sizeof(double *));
	movl	-120(%rbp), %eax	# L, tmp213
	cltq
	salq	$3, %rax	#, _51
	movq	%rax, %rsi	# _51,
	movl	$32, %edi	#,
	call	aligned_alloc@PLT	#
	movq	%rax, -88(%rbp)	# tmp214, C
# main.c:246:     if(C == NULL) {
	cmpq	$0, -88(%rbp)	#, C
	jne	.L84	#,
# main.c:247:         printf("ERROR: cannot allocate memory for matrix C\n");
	leaq	.LC9(%rip), %rax	#, tmp215
	movq	%rax, %rdi	# tmp215,
	call	puts@PLT	#
# main.c:248:         return 0;
	movl	$0, %eax	#, _90
	jmp	.L91	#
.L84:
# main.c:250:     for(int i=0; i<L; i++) {
	movl	$0, -128(%rbp)	#, i
# main.c:250:     for(int i=0; i<L; i++) {
	jmp	.L85	#
.L89:
# main.c:251:         C[i] = aligned_alloc(MEM_ALIGN, N * sizeof(double));
	movl	-112(%rbp), %eax	# N, tmp216
	cltq
	salq	$3, %rax	#, _53
# main.c:251:         C[i] = aligned_alloc(MEM_ALIGN, N * sizeof(double));
	movl	-128(%rbp), %edx	# i, tmp217
	movslq	%edx, %rdx	# tmp217, _54
	leaq	0(,%rdx,8), %rcx	#, _55
	movq	-88(%rbp), %rdx	# C, tmp218
	leaq	(%rcx,%rdx), %rbx	#, _56
# main.c:251:         C[i] = aligned_alloc(MEM_ALIGN, N * sizeof(double));
	movq	%rax, %rsi	# _53,
	movl	$32, %edi	#,
	call	aligned_alloc@PLT	#
# main.c:251:         C[i] = aligned_alloc(MEM_ALIGN, N * sizeof(double));
	movq	%rax, (%rbx)	# _57, *_56
# main.c:252:         if(C[i] == NULL) {
	movl	-128(%rbp), %eax	# i, tmp220
	cltq
	leaq	0(,%rax,8), %rdx	#, _59
	movq	-88(%rbp), %rax	# C, tmp221
	addq	%rdx, %rax	# _59, _60
	movq	(%rax), %rax	# *_60, _61
# main.c:252:         if(C[i] == NULL) {
	testq	%rax, %rax	# _61
	jne	.L86	#,
# main.c:253:             printf("ERROR: cannot allocate memory for matrix C\n");
	leaq	.LC9(%rip), %rax	#, tmp222
	movq	%rax, %rdi	# tmp222,
	call	puts@PLT	#
# main.c:254:             return 0;
	movl	$0, %eax	#, _90
	jmp	.L91	#
.L86:
# main.c:257:         for(int j=0; j<N; j++){
	movl	$0, -124(%rbp)	#, j
# main.c:257:         for(int j=0; j<N; j++){
	jmp	.L87	#
.L88:
# main.c:258:             C[i][j] = 0.0;    
	movl	-128(%rbp), %eax	# i, tmp223
	cltq
	leaq	0(,%rax,8), %rdx	#, _63
	movq	-88(%rbp), %rax	# C, tmp224
	addq	%rdx, %rax	# _63, _64
	movq	(%rax), %rax	# *_64, _65
# main.c:258:             C[i][j] = 0.0;    
	movl	-124(%rbp), %edx	# j, tmp225
	movslq	%edx, %rdx	# tmp225, _66
	salq	$3, %rdx	#, _67
	addq	%rdx, %rax	# _67, _68
# main.c:258:             C[i][j] = 0.0;    
	vxorpd	%xmm0, %xmm0, %xmm0	# tmp226
	vmovsd	%xmm0, (%rax)	# tmp226, *_68
# main.c:257:         for(int j=0; j<N; j++){
	addl	$1, -124(%rbp)	#, j
.L87:
# main.c:257:         for(int j=0; j<N; j++){
	movl	-124(%rbp), %eax	# j, tmp227
	cmpl	-112(%rbp), %eax	# N, tmp227
	jl	.L88	#,
# main.c:250:     for(int i=0; i<L; i++) {
	addl	$1, -128(%rbp)	#, i
.L85:
# main.c:250:     for(int i=0; i<L; i++) {
	movl	-128(%rbp), %eax	# i, tmp228
	cmpl	-120(%rbp), %eax	# L, tmp228
	jl	.L89	#,
# main.c:276:     gettimeofday(&start, NULL);
	leaq	-80(%rbp), %rax	#, tmp229
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp229,
	call	gettimeofday@PLT	#
# main.c:279:     matrix_multiply(A, B, C, L, M, N);
	movl	-112(%rbp), %r8d	# N, tmp230
	movl	-116(%rbp), %edi	# M, tmp231
	movl	-120(%rbp), %ecx	# L, tmp232
	movq	-88(%rbp), %rdx	# C, tmp233
	movq	-96(%rbp), %rsi	# B, tmp234
	movq	-104(%rbp), %rax	# A, tmp235
	movl	%r8d, %r9d	# tmp230,
	movl	%edi, %r8d	# tmp231,
	movq	%rax, %rdi	# tmp235,
	call	matrix_multiply	#
# main.c:285:     gettimeofday(&stop, NULL);
	leaq	-64(%rbp), %rax	#, tmp236
	movl	$0, %esi	#,
	movq	%rax, %rdi	# tmp236,
	call	gettimeofday@PLT	#
# main.c:286:     timersub(&stop, &start, &total);
	movq	-64(%rbp), %rdx	# stop.tv_sec, _69
	movq	-80(%rbp), %rax	# start.tv_sec, _70
	subq	%rax, %rdx	# _70, _71
	movq	%rdx, -48(%rbp)	# _71, total.tv_sec
	movq	-56(%rbp), %rdx	# stop.tv_usec, _72
	movq	-72(%rbp), %rax	# start.tv_usec, _73
	subq	%rax, %rdx	# _73, _74
	movq	%rdx, -40(%rbp)	# _74, total.tv_usec
	movq	-40(%rbp), %rax	# total.tv_usec, _75
	testq	%rax, %rax	# _75
	jns	.L90	#,
# main.c:286:     timersub(&stop, &start, &total);
	movq	-48(%rbp), %rax	# total.tv_sec, _76
	subq	$1, %rax	#, _77
	movq	%rax, -48(%rbp)	# _77, total.tv_sec
	movq	-40(%rbp), %rax	# total.tv_usec, _78
	addq	$1000000, %rax	#, _79
	movq	%rax, -40(%rbp)	# _79, total.tv_usec
.L90:
# main.c:310:     printf("L = %u, M = %u, N = %u, EXEC TIME: %ld.%06ld\n", L, M, N, total.tv_sec, total.tv_usec);
	movq	-40(%rbp), %rdi	# total.tv_usec, _87
	movq	-48(%rbp), %rsi	# total.tv_sec, _88
	movl	-112(%rbp), %ecx	# N, tmp237
	movl	-116(%rbp), %edx	# M, tmp238
	movl	-120(%rbp), %eax	# L, tmp239
	movq	%rdi, %r9	# _87,
	movq	%rsi, %r8	# _88,
	movl	%eax, %esi	# tmp239,
	leaq	.LC10(%rip), %rax	#, tmp240
	movq	%rax, %rdi	# tmp240,
	movl	$0, %eax	#,
	call	printf@PLT	#
# main.c:313:     free_matrices(A, B, C, L, M, N);
	movl	-112(%rbp), %r8d	# N, tmp241
	movl	-116(%rbp), %edi	# M, tmp242
	movl	-120(%rbp), %ecx	# L, tmp243
	movq	-88(%rbp), %rdx	# C, tmp244
	movq	-96(%rbp), %rsi	# B, tmp245
	movq	-104(%rbp), %rax	# A, tmp246
	movl	%r8d, %r9d	# tmp241,
	movl	%edi, %r8d	# tmp242,
	movq	%rax, %rdi	# tmp246,
	call	free_matrices	#
# main.c:315:     return 0;
	movl	$0, %eax	#, _90
.L91:
# main.c:316: }
	movq	-24(%rbp), %rdx	# D.31564, tmp249
	subq	%fs:40, %rdx	# MEM[(<address-space-1> long unsigned int *)40B], tmp249
	je	.L92	#,
	call	__stack_chk_fail@PLT	#
.L92:
	movq	-8(%rbp), %rbx	#,
	leave	
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE5049:
	.size	main, .-main
	.type	multicore_matrix_multiply._omp_fn.0, @function
multicore_matrix_multiply._omp_fn.0:
.LFB5050:
	.cfi_startproc
	endbr64	
	pushq	%rbp	#
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp	#,
	.cfi_def_cfa_register 6
	pushq	%r12	#
	pushq	%rbx	#
	subq	$64, %rsp	#,
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	movq	%rdi, -72(%rbp)	# .omp_data_i, .omp_data_i
# main.c:88:     #pragma omp parallel for
	movq	-72(%rbp), %rax	# .omp_data_i, tmp123
	movl	32(%rax), %eax	# .omp_data_i_11(D)->N, tmp124
	movl	%eax, -52(%rbp)	# tmp124, N
	movq	-72(%rbp), %rax	# .omp_data_i, tmp125
	movl	28(%rax), %eax	# .omp_data_i_11(D)->M, tmp126
	movl	%eax, -48(%rbp)	# tmp126, M
	movq	-72(%rbp), %rax	# .omp_data_i, tmp127
	movl	24(%rax), %eax	# .omp_data_i_11(D)->L, tmp128
	movl	%eax, -44(%rbp)	# tmp128, L
	movq	-72(%rbp), %rax	# .omp_data_i, tmp129
	movq	16(%rax), %rax	# .omp_data_i_11(D)->C, tmp130
	movq	%rax, -40(%rbp)	# tmp130, C
	movq	-72(%rbp), %rax	# .omp_data_i, tmp131
	movq	8(%rax), %rax	# .omp_data_i_11(D)->B, tmp132
	movq	%rax, -32(%rbp)	# tmp132, B
	movq	-72(%rbp), %rax	# .omp_data_i, tmp133
	movq	(%rax), %rax	# .omp_data_i_11(D)->A, tmp134
	movq	%rax, -24(%rbp)	# tmp134, A
	movl	-44(%rbp), %ebx	# L, L.1_18
	call	omp_get_num_threads@PLT	#
	movl	%eax, %r12d	#, _19
	call	omp_get_thread_num@PLT	#
	movl	%eax, %esi	#, _20
	movl	%ebx, %eax	# L.1_18, tmp135
	cltd
	idivl	%r12d	# _19
	movl	%eax, %ecx	# tmp135, q.3_1
	movl	%ebx, %eax	# L.1_18, L.1_18
	cltd
	idivl	%r12d	# _19
	movl	%edx, %eax	# tmp137, tt.4_2
	cmpl	%eax, %esi	# tt.4_2, _20
	jl	.L94	#,
.L101:
	imull	%ecx, %esi	# q.3_1, _20
	movl	%esi, %edx	# _20, _25
	addl	%edx, %eax	# _25, _26
	leal	(%rax,%rcx), %edx	#, _27
	cmpl	%edx, %eax	# _27, _26
	jge	.L102	#,
	movl	%eax, -64(%rbp)	# _26, i
.L97:
# main.c:92:         for(int j=0; j<N; j++) {
	movl	$0, -60(%rbp)	#, j
# main.c:92:         for(int j=0; j<N; j++) {
	nop	
.L99:
# main.c:92:         for(int j=0; j<N; j++) {
	movl	-60(%rbp), %eax	# j, tmp139
	cmpl	-52(%rbp), %eax	# N, tmp139
	jl	.L96	#,
	addl	$1, -64(%rbp)	#, i
	cmpl	%edx, -64(%rbp)	# _27, i
	jl	.L97	#,
# main.c:88:     #pragma omp parallel for
	jmp	.L102	#
.L96:
# main.c:94:             for(int k=0; k<M; k++){
	movl	$0, -56(%rbp)	#, k
# main.c:94:             for(int k=0; k<M; k++){
	nop	
.L100:
# main.c:94:             for(int k=0; k<M; k++){
	movl	-56(%rbp), %eax	# k, tmp140
	cmpl	-48(%rbp), %eax	# M, tmp140
	jl	.L98	#,
# main.c:92:         for(int j=0; j<N; j++) {
	addl	$1, -60(%rbp)	#, j
	jmp	.L99	#
.L98:
# main.c:95:                 C[i][j] += A[i][k] * B[k][j];
	movl	-64(%rbp), %eax	# i, tmp141
	cltq
	leaq	0(,%rax,8), %rcx	#, _34
	movq	-40(%rbp), %rax	# C, tmp142
	addq	%rcx, %rax	# _34, _35
	movq	(%rax), %rax	# *_35, _36
# main.c:95:                 C[i][j] += A[i][k] * B[k][j];
	movl	-60(%rbp), %ecx	# j, tmp143
	movslq	%ecx, %rcx	# tmp143, _37
	salq	$3, %rcx	#, _38
	addq	%rcx, %rax	# _38, _39
	vmovsd	(%rax), %xmm1	# *_39, _40
# main.c:95:                 C[i][j] += A[i][k] * B[k][j];
	movl	-64(%rbp), %eax	# i, tmp144
	cltq
	leaq	0(,%rax,8), %rcx	#, _42
	movq	-24(%rbp), %rax	# A, tmp145
	addq	%rcx, %rax	# _42, _43
	movq	(%rax), %rax	# *_43, _44
# main.c:95:                 C[i][j] += A[i][k] * B[k][j];
	movl	-56(%rbp), %ecx	# k, tmp146
	movslq	%ecx, %rcx	# tmp146, _45
	salq	$3, %rcx	#, _46
	addq	%rcx, %rax	# _46, _47
	vmovsd	(%rax), %xmm2	# *_47, _48
# main.c:95:                 C[i][j] += A[i][k] * B[k][j];
	movl	-56(%rbp), %eax	# k, tmp147
	cltq
	leaq	0(,%rax,8), %rcx	#, _50
	movq	-32(%rbp), %rax	# B, tmp148
	addq	%rcx, %rax	# _50, _51
	movq	(%rax), %rax	# *_51, _52
# main.c:95:                 C[i][j] += A[i][k] * B[k][j];
	movl	-60(%rbp), %ecx	# j, tmp149
	movslq	%ecx, %rcx	# tmp149, _53
	salq	$3, %rcx	#, _54
	addq	%rcx, %rax	# _54, _55
	vmovsd	(%rax), %xmm0	# *_55, _56
# main.c:95:                 C[i][j] += A[i][k] * B[k][j];
	vmulsd	%xmm0, %xmm2, %xmm0	# _56, _48, _57
# main.c:95:                 C[i][j] += A[i][k] * B[k][j];
	movl	-64(%rbp), %eax	# i, tmp150
	cltq
	leaq	0(,%rax,8), %rcx	#, _59
	movq	-40(%rbp), %rax	# C, tmp151
	addq	%rcx, %rax	# _59, _60
	movq	(%rax), %rax	# *_60, _61
# main.c:95:                 C[i][j] += A[i][k] * B[k][j];
	movl	-60(%rbp), %ecx	# j, tmp152
	movslq	%ecx, %rcx	# tmp152, _62
	salq	$3, %rcx	#, _63
	addq	%rcx, %rax	# _63, _64
# main.c:95:                 C[i][j] += A[i][k] * B[k][j];
	vaddsd	%xmm0, %xmm1, %xmm0	# _57, _40, _65
	vmovsd	%xmm0, (%rax)	# _65, *_64
# main.c:94:             for(int k=0; k<M; k++){
	addl	$1, -56(%rbp)	#, k
	jmp	.L100	#
.L94:
	movl	$0, %eax	#, tt.4_2
	addl	$1, %ecx	#, q.3_1
	jmp	.L101	#
.L102:
# main.c:88:     #pragma omp parallel for
	nop	
	addq	$64, %rsp	#,
	popq	%rbx	#
	popq	%r12	#
	popq	%rbp	#
	.cfi_def_cfa 7, 8
	ret	
	.cfi_endproc
.LFE5050:
	.size	multicore_matrix_multiply._omp_fn.0, .-multicore_matrix_multiply._omp_fn.0
	.section	.rodata
	.align 8
.LC2:
	.long	-4194304
	.long	1105199103
	.align 8
.LC7:
	.long	0
	.long	1072693248
	.align 8
.LC8:
	.long	0
	.long	0
	.ident	"GCC: (Ubuntu 13.3.0-6ubuntu2~24.04) 13.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
