	.file	"main.c"
	.text
	.globl	E
	.bss
	.align 32
	.type	E, @object
	.size	E, 68
E:
	.zero	68
	.globl	orig_termios
	.align 32
	.type	orig_termios, @object
	.size	orig_termios, 60
orig_termios:
	.zero	60
	.section	.rodata
.LC0:
	.string	"\033[2J"
.LC1:
	.string	"\033[H"
	.text
	.globl	die
	.type	die, @function
die:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movl	$4, %edx
	leaq	.LC0(%rip), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	write@PLT
	movl	$3, %edx
	leaq	.LC1(%rip), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	write@PLT
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	perror@PLT
	movl	$1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE6:
	.size	die, .-die
	.section	.rodata
.LC2:
	.string	"tcsetattr"
	.text
	.globl	disableRawMode
	.type	disableRawMode, @function
disableRawMode:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	8+E(%rip), %rax
	movq	%rax, %rdx
	movl	$0, %esi
	movl	$0, %edi
	call	tcsetattr@PLT
	cmpl	$-1, %eax
	jne	.L4
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	call	die
.L4:
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	disableRawMode, .-disableRawMode
	.section	.rodata
.LC3:
	.string	"tcgetattr"
	.text
	.globl	enableRawMode
	.type	enableRawMode, @function
enableRawMode:
.LFB8:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$80, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	leaq	8+E(%rip), %rax
	movq	%rax, %rsi
	movl	$2, %edi
	call	tcgetattr@PLT
	cmpl	$-1, %eax
	jne	.L6
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	die
.L6:
	leaq	disableRawMode(%rip), %rax
	movq	%rax, %rdi
	call	atexit@PLT
	movq	8+E(%rip), %rax
	movq	16+E(%rip), %rdx
	movq	%rax, -80(%rbp)
	movq	%rdx, -72(%rbp)
	movq	24+E(%rip), %rax
	movq	32+E(%rip), %rdx
	movq	%rax, -64(%rbp)
	movq	%rdx, -56(%rbp)
	movq	40+E(%rip), %rax
	movq	48+E(%rip), %rdx
	movq	%rax, -48(%rbp)
	movq	%rdx, -40(%rbp)
	movq	56+E(%rip), %rax
	movq	%rax, -32(%rbp)
	movl	64+E(%rip), %eax
	movl	%eax, -24(%rbp)
	movl	-80(%rbp), %eax
	andl	$-1331, %eax
	movl	%eax, -80(%rbp)
	movl	-76(%rbp), %eax
	andl	$-2, %eax
	movl	%eax, -76(%rbp)
	movl	-72(%rbp), %eax
	orl	$48, %eax
	movl	%eax, -72(%rbp)
	movl	-68(%rbp), %eax
	andl	$-32780, %eax
	movl	%eax, -68(%rbp)
	movb	$0, -57(%rbp)
	movb	$1, -58(%rbp)
	leaq	-80(%rbp), %rax
	movq	%rax, %rdx
	movl	$1, %esi
	movl	$0, %edi
	call	tcsetattr@PLT
	cmpl	$-1, %eax
	jne	.L9
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	die
.L9:
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L8
	call	__stack_chk_fail@PLT
.L8:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	enableRawMode, .-enableRawMode
	.section	.rodata
.LC4:
	.string	"read"
	.text
	.globl	editorReadKey
	.type	editorReadKey, @function
editorReadKey:
.LFB9:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	jmp	.L11
.L12:
	cmpl	$-1, -12(%rbp)
	jne	.L11
	call	__errno_location@PLT
	movl	(%rax), %eax
	cmpl	$11, %eax
	je	.L11
	leaq	.LC4(%rip), %rax
	movq	%rax, %rdi
	call	die
.L11:
	leaq	-13(%rbp), %rax
	movl	$1, %edx
	movq	%rax, %rsi
	movl	$0, %edi
	call	read@PLT
	movl	%eax, -12(%rbp)
	cmpl	$1, -12(%rbp)
	jne	.L12
	movzbl	-13(%rbp), %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L14
	call	__stack_chk_fail@PLT
.L14:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	editorReadKey, .-editorReadKey
	.section	.rodata
.LC5:
	.string	"\033[999C\033[999B"
	.text
	.globl	getWindowSize
	.type	getWindowSize, @function
getWindowSize:
.LFB10:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	$12, %edx
	leaq	.LC5(%rip), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	write@PLT
	cmpq	$12, %rax
	je	.L16
	movl	$-1, %eax
	jmp	.L18
.L16:
	movl	$0, %eax
	call	editorReadKey
	movl	$-1, %eax
.L18:
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L19
	call	__stack_chk_fail@PLT
.L19:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE10:
	.size	getWindowSize, .-getWindowSize
	.section	.rodata
.LC6:
	.string	"~\r\n"
	.text
	.globl	editorDrawRows
	.type	editorDrawRows, @function
editorDrawRows:
.LFB11:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, -4(%rbp)
	jmp	.L21
.L22:
	movl	$3, %edx
	leaq	.LC6(%rip), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	write@PLT
	addl	$1, -4(%rbp)
.L21:
	movl	E(%rip), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L22
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE11:
	.size	editorDrawRows, .-editorDrawRows
	.globl	editorRefreshScreen
	.type	editorRefreshScreen, @function
editorRefreshScreen:
.LFB12:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$4, %edx
	leaq	.LC0(%rip), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	write@PLT
	movl	$3, %edx
	leaq	.LC1(%rip), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	write@PLT
	movl	$0, %eax
	call	editorDrawRows
	movl	$3, %edx
	leaq	.LC1(%rip), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	write@PLT
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE12:
	.size	editorRefreshScreen, .-editorRefreshScreen
	.globl	editorProcessKeypress
	.type	editorProcessKeypress, @function
editorProcessKeypress:
.LFB13:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	$0, %eax
	call	editorReadKey
	movb	%al, -1(%rbp)
	movsbl	-1(%rbp), %eax
	cmpl	$17, %eax
	jne	.L26
	movl	$4, %edx
	leaq	.LC0(%rip), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	write@PLT
	movl	$3, %edx
	leaq	.LC1(%rip), %rax
	movq	%rax, %rsi
	movl	$1, %edi
	call	write@PLT
	movl	$0, %edi
	call	exit@PLT
.L26:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE13:
	.size	editorProcessKeypress, .-editorProcessKeypress
	.section	.rodata
.LC7:
	.string	"getWindowsSize"
	.text
	.globl	initEditor
	.type	initEditor, @function
initEditor:
.LFB14:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	4+E(%rip), %rax
	movq	%rax, %rsi
	leaq	E(%rip), %rax
	movq	%rax, %rdi
	call	getWindowSize
	cmpl	$-1, %eax
	jne	.L29
	leaq	.LC7(%rip), %rax
	movq	%rax, %rdi
	call	die
.L29:
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE14:
	.size	initEditor, .-initEditor
	.globl	main
	.type	main, @function
main:
.LFB15:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, %eax
	call	enableRawMode
	movl	$0, %eax
	call	initEditor
.L31:
	movl	$0, %eax
	call	editorRefreshScreen
	movl	$0, %eax
	call	editorProcessKeypress
	jmp	.L31
	.cfi_endproc
.LFE15:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
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
