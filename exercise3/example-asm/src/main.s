.text

.macro  DEBUG_PRINT     reg
csrw 0x7b2, \reg
.endm

# common functions

# setBit(num, i): num or (1<<i)
# sll shifted, 1, i (where 1 is stored in a temp var)
# or result, num, shifted

# getBit(num, i): (num and (1 <<i)) != 0
# sll shifted, 1, i (where 1 is stored in a temp var)
# and toCompare, num, shifted
# mv result, zero (result=0)
# bne toCompare, zero, setOne (if toCompare!=0 then result=1)

# setOne:
# addi result, zero, 1

# a0=N, a1=D, t0=q, t1=r, t2=temp, t3=i, t4=result, t5=1

# try INLINE-ing this
setOne:
	addi t4, zero, 1
	j divloop_cont

div:
	addi sp,sp,-32	# Allocate stack space
	
	# store any callee-saved register you might overwrite
	sw ra, 0(sp)

	mv t0, zero		# q=0
	mv t1, zero		# r=0
	mv t2, a0		# a0, a0 is number we want to divide up (N)
	mv t3, zero		# used to count the number of bits in N, used as i later
	addi t5, t3, 1	# t5=1
	beq a0, zero, divend	# if N==0 goto divend, short-circuiting
divfindi:			# do while loop to find i
	beq t2, zero, divloop	# goto divloop if we've gone through all bits in N
	addi t3, t3, 1		# i++
	srli t2, t2, 1		# shift to right so that we have a loop over the bits 
	### CHECK if using imm correctly
	j divfindi			# the "i" I get is n, not n-1
divloop:
	beq t3, zero, divend	# if i==0 goto divend
	addi t3, t3, -1			# i--
	slli t1, t1, 1			# r << 1
	# getBit from N[i]
	sll t2, t5, t3
	and t2, a0, t2
	mv t4, zero
	bne t2, zero, setOne
divloop_cont:
	# setBit from N[i] to R[0]
	or t1, t1, t4
divupdate:
	blt t1, a1, divloop
	sub t1, t1, a1
	# setBit Q[i] to 1
	sll t2, t5, t3
	or t0, t0, t2
	j divloop
divend: # if short circuited, should have a different result
	mv a0, t0
	mv a1, t1

	# load every register you stored above
	lw ra, 0(sp)
	addi sp,sp,32 	# Free up stack space

	ret			# return result in a0, a1

checker:
	addi sp,sp,-32 	# Allocate stack space
	sw ra, 0(sp)

	addi    a0, zero, 12    # a0 <- 12
	addi    a1, zero, 4     # a1 <- 4
	call    div
	DEBUG_PRINT a0          # display the quotient 0x00000003
	DEBUG_PRINT a1          # display the remainder 0x00000000

	addi    a0, zero, 93    # a0 <- 93
	addi    a1, zero, 7     # a1 <- 7
	call    div
	DEBUG_PRINT a0          # display the quotient 0x0000000d
	DEBUG_PRINT a1          # display the remainder 0x00000002

	lui     a0, (0x12345000>>12) # load upper immediate, by placing the value in top 20 bits of a0
	ori     a0, a0, 0x678   # a0 <- 0x12345678 over 2 lines, this line applies OR on imm
	addi    a1, zero, 255   # a1 <- 255
	call    div
	DEBUG_PRINT a0          # display the quotient 0x0012469d
	DEBUG_PRINT a1          # display the remainder 0x00000015

	# 11120 ns total

	lw ra, 0(sp)
	addi sp,sp,32 	# Free up stack space
	ret

.global main		# Export the symbol 'main' so we can call it from other files
.type main, @function
main:
	addi sp,sp,-32 	# Allocate stack space
	sw ra, 0(sp)
	# call checker function
	# call checker

	addi    a0, zero, 1023    # a0 <- 93
	addi    a1, zero, 400     # a1 <- 7
	call    div
	DEBUG_PRINT a0          # display the quotient 0x0000000d
	DEBUG_PRINT a1          # display the remainder 0x00000002

	lw ra, 0(sp)
	addi sp,sp,32 	# Free up stack space
	ret
