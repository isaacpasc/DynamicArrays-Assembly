                .data   

oArray:         .space 44
bit:            .word  4

msg1:           .asciiz "Specify how many times to repeat:\n"
msg2:           .asciiz "\nEnter an integer for the Nth smallest:\n"
msg3:           .asciiz "\nEnter 11 integers."
msg4:           .asciiz "\nEnter an integer:\n"
msg5:           .asciiz "\n\nOriginal Array Content:\n"
msg6:           .asciiz "\n\nResult Array Content:\n"
msg7:           .asciiz "The "
msg8:           .asciiz "(-th) smallest number is "
newLine:        .asciiz "\n"

                .text 
                .globl  main    

main:
    la          $a0, msg1
    li          $v0, 4
    syscall
    li          $v0, 5                  
    syscall
    move        $s0, $v0        # number of times to repeat = $s0
    la          $a0, msg2
    li          $v0, 4
    syscall
    li          $v0, 5
    syscall
    move        $s1, $v0         # nth smallest = $s1

    # if nth smallest less than 1, set to 1
    slti        $t0, $s1, 1
    beqz        $t0, notLessThan
    addi        $s1, $zero, 1

    # if nth smallest greater than 11, set to 11
    notLessThan: 
        slti    $t0, $s1, 12
        bgtz    $t0, notGreaterThan
        addi    $s1, $zero, 11

    notGreaterThan:
        addi    $t8, $zero, 0 # $t8 = index for while loop, start at 0

    whileCall:
        beq     $t8, $s0, Exit
        addi    $t8, $t8, 1
        jal     findTheNthSmallest
        la      $a0,msg7
        li      $v0,4
        syscall
        addi    $a0, $s1, 0
        li      $v0,1
        syscall
        la      $a0,msg8
        li      $v0,4
        syscall
        move    $a0,$v1
        li      $v0,1
        syscall
        j       whileCall

    Exit:
        li      $v0, 10 
        syscall      

############################################################################ 
# Procedure/Function readArray 
# Description: reads integers from user input and store them in the array
# parameters: $a0 = address of oArray
# return value: none
# registers to be used: none
############################################################################

readArray:
    la          $a0, msg3
    li          $v0, 4
    syscall
    addi        $t0, $zero, 0   # index of oArray = $t0

    enterInts: # enter 11 ints to oArray
        beq     $t0, 44, exitEnterInts
        la      $a0, msg4
        li      $v0, 4
        syscall
        li      $v0, 5
        syscall
        sw      $v0, oArray($t0)
        addi    $t0, $t0, 4
        j       enterInts

    exitEnterInts:
        jr      $ra

############################################################################ 
# Procedure/Function printArray 
# Description: prints integers of the array
# parameters: $a0 = address of oArray
# return value: none
# registers to be used: none
############################################################################

printArray:
    addi        $t0, $zero, 0

    while:
        beq     $t0, 44, exitWhile
        lw      $t6, oArray($t0)
        li      $v0, 1
        move    $a0, $t6
        syscall
        li      $v0, 4
        la      $a0, newLine
        syscall
        addi $t0, $t0, 4
        j       while

    exitWhile:
        jr      $ra

############################################################################ 
# Procedure/Function findTheNthSmallest 
# Description: It goes through each element of array and find the smallest
# parameters: $a0 = address of oArray , index
# return value: $v1 = nth term
# registers to be used: none
############################################################################

findTheNthSmallest:
    addi        $sp, $sp, -4
    sw          $ra, 0($sp)
    jal         readArray
    la          $a0, msg5
    li          $v0, 4
    syscall
    jal         printArray
    addi        $t0, $zero, 0 # $t0 = i = 0
    lw          $t2, bit
    mult        $t2, $s1
    mflo        $t2 # $t2 = 4*index

    firstWhile:
        beq     $t0, $t2, exitFirstWhile # exit if index=i
        addi    $t1, $t0, 4 # $t1 = j = i+4
        addi    $t7, $t0, 0 # $t7 = smallindex = i
        secondWhile: # find smallest nth number
            beq $t1, 44, exitSecondWhile
            lw  $t5, oArray($t1)
            lw  $t6, oArray($t7)
            slt $t3, $t5, $t6 # $t3 = 1, if $t5 < $t6
            beqz $t3,exitIf
            addi $t7, $t1, 0
            exitIf:
            addi $t1, $t1, 4
            j   secondWhile
        exitSecondWhile:
        # swap array
        lw      $t9, oArray($t0)
        addi    $t4, $t9, 0
        lw      $t5, oArray($t7)
        sw      $t5, oArray($t0)
        sw      $t4, oArray($t7)
        addi    $t0, $t0, 4 # i += 4
        j       firstWhile
    exitFirstWhile:
        la      $a0,msg6
        li      $v0,4
        syscall
        jal     printArray
        lw      $t6, bit
        sub     $t5, $t2, $t6
        lw      $v1, oArray($t5)
        lw      $ra, 0($sp)
        addi    $sp, $sp, 4
        jr      $ra