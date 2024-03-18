    .text
    .globl main

    main:
    li $s0,5
    jal populloVektorin

    move $a0,$s0
    move $a1,$v0
    jal unazaKalimit
    li $v0,10
    syscall


    populloVektorin:
    la $t1,vektori  #adresa vektorit
    li $v0,4        #read a string
    la $a0,msg1     # adresa e msg1
    syscall         #ekzekuto
    li $v0,5        #read an integer
    syscall      
    move $t0,$v0    #vendose adresen e v0 ne t0 ne menyre qe te bejme return
    read_loop:  
    la $a0,msg2     #adresa e msg2
    li $v0,4        #read a string
    syscall
    li $v0,5        # read an integer
    syscall
    sw $v0,0($t1)   # ruaje int qe eshte shtypur
    add $t0,$t0,-1  # zbrite numrin e intave per nje
    add $t1,$t1,4   # load adresen e int tjeter
    bgtz $t0,read_loop  # branch to read and store the next integer
    jr $ra



    unazaKalimit:
    addi $sp, $sp, -24		# save values on stack
    sw	$ra, 0($sp)
    sw	$s0, 4($sp)           #p
    sw	$s1, 8($sp)            #n
    sw	$s2, 12($sp)          #min
    sw	$s3, 16($sp)           #a[]
    sw  $s4, 20($sp)           #loc


    sll  $t8,$s4,2              #loc*4
    add $t8,$t8,$s3             #a[loc]
    addi $s0,$zero,1             #p
    addi $s2,$s1,-1               #n-1
    forloop1:
    slt $t9,$s0,$s2              #p<n-1?
    beq $t9,$zero,end1           # nese nuk eshte kce te end1
    lw $s5,($s3)                 #a[p]
    add $s2,$s5,$zero            #min=a[p]
    add $s4,$s5,$zero            #loc=p
    move $a0,$s0            
    move $a1,$s1
    move $a2,$s2
    move $a3,$s3
    move $s0,$s4

    jal unazaVlerave

 
    add $s6,$s5,$zero          #tmp=a[p]
    add $s5,$t8,$zero          #a[p]=a[loc]
    add $t8,$s6,$zero           #a[loc]=tmp
    add $s0,$s0,1               #i++
    addi $s3,$s3,4              #update adresen
    end1:
    lw	$ra, 0($sp)
    lw	$s0, 4($sp) #p
    lw	$s1, 8($sp)  #n
    lw	$s2, 12($sp) #min
    lw	$s3, 16($sp) #a[]
    lw  $s4, 20($sp) #loc
    addi $sp,$sp,24

    li $v0,4
    la $a0,msg3
    syscall
    li $t0,1
    sll	$t6, $t4, 2		# $t0=i*4
    print_loop:
    bgt $t0,$t4,exit
    lw $s7,($t3)
    li $v0,1
    move $a0,$s7
    syscall
    addi $t0,$t0,1
    addi $t3,$t3,4
    exit:
    jr $ra
    
    unazaVlerave:
    move $t0,$a0  #p
    move $t1,$a1  #n
    move $t2,$a2  #min
    move $t3,$a3  #a[]
    move $t4,$s0  #loc

    addi $t5,$t0,1
    forloop:
    lw $t7,($t3)                    #adresa e vektorit,a[k]
    slt $t6,$t5,$t1                  #k<=n
    beq $t6,$zero,end                #nese nuk eshte kce te endloop
    bge $t7,$t2,endif                #a[k]>=min kce te endif
    add $t2,$t7,$zero                #min=a[k]
    add $t4,$t5,$zero                 #loc=k

    endif:
    addi $t5,$t5,1
    addi $t3,$t3,4
    j forloop
    endloop:
    jr $ra
     
    .data
    vektori: .space 20 #4x5
    msg1: .asciiz "Jepni numrin e anetareve  te vektorit(max 5):"
    msg2: .asciiz "Shtyp elementet nje nga nje:"
    newline: .asciiz "\n"
    msg3: .asciiz "\nVlerat e mesazhit ne fund:\n"
