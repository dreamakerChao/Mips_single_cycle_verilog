	addi $sp,$sp,-14
	addi $t2,$zero,0
	addi $t1,$zero,14

re: lb $s1, 0($sp)
	addi $sp,$sp,1
	addi $s1,$s1,1
	addi $t2,$t2,1
	sb $s1,0($t2)
	bne $t2,$t1,re

	/*str
	0a48656c  
	6c6f2057
	6f726c64
	210a0000
	\nHello World!\n*/

