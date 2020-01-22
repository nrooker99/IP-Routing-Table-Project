
# Note: I set the program to interpret the first line of the table as position "1" instead of position "0"

.data

IP_ROUTING_TABLE_SIZE:
		.word	25 

IP_ROUTING_TABLE:
		# line #, x.x.x.x -------------------------------------
		.word  25,  10, 153,   1,   8	# 10.153.1.8
		.word  24, 191,  28, 255, 255	# 191.28.255.255
		.word  23, 191,  28,  88,  90	# 191.28.88.90
		.word  22, 192, 151, 100,  56	# 192.151.100.56
		.word  21, 192, 151, 100, 100	# 192.151.100.100
		.word  20,  82, 163, 140,  80	# 82.163.140.80
		.word  19,  82, 163, 147,  80	# 146.163.147.80
		.word  10, 201,  88, 102,  80	# 201.88.102.1
		.word  11, 148, 163, 170,  80	# 146.163.170.80
		.word  12, 193,  77,  77,  10	# 193.77.77.10
		.word	0, 146,  92, 255, 255	# 146.92.255.255
		.word	1, 147, 163, 255, 255	# 147.163.255.255
		.word	2, 201,  88,  88,  90	# 201.88.88.90
		.word	3, 182, 151,  44,  56	# 182.151.44.56
		.word	4,  24, 125, 100, 100	# 24.125.100.100
		.word	5, 146, 163, 140,  80	# 146.163.170.80
		.word	6, 146, 163, 147,  80	# 146.163.147.80
		.word   7, 201,  88, 102,  80	# 201.88.102.1
		.word   8, 148, 163, 170,  80	# 146.163.170.80
		.word   9, 193,  77,  77,  10	# 193.77.77.10
		.word  20,  22,   8,   5,   1	# 22.8.5.1
		.word  21,  22,  12, 188, 192	# 22.12.188.192
		.word  10, 201,  88, 102,  80	# 201.88.102.1
		.word  11, 148, 163, 170,  80	# 146.163.170.80
		.word  12, 193,  77,  78,  10	# 193.77.78.10

ENTER_ADDRESS_MSG: .asciiz "Enter an IP address"

INPUT_MSG_1: .asciiz "First: "
INPUT_MSG_2: .asciiz "Second: "
INPUT_MSG_3: .asciiz "Third: "
INPUT_MSG_4: .asciiz "Fourth: "

IP_ADDRESS: .asciiz "The IP address you entered: "
DOT: .asciiz "."

CLASS: .asciiz "Class "
A: .asciiz "A "
B: .asciiz "B "
C: .asciiz "C "
D: .asciiz "D "
ADDRESS: .asciiz "address."

MATCH_FOUND: .asciiz "Matching domain found at position "
MATCH_NOT_FOUND: .asciiz "Matching domain was not found."

INVALID_INPUT: .asciiz "Your input is invalid. Please try again. Valid inputs are [1, 255]."

FINISHED: .asciiz "Program successfully completed."

NEW_LINE: .asciiz "\n"

.text
.globl main

main:

	li $s0, 1	# Minimum value
	li $s1, 255	# Maximum value

input_1:

	li $v0, 4			
	la $a0, ENTER_ADDRESS_MSG	
	syscall

	li $v0, 4			
	la $a0, NEW_LINE	
	syscall

	li $v0, 4			
	la $a0, INPUT_MSG_1	
	syscall

	li $v0, 5
	syscall

	move $s2, $v0

	blt $s2, $s0 invalid_input_1
	bgt $s2, $s1 invalid_input_1
	j input_2

invalid_input_1:

	li $v0, 4			
	la $a0, INVALID_INPUT	
	syscall

	li $v0, 4			
	la $a0, NEW_LINE	
	syscall

	j input_1

input_2:

	li $v0, 4			
	la $a0, INPUT_MSG_2	
	syscall

	li $v0, 5
	syscall

	move $s3, $v0

	blt $s3, $s0 invalid_input_2	
	bgt $s3, $s1 invalid_input_2

	j input_3

invalid_input_2:

	li $v0, 4			
	la $a0, INVALID_INPUT	
	syscall

	li $v0, 4			
	la $a0, NEW_LINE	
	syscall

	j input_2

input_3:

	li $v0, 4			
	la $a0, INPUT_MSG_3	
	syscall

	li $v0, 5
	syscall

	move $s4, $v0

	blt $s4, $s0 invalid_input_3
	bgt $s4, $s1 invalid_input_3

	j input_4

invalid_input_3:

	li $v0, 4			
	la $a0, INVALID_INPUT	
	syscall

	li $v0, 4			
	la $a0, NEW_LINE	
	syscall

	j input_3

input_4:

	li $v0, 4			
	la $a0, INPUT_MSG_4	
	syscall

	li $v0, 5
	syscall

	move $s5, $v0

	blt $s5, $s0 invalid_input_4
	bgt $s5, $s1 invalid_input_4

	li $v0, 4			
	la $a0, NEW_LINE	
	syscall

	j print_address

invalid_input_4:

	li $v0, 4			
	la $a0, INVALID_INPUT	
	syscall

	li $v0, 4			
	la $a0, NEW_LINE	
	syscall

	j input_4

print_address:

	li $v0, 4			
	la $a0, IP_ADDRESS
	syscall

	li $v0, 1
	move $a0, $s2
	syscall
	
	li $v0, 4			
	la $a0, DOT
	syscall
	
	li $v0, 1
	move $a0, $s3
	syscall

	li $v0, 4			
	la $a0, DOT
	syscall

	li $v0, 1
	move $a0, $s4
	syscall

	li $v0, 4			
	la $a0, DOT
	syscall

	li $v0, 1
	move $a0, $s5
	syscall

	li $v0, 4			
	la $a0, NEW_LINE
	syscall

	li $v0, 4			
	la $a0, NEW_LINE
	syscall

	j find_class

find_class:

	li $v0, 4			
	la $a0, CLASS
	syscall

	blt $s2, 128 a_class

	blt $s2, 192 b_class
	
	blt $s2, 224 c_class

	blt $s2, 256 d_class
	
a_class:

	li $v0, 4			
	la $a0, A
	syscall

	li $v0, 4			
	la $a0, ADDRESS
	syscall

	li $v0, 4			
	la $a0, NEW_LINE
	syscall

	li $v0, 4			
	la $a0, NEW_LINE
	syscall

	j match_address

b_class:

	li $v0, 4			
	la $a0, B
	syscall

	li $v0, 4			
	la $a0, ADDRESS
	syscall

	li $v0, 4			
	la $a0, NEW_LINE
	syscall

	li $v0, 4			
	la $a0, NEW_LINE
	syscall

	j match_address

c_class:

	li $v0, 4			
	la $a0, C
	syscall

	li $v0, 4			
	la $a0, ADDRESS
	syscall

	li $v0, 4			
	la $a0, NEW_LINE
	syscall

	li $v0, 4			
	la $a0, NEW_LINE
	syscall

	j match_address

d_class:

	li $v0, 4			
	la $a0, D
	syscall

	li $v0, 4			
	la $a0, ADDRESS
	syscall

	li $v0, 4			
	la $a0, NEW_LINE
	syscall

	li $v0, 4			
	la $a0, NEW_LINE
	syscall

	j match_address

match_address:

	la $t0, IP_ROUTING_TABLE
	lw $t1, IP_ROUTING_TABLE_SIZE

	li $t8, 20
	li $t7, 0				# loop counter

	j match_address_loop

match_address_loop:
	
	mul $t6, $t7, $t8
	addu $t6, $t6, $t0 

	lw $t2, 4($t6)
	lw $t3, 8($t6)
	lw $t4, 12($t6)
	lw $t5, 16($t6)

	beq $t2, $s2 last_check
	j next_iteration

last_check:

	beq $t3, $s3 match_found
	j next_iteration

match_found:

	li $v0, 4			
	la $a0, MATCH_FOUND
	syscall

	addu $t7, $t7, 1

	li $v0, 1
	move $a0, $t7
	syscall

	li $v0, 4			
	la $a0, DOT
	syscall

	li $v0, 4			
	la $a0, NEW_LINE
	syscall

	j end_program

next_iteration:

	addu $t7, $t7, 1			# increment loop counter

	blt $t7, $t1 match_address_loop

	li $v0, 4			
	la $a0, MATCH_NOT_FOUND
	syscall
	
	li $v0, 4			
	la $a0, NEW_LINE
	syscall
	
	j end_program
	
end_program:

	li $v0, 4			
	la $a0, NEW_LINE
	syscall
	
	li $v0, 4			
	la $a0, FINISHED
	syscall

	jr $31


