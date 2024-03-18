   .text 
   .globl main

main:
la $t0,vektori       #adresa vektorit
addi $t0,$t0,4       #adresa+1
addi $t6,$t0,-4      #adresa-1
li $t1,1             #i=1
lw $t2,nr_anetareve  #n=7
lw $t3,sum_pre       #sum_pre=4
lw $t7,sum_post      #sum_post=0
lw $t8,vek7          #vektori(n-1)=1
forloop:
beq $t1, $t2, end    # if t1 ==7 shko te end
lw $t5,($t0)         #vektori[i]
add $t3,$t3,$t5      #sum_pre=sum_pre+vektori[i]
lw $t9,($t6)         #vektori[i-1]
add $t9,$t5,$t1      #vektori[i-1]=vektori[i]+i
add $t7,$t7,$t9      #sum_post=sum_post+vektori[i-1]
addi $t1, $t1, 1     # add 1 to t1
addi $t0,$t0,4       #update adresen 
j forloop            #jump te forloop
end:
sw  $t3,sum_pre      #ruaje sum_pre ne t3
add $t7,$t7,$t8      #sum_post=sum_post+vektori[n-1]
sw  $t7,sum_post     #ruaje sum_post ne t7
li $v0,10            #exit
syscall
.data
vektori: .word 4, 9, -3, -5, 6, 8, 1
nr_anetareve: .word 7
sum_post: .word 0
sum_pre:  .word 4
vek7:     .word 1