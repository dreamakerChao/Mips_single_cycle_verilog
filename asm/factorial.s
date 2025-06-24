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
	.globl	main
	.set	nomips16
	.set	nomicromips
	.ent	main
	.type	main, @function
main:
	.frame	$fp,56,$31		# vars= 24, regs= 2/0, args= 16, gp= 8
	.mask	0xc0000000,-4
	.fmask	0x00000000,0
	addiu	$sp,$sp,-56
	sw	$31,52($sp)
	sw	$fp,48($sp)
	move	$fp,$sp
	li	$2,3			# 0x3
	sw	$2,32($fp)
	li	$2,4			# 0x4
	sw	$2,36($fp)
	lw	$3,32($fp)
	lw	$2,36($fp)
	addu	$2,$3,$2
	sw	$2,40($fp)
	lw	$4,40($fp)
	.option	pic0
	jal	square
	.option	pic2
	sw	$2,24($fp)
	lw	$2,24($fp)
	slt	$2,$2,21
	bne	$2,$0,$L2
	lw	$2,24($fp)
	addiu	$2,$2,10
	sw	$2,24($fp)
$L2:
	sw	$0,28($fp)
	.option	pic0
	b	$L3
	.option	pic2
$L4:
	lw	$2,24($fp)
	addiu	$2,$2,1
	sw	$2,24($fp)
	lw	$2,28($fp)
	addiu	$2,$2,1
	sw	$2,28($fp)
$L3:
	lw	$2,28($fp)
	slt	$2,$2,5
	bne	$2,$0,$L4
	.option	pic0
	b	$L5
	.option	pic2
$L6:
	lw	$2,24($fp)
	addiu	$2,$2,1
	sw	$2,24($fp)
$L5:
	lw	$2,24($fp)
	slt	$2,$2,70
	bne	$2,$0,$L6
	lw	$2,24($fp)
#APP
 # 23 "factorial.c" 1
	move $v1, $2
 # 0 "" 2
#NO_APP
	move	$2,$0
	move	$sp,$fp
	lw	$31,52($sp)
	lw	$fp,48($sp)
	addiu	$sp,$sp,56
	jr	$31
	.end	main
	.size	main, .-main
	.align	2
	.globl	square
	.set	nomips16
	.set	nomicromips
	.ent	square
	.type	square, @function
square:
	.frame	$fp,8,$31		# vars= 0, regs= 1/0, args= 0, gp= 0
	.mask	0x40000000,-4
	.fmask	0x00000000,0
	.set	noreorder
	.set	nomacro
	addiu	$sp,$sp,-8
	sw	$fp,4($sp)
	move	$fp,$sp
	sw	$4,8($fp)
	lw	$2,8($fp)
	mul	$2,$2,$2
	move	$sp,$fp
	lw	$fp,4($sp)
	addiu	$sp,$sp,8
	jr	$31
	nop

	.set	macro
	.set	reorder
	.end	square
	.size	square, .-square
	.ident	"GCC: (Ubuntu 12.3.0-17ubuntu1) 12.3.0"
	.section	.note.GNU-stack,"",@progbits
