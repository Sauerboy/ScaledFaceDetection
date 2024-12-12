#=================================================================
# Copyright 2023 Georgia Tech.  All rights reserved.
# The materials provided by the instructor in this course are for
# the use of the students currently enrolled in the course.
# Copyrighted course materials may not be further disseminated.
# This file must not be made publicly available anywhere.
# =================================================================

# HW2-2
# Student Name: Ariel Sauer
# Date: October 13 2023
#
#     Find George Variably Scaled
#
# This routine finds an exact match of George's face which may be
# scaled in a crowd of faces.
#
#===========================================================================
# CHANGE LOG: brief description of changes made from P1-2-shell.asm
# to this version of code.
# Date  Modification
# 10/4 Restarted because old code was so bad I couldn't fix it
# 10/4 Decided to trace array backwards
# 10/5 Functional code to find first green shirt. Uses two loops.
# 10/5 Functional code to find exactly one pixel per green shirt(Does not count one scaled shirt as many).
# 10/6 Can find all green shirts in crowd. Uses two loops and call back to first loop after successful find.
# 10/9 Added skin, hat, smile, and eye checks.
# 10/10 Added iteration by 5 pixels to improve dynamic I
# 10/11 Calculated bounding box.
# 10/12 Put bounding box into register 2
#===========================================================================

.data
Array:  .alloc	1024

.text

# your code goes here

FindGeorge:	addi	$1, $0, Array		# point to array base
			swi 592						# Generate Crowd
			addi	$3, $1, 4096		# End of array index
PreLoop:	addi	$4, $0, 7			# Green color
			add		$6, $0, $0			# Green counter/scale

Loop:		addi $3, $3, -5				# Decrement array index
			lb $5, 0($3)
			bne $5, $4, Loop			# if pixel not green, repeat loop

GreenFound:	addi $3, $3, 1				# Reverse until nongreen found
			lb $5, 0($3)
			beq $5, $4, GreenFound

PostGreen:	addi $3, $3, -1				# Start counting green pixels
			lb $5, 0($3)
			addi $6, $6, 1
			beq $5, $4, PostGreen


			addi $7, $3, -63
			lb $5, 0($7)				# Check pixel above and one right to determine if this is the top of the shirt
			beq $5, $4, PreLoop			# Go back to find other shirts


			addi $4, $0, 8				# Calculate scale
			addi $5, $0, 5
			div $6, $5
			mflo $6
			addi $7, $0, 255			# Prepare for smile check
			mult $6, $7
			mflo $7
			sub $7, $3, $7				
			
			lb $5, 0($7)
			bne $5, $4, PreLoop

			addi $7, $7, -64	# Skin Check, make sure pixel is right color
			addi $4, $0, 5
			lb $5, 0($7)
			bne $5, $4, PreLoop

			addi $4, $0, 3		# Eye check
			addi $5, $0, 63
			mult $5, $6
			mflo $5
			sub $7, $7, $5
			lb $5, 0($7)
			bne $5, $4, PreLoop
			

			addi $4, $0, 2	# Hat check 1
			addi $5, $0, 64
			mult $5, $6
			mflo $5
			sub $7, $7, $5
			lb $5, 0($7)
			bne $5, $4, PreLoop
			

		addi $4, $0, 1		# Hat check 2
			addi $5, $0, 63
			mult $5, $6
			mflo $5
			sub $7, $7, $5
			lb $5, 0($7)
			bne $5, $4, PreLoop
			

		addi $5, $0, 707 # Find top left using reference pixel
		mult $5, $6
		mflo $5
		sub $2, $3, $5
		addi $2, $2, 1
		sub $2, $2, $1


		addi $3, $0, 780 # Find bottom right using top left
		mult $3, $6
		mflo $3
		add $3, $2, $3
		addi $3, $3, -65

		sll $2, $2, 16 # shift top left and put bottom right in lower 16 bits
		or $2, $2, $3
		swi 593


End:		jr	$31			# return to caller
