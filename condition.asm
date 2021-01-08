     .MODEL SMALL
 .STACK 100H
.DATA
    PROMPT_3  DB  'Enter Array type for sort 1 OR 2 :',0DH,0AH,'$'
        TYPE   DW  1 DUP(0)                      ;defines the array size as an array of one element
.CODE
.startup
 MOV AX, @DATA                ; initialize DS
     MOV DS, AX
     LEA DX, PROMPT_3            ; load and display the string PROMPT_1
     MOV AH, 9                    ;AH value for dos interrupt output a message
     INT 21H
     LEA AL, TYPE
cmp    al, 1    
je     BUBBLE_SORT      ; jump if al = 1(zf = 1). 
jmp    QUICK_SORT       ; 
.exit
end