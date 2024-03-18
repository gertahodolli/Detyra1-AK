.data
n: .word 6                         #n=6
vektori1: .word 5, 4, 9, 17, 31, 8 #vektroi1 i deklaruar
vektori2: .word -5, 2, 3, 4, 6, -3 #vektori2 i deklaruar
sum: .word 0                       # sum=0
rezultati:   .asciiz "Rezultati operacionit: "


.text
.globl main

main:
   lw $a0,n                 # "load word" ruaje n(gjatesine e vektorit) ne regjistrin $a0 => int n=6
   la $a1,vektori1          # "load address" adresen e vektorit 1 te deklaruar ne .data ruaje ne regjistrin $a1
   la $a2,vektori2          # "load address" adresen e vektorit 2 te deklaruar ne .data ruaje ne regjistrin $a2
   
jal operacioniMeVektore     # "jump and link" jump tek funkisoni operacioniMeVektore kudo qe te jete me poshte
   move $s7,$v0             # pas perfunimit te funkisonit rezultati i fituar te vendoset ne regjistrin $s7

   li $v0,4                 # syscalli-i per te printuar nje string =>" Rezultati i operacionit: "
   la $a0,rezultati         
   syscall

   li $v0,1                 #syscalli per te printuar nje integer => sum-in qe e kemi llogaritur 
   move $a0, $s7             
   syscall

   li $v0,10                #syscalli per perfundim te programit
   syscall

operacioniMeVektore:
   li $t0,0                 # "load immediate" ne regjistrin $t0 ruaje vleren 0 =>i=0 
   li $t1,0                 # "load immediate" ne regjistrin $t1 ruaje vleren 0 =>sum=0

loop_1:                     # fillimi i loop-es se pare
   bne $t0,$a0, continue    # "branch if not equal" krahason $t0 me $a0 =>nese i=n shko te label continue
   jr $ra                   # "jump register" na dergon tek $ra ku e kemi ruajtur adresen e kthimit 

continue:
   lw $t2,0($a1)            # "load word" ne $t0 ruajm adresen e vektori1[i]    
   move $t3,$t2             # ne $t3 vendosim $t2 => temp1=vektori1[i]         
   addi $t0,$t0,1           # "add immediate" $t0=$t0+1 e rrisim i per nje =>i++        
   addi $a1,$a1,4           # "add immediate" $a1=$a1+4 e rrisim adreesen e vektorit 1 per 4 
   lw $t4,20($a2)           # "load word" ne $t4 e ruajm antarin e parafundit te vektorit 2, numri 20 na tregon offsetin (nje integer ne memorie ze 4 bajat(32 bita) dhe nese na duhet anatri i 5 duhet qe ta bejme 4*5=20 =>vektori2[n-1] ne c++ e kemi n-1 per shkak se fillon numrim nga 0 dhe antari i fundit konsiderohet n-1               
   move $t5,$t2             # ne $t5 vendosim $t2 =>temp2=vektori2[n-1]             
   sub $t0,$t0, 1           # $t0=$t0-1 ne kete rast e zbresim i-ne per nje =>i--, ashtu qe te fitojme vektori2[n-1-i]   
   sub $a2,$a2, 4           # $t2=$t2-4  adresen e vektorit2 e zbresim per 4         
   add $t6,$t3,$t5          # $t6=$t3+$t5 =>vektori1[i]=temp1+temp2            
   sub $t7,$t3,$t5          # $t7=$t3-$t5 =>vektori2[n-1-i]=temp1-temp2
   add $t8,$t6,$t7          # $t8=$t6+$t7 =>$t8=vektori1[i]+vektori2[n-1-i]

   add $t1,$t1,$t8          # $t1=$t1+$t6 =>sum=sum+$t8(vektori1[i]+vektori2[n-1-i])
   addi $t0,$t0,1           # $t0=$t0+1 =>i++
   sw $t1,sum               # "save word" ruaj vlerën e $t1 në adresën e përcaktuar nga sum 
   move $v0,$t1             # ne $v0 vendose $t1 => shumen vendose ne $v0
j loop_1                    # "jump" jump tel loop_1 per te perseritur operacionin me vlera te tjera
                


