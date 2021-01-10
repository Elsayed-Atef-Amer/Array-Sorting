 .MODEL SMALL
 .STACK 100H
 .DATA
    PROMPT_1  DW  'Enter Array size :$'
    PROMPT_2  DW  ,0AH,0DH,'The Array elements are :$'  
    PROMPT_3  DW  'array size cant be negative, please enter a POSITIVE number ',0AH,0DH,'$'
    PROMPT_4  DW  'please,choose Array type for sort (enter 1 for Bubble sort) OR (enter 2 for Quick sort) :$'  
    PROMPT_5  DW  'you can only choose 1 for bubble or 2 for Quick:',0AH,0DH,'$'
    ARRAY DW 255 DUP(?)
    
    
    
    
    
 .CODE
   MAIN PROC
     MOV AX, @DATA                ; initialize DS
     MOV DS, AX
     LEA DX, PROMPT_1             ; load and display the string PROMPT_1
     MOV AH, 9                    ;AH value for dos interrupt output a message
     INT 21H
     LEA SI, ARRAY                ; set SI=offset address of ARRAY
     CALL Array_SizeP              ; call the procedure READ_Size
     
     
     AND AX, 00FFH 
     
     MOV BX,AX                  ; to get the value of only AL as the size of array
   
     LEA DX, PROMPT_2             ; load and display the string PROMPT_2
     MOV AH, 9                    
     INT 21H
     
     CALL READ_ARRAY             ; call the procedure READ_ARRAY
     
     LEA DX, PROMPT_4            ; load and display the string PROMPT_4 to get the value of the condition variable (1,2).
     MOV AH, 9                    ;AH value for dos interrupt output a message
     INT 21H
     
     CALL CONDITION
     
  
     ;CALL BUBBLE_SORT
;-----------------------------------------------------------
;-----------------------------------------------------------------------------------------------------
;-----------------------------------------------------------------------------------------------------
;---------------------------------------------------------------------------------------------------
;----------------------------------------------------------------------------------------------------
;the array size element is stored in AL register at this point which is 8bit in size, for further edits 
;
;
;
;
;
     MOV AH, 4CH                  ;AH Value for dos interrupt exit program
     INT 21H
   MAIN ENDP
;-------------------------------------------------------------------------
;-------------------CONDITION PROC===-------------------------------------
;------------------------------------------------------------------------ 
 CONDITION PROC 
    
   @READ0:
   push cx

   push ax 
   push dx 
      push bx
xor cx,cx
xor bx,bx 
xor ax,ax

Mov AH,1                        ;read a character
INT 21h                         ;interrupt dos that takes input from user
     
cmp    al, '-'                  ;compare input with -
JE @NEGATIVE    
cmp al,'+'                      ;compare input with +
jE    @POSITIVE        
jmp @input0              
              



   
   
@NEGATIVE:
INC CL
JMP @ERROR0
   
   
@POSITIVE:
INC CL
JMP @ERROR0   
   
   
              
@INPUT0:
mov bl,al
                        ; jump label
     MOV AH, 1                    ; set input function
     INT 21H                      ; read a character

@SKIP_INPUT0:                 ; jump label

     CMP AL, 0DH                  ; compare AL with Return (enter)
     JE @END_INPUT0                ; jump to label @END_INPUT

     CMP AL, 8H                   ; compare AL with 8H   (backspace)
     JNE @NOT_BACKSPACE0           ; jump to label @NOT_BACKSPACE if AL!=8
 
 





                         
   
@MOVE_BACK0:                  ; jump label


     MOV AH, 2                    ; set output function
     MOV DL, 20H                  ; set DL=' '
     INT 21H                      ; print a character

     MOV DL, 8H                   ; set DL=8H
     INT 21H                      ; print a character

     XOR DX, DX                   ; clear DX
     DEC CL                       ; set CL=CL-1

     JMP @INPUT0                   ; jump to label @INPUT






        
        
        
@NOT_BACKSPACE0:              ; jump label

     INC CL                       ; set CL=CL+1

     CMP AL, 30H                  ; compare AL with 0
     JL @ERROR0                    ; jump to label @ERROR if AL<0

     CMP AL, 39H                  ; compare AL with 9
     JG @ERROR0                    ; jump to label @ERROR if AL>9

     AND AX, 000FH                ; convert ascii to decimal code

     PUSH AX                      ; push AX onto the STACK

     MOV AX, 10                   ; set AX=10
     MUL BX                       ; set AX=AX*BX
     MOV BX, AX                   ; set BX=AX

     POP AX                       ; pop a value from STACK into AX

     ADD BX, AX                   ; set BX=AX+BX
     JS @ERROR0                    ; jump to label @ERROR if SF=1
   JMP @INPUT0                     ; jump to label @INPUT
        
        
        
        
        
                         
@ERROR0:                        ; jump label

   MOV AH, 2                      ; set output function
   MOV DL, 7H                     ; set DL=7H
   INT 21H                        ; print a character
      
      
      @CLEAR0:                        ; jump label
     MOV DL, 8H                   ; set DL=8H (backspace in ascii)
     INT 21H                      ; print a character

     MOV DL, 20H                  ; set DL=' '    (Space in ascii)
     INT 21H                      ; print a character

     MOV DL, 8H                   ; set DL=8H          (backspace in ascii)
     INT 21H                      ; print a character
   LOOP @CLEAR0                    ; jump to label @CLEAR if CX!=0

   JMP @READ0                      ; jump to label @READ
       
 @END_INPUT0:                    ; jump label
           
           @CHECK_BUBBLE:  

    cmp bL,31h
    je @BUBBLE_SORT
    jne @CHECK_QUICK 
 
 
 
@CHECK_QUICK:
            cmp bL,32h
            je @QUICK_SORT 
            
            LEA DX, PROMPT_5
            MOV AH, 9
            INT 21H

            MOV CX,1
            Jne @ERROR0



@BUBBLE_SORT:
  
pop bx


        MOV CX, BX                       ; set CX=BX  
        dec CX
        
            MOV DS,CX
            MOV DX, DS
            OLOOP:
                MOV DX, DS
                LEA SI,ARRAY

            ILOOP:
                MOV AX, [SI]                 ; Because compare can't have both memory
                CMP AX, [SI+2]
                JL COMMON                      ; if al is less than [si+2] Skip the below two lines for swapping.
                XCHG AX, [SI+2]
                MOV [SI], AX                    ; Coz we can't use two memory locations in xchg directly.

                COMMON:
                ADD SI,2                      ; INCREAMENT BY TWO
                LOOP ILOOP

            DEC DX
            JNZ OLOOP

            MOV AH, 2                    ; set output function
            MOV DL, 20H                  ; set DL=20H
            INT 21H                      ; print a character

            ADD SI, 2                    ; set SI=SI+2
            

        
    


@QUICK_SORT:
            mov ah,4ch
            int 21h   
          
          
          
          
        POP DX                         ; pop a value from STACK into DX
        POP CX                         ; pop a value from STACK into CX
        POP BX                         ; pop a value from STACK into BX   
        pop AX
  CONDITION ENDP
;-------------------------------------------------------------------------
;------------------------------------------------------------------------
 INDECIMAL PROC
   ; this procedure will read a number in decimal form    
   ; input : none
   ; output : store binary number in AX
   PUSH BX                        ; push BX onto the STACK
   PUSH CX                        ; push CX onto the STACK
   PUSH DX                        ; push DX onto the STACK
   JMP @READ                      ; jump to label @READ
   @SKIP_BACKSPACE:               ; jump label
   MOV AH, 2                      ; set output function
   MOV DL, 20H                    ; set DL=' '
   INT 21H                        ; print a character
   @READ:                         ; jump label
   XOR BX, BX                     ; clear BX
   XOR CX, CX                     ; clear CX
   XOR DX, DX                     ; clear DX
   MOV AH, 1                      ; set input function
   INT 21H                        ; read a character
   CMP AL, "-"                    ; compare AL with "-"
   JE @MINUS                      ; jump to label @MINUS if AL="-"
   CMP AL, "+"                    ; compare AL with "+"
   JE @PLUS                       ; jump to label @PLUS if AL="+"
   JMP @SKIP_INPUT                ; jump to label @SKIP_INPUT
   @MINUS:                        ; jump label
   MOV CH, 1                      ; set CH=1
   INC CL                         ; set CL=CL+1
   JMP @INPUT                     ; jump to label @INPUT
   
   @PLUS:                         ; jump label
   MOV CH, 2                      ; set CH=2
   INC CL                         ; set CL=CL+1
   @INPUT:                        ; jump label
     MOV AH, 1                    ; set input function
     INT 21H                      ; read a character
     @SKIP_INPUT:                 ; jump label
     CMP AL, 0DH                  ; compare AL with CR
     JE @END_INPUT                ; jump to label @END_INPUT
     CMP AL, 8H                   ; compare AL with 8H
     JNE @NOT_BACKSPACE           ; jump to label @NOT_BACKSPACE if AL!=8
     CMP CH, 0                    ; compare CH with 0
     JNE @CHECK_REMOVE_MINUS      ; jump to label @CHECK_REMOVE_MINUS if CH!=0
     CMP CL, 0                    ; compare CL with 0
     JE @SKIP_BACKSPACE           ; jump to label @SKIP_BACKSPACE if CL=0
     JMP @MOVE_BACK               ; jump to label @MOVE_BACK
     @CHECK_REMOVE_MINUS:         ; jump label
     CMP CH, 1                    ; compare CH with 1
     JNE @CHECK_REMOVE_PLUS       ; jump to label @CHECK_REMOVE_PLUS if CH!=1
     CMP CL, 1                    ; compare CL with 1
     JE @REMOVE_PLUS_MINUS        ; jump to label @REMOVE_PLUS_MINUS if CL=1
     @CHECK_REMOVE_PLUS:          ; jump label
     CMP CL, 1                    ; compare CL with 1
     JE @REMOVE_PLUS_MINUS        ; jump to label @REMOVE_PLUS_MINUS if CL=1
     JMP @MOVE_BACK               ; jump to label @MOVE_BACK
     @REMOVE_PLUS_MINUS:          ; jump label
       MOV AH, 2                  ; set output function
       MOV DL, 20H                ; set DL=' '
       INT 21H                    ; print a character
       MOV DL, 8H                 ; set DL=8H
       INT 21H                    ; print a character
       JMP @READ                  ; jump to label @READ
                                  
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
   XOR CH, CH                     ; clear CH
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
   RET                            ; return control to the calling procedure
 INDECIMAL ENDP
 
 ;**************************************************************************;
 ;-----------------------------  READ_ARRAY  -------------------------------;
 ;**************************************************************************;
 
 READ_ARRAY PROC
   ; this procedure will read the elements for an array
   ; input : SI=offset address of the array
   ;       : BX=size of the array
   ; output : none
   PUSH AX                        ; push AX onto the STACK
   PUSH CX                        ; push CX onto the STACK
   PUSH DX                        ; push DX onto the STACK
   
   MOV CX, BX                     ; set CX=BX
   @READ_ARRAY:                   ; loop label
     CALL INDECIMAL                   ; call the procedure INDECIMAL
     MOV [SI], AX                 ; set [SI]=AX
     ADD SI, 2                    ; set SI=SI+2
     MOV DL, 0AH                  ; line feed
     MOV AH, 2                    ; set output function
     INT 21H                      ; print a character
   LOOP @READ_ARRAY               ; jump to label @READ_ARRAY while CX!=0
   POP DX                         ; pop a value from STACK into DX
   POP CX                         ; pop a value from STACK into CX
   POP AX                         ; pop a value from STACK into AX
   RET                            ; return control to the calling procedure
   READ_ARRAY ENDP
   
   ;------------------------------------------------------------------------------
   ;------------------------------------------------------------------------------
   ;---------------------------------------------------------------------------------
   ;---------------------------------------------------------------------------------
   
   
   
    Array_SizeP PROC
        ; this procedure will read the array size from the user as a positive number between 0 and 255
    
   PUSH BX                        ; push BX onto the STACK
   PUSH CX                        ; push CX onto the STACK
   PUSH DX                        ; push DX onto the STACK
   JMP @READ1                      ; jump to label @READ
   @SKIP_BACKSPACE1:               ; jump label
   MOV AH, 2                      ; set output function
   MOV DL, 20H                    ; set DL=' '
   INT 21H                        ; print a character
   @READ1:                         ; jump label
   XOR BX, BX                     ; clear BX
   XOR CX, CX                     ; clear CX
   XOR DX, DX                     ; clear DX
   MOV AH, 1                      ; set input function
   INT 21H                        ; read a character
   CMP AL, "-"                    ; compare AL with "-"
   INC CL
   JE @ERROR2                     ; jump to label @ERROR2 if AL="-"
   CMP AL, "+"                    ; compare AL with "+"
   JE @PLUS1                       ; jump to label @PLUS if AL="+"
   JMP @SKIP_INPUT1                ; jump to label @SKIP_INPUT
   
   @PLUS1:                         ; jump label
   MOV CH, 2                      ; set CH=2
   INC CL                         ; set CL=CL+1
   @INPUT1:                        ; jump label
     MOV AH, 1                    ; set input function
     INT 21H                      ; read a character
     @SKIP_INPUT1:                 ; jump label
     CMP AL, 0DH                  ; compare AL with CR
     JE @END_INPUT1                ; jump to label @END_INPUT
     CMP AL, 8H                   ; compare AL with 8H
     JNE @NOT_BACKSPACE1           ; jump to label @NOT_BACKSPACE if AL!=8
     CMP CH, 0                    ; compare CH with 0
     JNE @CHECK_REMOVE_PLUS1      ; jump to label @CHECK_REMOVE_MINUS if CH!=0
     CMP CL, 0                    ; compare CL with 0
     JE @SKIP_BACKSPACE1           ; jump to label @SKIP_BACKSPACE if CL=0
     JMP @MOVE_BACK1               ; jump to label @MOVE_BACK
     CMP CL, 1                    ; compare CL with 1
     JE @REMOVE_PLUS1        ; jump to label @REMOVE_PLUS_MINUS if CL=1
     @CHECK_REMOVE_PLUS1:          ; jump label
     CMP CL, 1                    ; compare CL with 1
     JE @REMOVE_PLUS1        ; jump to label @REMOVE_PLUS_MINUS if CL=1
     JMP @MOVE_BACK1               ; jump to label @MOVE_BACK
     @REMOVE_PLUS1:          ; jump label
       MOV AH, 2                  ; set output function
       MOV DL, 20H                ; set DL=' '
       INT 21H                    ; print a character
       MOV DL, 8H                 ; set DL=8H
       INT 21H                    ; print a character
       JMP @READ1                  ; jump to label @READ
                                  
     @MOVE_BACK1:                  ; jump label
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
     JMP @INPUT1                   ; jump to label @INPUT
     @NOT_BACKSPACE1:              ; jump label
     INC CL                       ; set CL=CL+1
     CMP AL, 30H                  ; compare AL with 0
     JL @ERROR1                    ; jump to label @ERROR if AL<0
     CMP AL, 39H                  ; compare AL with 9
     JG @ERROR1                    ; jump to label @ERROR if AL>9
     AND AX, 000FH                ; convert ascii to decimal code
     PUSH AX                      ; push AX onto the STACK
     MOV AX, 10                   ; set AX=10
     MUL BX                       ; set AX=AX*BX
     MOV BX, AX                   ; set BX=AX
     POP AX                       ; pop a value from STACK into AX
     ADD BX, AX                   ; set BX=AX+BX
     JS @ERROR1                    ; jump to label @ERROR if SF=1
   JMP @INPUT1                     ; jump to label @INPUT
   @ERROR1:                        ; jump label
   MOV AH, 2                      ; set output function
   MOV DL, 7H                     ; set DL=7H
   INT 21H                        ; print a character
   XOR CH, CH                     ; clear CH
    @ERROR2:                        ; jump label
   LEA DX, PROMPT_3 
   MOV AH, 9
   INT 21H
   RET
   
   @CLEAR1:                        ; jump label
     MOV DL, 8H                   ; set DL=8H   (backspace in ascii)
     INT 21H                      ; print a character
     MOV DL, 20H                  ; set DL=' '         (Space in ascii)
     INT 21H                      ; print a character
     MOV DL, 8H                   ; set DL=8H          (backspace in ascii)
     INT 21H                      ; print a character
   LOOP @CLEAR1                    ; jump to label @CLEAR if CX!=0
   JMP @READ1                      ; jump to label @READ
   @END_INPUT1:                    ; jump label
   CMP CH, 1                      ; compare CH with 1   
   JNE @EXIT1                      ; jump to label @EXIT if CH!=1
   NEG BX                         ; negate BX
   @EXIT1:                         ; jump label
   MOV AX, BX                     ; set AX=BX
   POP DX                         ; pop a value from STACK into DX
   POP CX                         ; pop a value from STACK into CX
   POP BX                         ; pop a value from STACK into BX
   RET                            ; return control to the calling procedure 
   Array_SizeP ENDP   
   
   
   
    ;**************************************************************************;
 ;--------------------------------  OUTDEC  --------------------------------;
 ;**************************************************************************;
 OUTDEC PROC
   ; this procedure will display a decimal number
   ; input : AX
   ; output : none

   PUSH BX                        ; push BX onto the STACK
   PUSH CX                        ; push CX onto the STACK
   PUSH DX                        ; push DX onto the STACK
   
   CMP AX, 0                      ; compare AX with 0
   JGE @START                     ; jump to label @START if AX>=0
     PUSH AX                        ; push AX onto the STACK

   MOV AH, 2                      ; set output function
   MOV DL, "-"                    ; set DL='-'
   INT 21H                        ; print the character

   POP AX                         ; pop a value from STACK into AX

   NEG AX                         ; take 2's complement of AX

   @START:                        ; jump label

   XOR CX, CX                     ; clear CX
   MOV BX, 10                     ; set BX=10

   @OUTPUT:                       ; loop label
     XOR DX, DX                   ; clear DX
     DIV BX                       ; divide AX by BX
     PUSH DX                      ; push DX onto the STACK
     INC CX                       ; increment CX
     OR AX, AX                    ; take OR of Ax with AX
   JNE @OUTPUT                    ; jump to label @OUTPUT if ZF=0

   MOV AH, 2                      ; set output function

   @DISPLAY:                      ; loop label
     POP DX                       ; pop a value from STACK to DX
     OR DL, 30H                   ; convert decimal to ascii code
     INT 21H                      ; print a character
   LOOP @DISPLAY                  ; jump to label @DISPLAY if CX!=0                       
                                                                      
   POP DX                         ; pop a value from STACK into DX      
   POP CX                         ; pop a value from STACK into CX       
   POP BX                         ; pop a value from STACK into BX

   RET                            ; return control to the calling procedure
 OUTDEC ENDP
   
   
   
  

 END MAIN
 
 END MAIN
