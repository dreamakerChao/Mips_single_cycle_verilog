	.file	1 "factorial.c"
	.section .mdebug.abi32
	.previous
	.nan	legacy
	.module	fp=32
	.module	oddspreg
	.module	arch=mips32
	.abicalls
	.text
	.align	2
	.globl	factorial
	.set	nomips16
	.set	nomicromips
	.ent	factorial
	.type	factorial, @function
factorial:
	.frame	$fp,32,$31		# vars= 0, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-32
	sw	$31,28($sp)
	sw	$fp,24($sp)
	move	$fp,$sp
	sw	$4,32($fp)
	lw	$2,32($fp)
	slt	$2,$2,2
	beq	$2,$0,$L2
	nop

	li	$2,1			# 0x1
	.option	pic0
	b	$L3
	nop

	.option	pic2
$L2:
	lw	$2,32($fp)
	addiu	$2,$2,-1
	move	$4,$2
	.option	pic0
	jal	factorial
	nop

	.option	pic2
	move	$3,$2
	lw	$2,32($fp)
	mul	$2,$3,$2
$L3:
	move	$sp,$fp
	lw	$31,28($sp)
	lw	$fp,24($sp)
	addiu	$sp,$sp,32
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	factorial
	.size	factorial, .-factorial
	.align	2
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,40,$31		# vars= 8, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-40
	sw	$31,36($sp)
	sw	$fp,32($sp)
	move	$fp,$sp
	li	$2,5			# 0x5
	sw	$2,24($fp)
	lw	$4,24($fp)
	.option	pic0
	jal	factorial
	.option	pic2
	sw	$2,28($fp)
	lw	$2,28($fp)
#APP
 # 12 "factorial.c" 1
	move $v0, $2
 # 0 "" 2
 # 14 "factorial.c" 1
	li $v0, 10
	syscall
	
 # 0 "" 2
#NO_APP
	move	$2,$0
	move	$sp,$fp
	lw	$31,36($sp)
	lw	$fp,32($sp)
	addiu	$sp,$sp,40
	jr	$31
	.end	main
	.size	main, .-main
	.ident	"GCC: (Ubuntu 12.3.0-17ubuntu1) 12.3.0"
	.section	.note.GNU-stack,"",@progbits
