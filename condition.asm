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
     
     
     
     
@READ: 
xor cx,cx
xor bx,bx 
xor ax,ax

Mov AH,1                        ;read a character
INT 21h                         ;interrupt dos
     
cmp    al, '-'                  ;compare input with -
JE @NEGATIVE    
cmp al,'+'                      ;compare input with +
jE    @POSITIVE        
              
              
@CHECK_BUBBLE:  

    cmp AL,31h
    je @BUBBLE_SORT
    jne @CHECK_QUICK 
 
 
 
@CHECK_QUICK:
            cmp AL,32h
            je @QUICK_SORT 

            MOV CX,1
            Jne @ERROR

@BUBBLE_SORT:
    
             mov ah,4ch
             int 21h
    


@QUICK_SORT:
            mov ah,4ch
            int 21h   
   
   
@NEGATIVE:
INC CL
JMP @ERROR
   
   
@POSITIVE:
INC CL
JMP @ERROR   
   
   
              
@INPUT:                        ; jump label
     MOV AH, 1                    ; set input function
     INT 21H                      ; read a character

@SKIP_INPUT:                 ; jump label

     CMP AL, 0DH                  ; compare AL with Return (enter)
     JE @END_INPUT                ; jump to label @END_INPUT

     CMP AL, 8H                   ; compare AL with 8H   (backspace)
     JNE @NOT_BACKSPACE           ; jump to label @NOT_BACKSPACE if AL!=8
 
 





                         
   
@MOVE_BACK:                  ; jump label

     MOV AX, BX                   ; set AX=BX
     MOV BX, 10                   ; set BX=10
     DIV BX                       ; set AX=AX/BX

     MOV BX, AX                   ; set BX=AX

     MOV AH, 2                    ; set output function
     MOV DL, 20H                  ; set DL=' '
     INT 21H                      ; print a character

     MOV DL, 8H                   ; set DL=8H
     INT 21H                      ; print a character

     XOR DX, DX                   ; clear DX
     DEC CL                       ; set CL=CL-1

     JMP @INPUT                   ; jump to label @INPUT






        
        
        
@NOT_BACKSPACE:              ; jump label

     INC CL                       ; set CL=CL+1

     CMP AL, 30H                  ; compare AL with 0
     JL @ERROR                    ; jump to label @ERROR if AL<0

     CMP AL, 39H                  ; compare AL with 9
     JG @ERROR                    ; jump to label @ERROR if AL>9

     AND AX, 000FH                ; convert ascii to decimal code

     PUSH AX                      ; push AX onto the STACK

     MOV AX, 10                   ; set AX=10
     MUL BX                       ; set AX=AX*BX
     MOV BX, AX                   ; set BX=AX

     POP AX                       ; pop a value from STACK into AX

     ADD BX, AX                   ; set BX=AX+BX
     JS @ERROR                    ; jump to label @ERROR if SF=1
   JMP @INPUT                     ; jump to label @INPUT
        
        
        
        
        
                         
@ERROR:                        ; jump label

   MOV AH, 2                      ; set output function
   MOV DL, 7H                     ; set DL=7H
   INT 21H                        ; print a character
      
      
      @CLEAR:                        ; jump label
     MOV DL, 8H                   ; set DL=8H (backspace in ascii)
     INT 21H                      ; print a character

     MOV DL, 20H                  ; set DL=' '    (Space in ascii)
     INT 21H                      ; print a character

     MOV DL, 8H                   ; set DL=8H          (backspace in ascii)
     INT 21H                      ; print a character
   LOOP @CLEAR                    ; jump to label @CLEAR if CX!=0

   JMP @READ                      ; jump to label @READ
       
 @END_INPUT:                    ; jump label

   CMP CH, 1                      ; compare CH with 1   
   JNE @EXIT                      ; jump to label @EXIT if CH!=1
   NEG BX                         ; negate BX

   @EXIT:                         ; jump label

   MOV AX, BX                     ; set AX=BX

   POP DX                         ; pop a value from STACK into DX
   POP CX                         ; pop a value from STACK into CX
   POP BX                         ; pop a value from STACK into BX




.exit
end
