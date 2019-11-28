.text

.macro  DEBUG_PRINT     reg
csrw 0x7b2, \reg
.endm

# a0=N, a1=D, t0=q, t1=r, t2=temp, t3=i, t4=result, t5=1

# try INLINE-ing this
setOne:
	addi t4, zero, 1
	j divloop_cont

.global div
div:
	addi sp,sp,-32	# Allocate stack space
	
	# store any callee-saved register you might overwrite
	sw ra, 0(sp)

	mv t0, zero		# q=0
	mv t1, zero		# r=0
	beq a0, zero, divend	# if N==0 goto divend, short-circuiting
	mv t2, a0		# a0, a0 is number we want to divide up (N)
	mv t3, zero		# used to count the number of bits in N, used as i later
	addi t5, t3, 1	# t5=1
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
divend:
	mv a0, t0
	mv a1, t1

	# load every register you stored above
	lw ra, 0(sp)
	addi sp,sp,32 	# Free up stack space

	ret			# return result in a0, a1

.global rem
rem:
	addi sp,sp,-32 	# Allocate stack space
	sw ra, 0(sp)

    call div

    # swap a0, a1
    mv t2, a0
    mv a0, a1
    mv a1, t2
    
	lw ra, 0(sp)
	addi sp,sp,32 	# Free up stack space
	ret
