.MODEL SMALL
 .STACK 100H
 .DATA
 
    PROMPT_1  DW  'Enter Array size :$'
    PROMPT_2  DW  ,0AH,0DH,'The Array elements are :$'  
    PROMPT_3  DW  'array size cant be negative, please enter a POSITIVE number ',0AH,0DH,'$'
    PROMPT_4  DW  'please,choose Array type for sort (enter 1 for Bubble sort) OR (enter 2 for SELECTION sort) :$'  
    PROMPT_5  DW  'you can only choose 1 for bubble or 2 for Selection:',0AH,0DH,'$'
    PROMPT_6  DW  ,0AH,0DH,'your sorted array is:$'
    PROMPT_7  DW  ,0AH,0DH,'your sorted reverse array is:$'
    PROMPT_8  DW  ,0AH,0DH,'your Array has no elements,please enter POSITIVE integer:$'
    ARRAY DW 255 DUP(?)    
 
 .CODE
 
  MAIN PROC
  
     MOV AX, @DATA                ; initialize data segment ds
     MOV DS, AX
     LEA DX, PROMPT_1             ; load and display the string PROMPT_1,  user interface(UI) , to take the first array size from user.
     MOV AH, 9                    ;AH value for dos interrupt output a message
     INT 21H                      ;interrupt dos that takes input from user
    
     LEA SI, ARRAY                ; set SI=offset address of ARRAY
    
    @No_Elements:
     CALL Array_SizeP             ; call the procedure READ_Size
     AND AX, 00FFH                ; to get the value of only AL as the size of array
     MOV BX,AX                    ; put value of AL in to BX register BX=AX
     CMP BX,0                     ; IF input==0
     je @No_Elements1             ; JUMP to No_Elements1 lable if the input equals(0)
     
     LEA DX, PROMPT_2             ; load and display the string PROMPT_2, user interface(UI), to take the farray elements from user.
     MOV AH, 9                    ;AH value for dos interrupt output a message
     INT 21H                      ;interrupt dos that takes input from user
     
     CALL READ_ARRAY              ; call the procedure READ_ARRAY
     
     LEA DX, PROMPT_4             ; load and display the string PROMPT_4 to get the value of the condition variable (1,2).
     MOV AH, 9                    ;AH value for dos interrupt output a message
     INT 21H                      ; interrupt
    
     LEA SI,ARRAY                 ; load array offset to SI
     CALL CONDITION               ; call condition function to make a decision of sort type to use 
 
    @No_Elements1:
     LEA DX, PROMPT_8             ; load and display the string PROMPT_8
     MOV AH, 9                    ;AH value for dos interrupt output a message
     INT 21H                      ;interrupt dos that takes input from user
     jmp @No_Elements             ; jump No_Elements label 
     
     MOV AH, 4CH                  ;AH Value for dos interrupt exit program
     INT 21H                      ;interrupt dos that takes input from user              
 
  MAIN ENDP

;-------------------CONDITION function-----------------------------------
   CONDITION PROC 
   
    @READ0:
     PUSH CX                      ; push CX onto the STACK  
     PUSH AX                      ; push AX onto the STACK  
     PUSH DX                      ; push DX onto the STACK  
     PUSH BX                      ; push BX onto the STACK  
    
     XOR CX,CX                    ; make CX register equals to zero, CX==0
     XOR BX,BX                    ; make BX register equals to zero, BX==0
     XOR AX,AX                    ; make AX register equals to zero, AX==0
     
     Mov AH,1                     ;read a character
     INT 21h                      ;interrupt dos that takes input from user
     
     cmp    al, '-'               ;compare input with -
     JE @NEGATIVE                 ; JUMP to NEGATIVE lable if the input equals(-)
     
     cmp al,'+'                   ;compare input with +
     jE @POSITIVE                 ; JUMP to POSITIVE lable if the input equals(+)       
     jmp @input0                  ; JUMP to input0 lable        
              
    @NEGATIVE:                    ; NEGATIVE lable
     INC CL                       ; CL=CL+1
     JMP @ERROR0                  ; JUMP to ERROR0 lable
   
    @POSITIVE:                    ; POSITIVE lable
     INC CL                       ; CL=CL+1
     JMP @ERROR0                  ; JUMP to ERROR0 lable 
                 
    @INPUT0:                      ; INPUT0 lable
     MOV BL,AL                    ; BL=AL
     MOV AH, 1                    ;read a character
     INT 21H                      ;interrupt dos that takes input from user

    @SKIP_INPUT0:                 ; SKIP_INPUT0 label
     CMP AL, 0DH                  ; compare AL with Return (enter)
     JE @END_INPUT0               ; jump to label @END_INPUT if the input equals (enter)  

     CMP AL, 8H                   ; compare AL with 8H   (backspace)
     JNE @NOT_BACKSPACE0          ; jump to label @NOT_BACKSPACE if AL!=8
 
    @MOVE_BACK0:                  ; MOVE_BACK0 label
     MOV AH, 2                    ; set output function
     MOV DL, 20H                  ; set DL=' '
     INT 21H                      ; print a character
     MOV DL, 8H                   ; set DL=8H
     INT 21H                      ; print a character
     XOR DX, DX                   ; clear DX
     DEC CL                       ; set CL=CL-1
     JMP @INPUT0                  ; jump to label @INPUT0     
        
    @NOT_BACKSPACE0:              ; NOT_BACKSPACE0 label
     INC CL                       ; set CL=CL+1
     CMP AL, 30H                  ; compare AL with 0
     JL @ERROR0                   ; jump to label @ERROR0if AL<0
     CMP AL, 39H                  ; compare AL with 9
     JG @ERROR0                   ; jump to label @ERROR0if AL>9
     AND AX, 000FH                ; convert ascii to decimal code
     
     PUSH AX                      ; push AX onto the STACK
     MOV AX, 10                   ; set AX=10
     MUL BX                       ; set AX=AX*BX
     MOV BX, AX                   ; set BX=AX
     POP AX                       ; pop a value from STACK into AX
     ADD BX, AX                   ; set BX=AX+BX
     JS @ERROR0                   ; jump to label @ERROR if SF=1
     JMP @INPUT0                  ; jump to label @INPUT0       
                         
    @ERROR0:                      ; ERROR0 label
     MOV AH, 2                    ; set output function
     MOV DL, 7H                   ; set DL=7H
     INT 21H                      ; print a character
     
    @CLEAR0:                      ; CLEAR0 label
     MOV DL, 8H                   ; set DL=8H (backspace in ascii)
     INT 21H                      ; print a character
     MOV DL, 20H                  ; set DL=' '(Space in ascii)
     INT 21H                      ; print a character
     MOV DL, 8H                   ; set DL=8H (backspace in ascii)
     INT 21H                      ; print a character 
    LOOP @CLEAR0                  ; jump to label @CLEAR0 if CX!=0
    JMP @READ0                    ; jump to label @READ0
       
   @END_INPUT0:                   ; END_INPUT0 label
   
   @CHECK_BUBBLE:                 ; CHECK_BUBBLE label
    CMP BL,31h                    ; check if input equals to ASKII(1)
    JE @BUBBLE_SORT               ; JUMP to BUBBLE_SORT if input equals to ASKII(1)

   @CHECK_SELECT:                 ; CHECK_SELECT label
    CMP BL,32h                    ; check if input equals to ASKII(2)
    JE @SELECT_SORT               ; JUMP to SELECT_SORT if input equals to ASKII(2)
    LEA DX, PROMPT_5              ; load and display the string PROMPT_5, user interface(UI), to take a nother input from user.
    MOV AH, 9                     ;AH value for dos interrupt output a message
    INT 21H                       ;interrupt dos that takes input from user
    MOV CX,1                      ; CX=1
    Jne @ERROR0                   ; JUMP to ERROR0 if input not equals to ASKII(2)            

   @BUBBLE_SORT:
    POP BX                        ; pop a value from STACK into BX
    MOV AX, SI                    ; set AX=SI
    MOV CX, BX                    ; set CX=BX
    PUSH BX                       ; push BX onto the STACK  
    CMP CX,1                      ; IF CX<=1
    JLE  @Skip_Dec                ; JUMP TO Skip_Dec lable
    DEC CX                        ; set CX=CX-1
   
   @OUTER_LOOP:                   ; loop label
    MOV BX, CX                    ; set BX=CX
    MOV SI, AX                    ; set SI=AX
    MOV DI, AX                    ; set DI=AX
    INC DI
    INC DI                        ; set DI=DI+2
     @INNER_LOOP:                 ; loop label 
       MOV DX, [SI]               ; set DL=[SI]
       CMP DX, [DI]               ; compare DL with [DI]
       JNG @SKIP_EXCHANGE         ; jump to label @SKIP_EXCHANGE if DL<[DI]
       XCHG DX, [DI]              ; set DL=[DI], [DI]=DL
       MOV [SI], DX               ; set [SI]=DL
     @SKIP_EXCHANGE:              ; SKIP_EXCHANGE label
      INC SI 
      INC SI                      ; set SI=SI+2
      INC DI
      INC DI                      ; set DI=DI+2
      DEC BX                      ; set BX=BX-1
     JNZ @INNER_LOOP              ; jump to label @INNER_LOOP if BX!=0
    LOOP @OUTER_LOOP              ; jump to label @OUTER_LOOP while CX!=0
   
    @Skip_dec:                    ;Skip_dec label
     jmp @ENDSORT                 ; jump to label @ENDSORT 

    @SELECT_SORT:
     POP BX                       ; pop a value from STACK into BX   
     CMP BX, 1                    ; compare BX with 1
     PUSH BX                      ; push BX onto the STACK                      
     JLE @SKIP_SORTING            ; jump to label @SKIP_SORTING if BX<=1
     PUSH BX                      ; push BX onto the STACK    
     DEC BX                       ; set BX=BX-1
     MOV CX, BX                   ; set CX=BX
     MOV AX, SI                   ; set AX=SI
     
     @OUTER_LOOP2:                ; loop label
      MOV BX, CX                  ; set BX=CX
      MOV SI, AX                  ; set SI=AX
      MOV DI, AX                  ; set DI=AX
      MOV DX, [DI]                ; set DL=[DI]

      @INNER_LOOP2:               ; loop label
       INC SI                     ; set SI=SI+1
       INC SI                     ; set SI=SI+1
       CMP [SI], DX               ; compare [SI] with DL
       JNG @SKIP2                 ; jump to label @SKIP if [SI]<=DL
       MOV DI, SI                 ; set DI=SI
       MOV DX, [DI]               ; set DL=[DI]
       @SKIP2:                    ; SKIP2 label
       DEC BX                     ; set BX=BX-1
     JNZ @INNER_LOOP2             ; jump to label @INNER_LOOP2 if BX!=0
     MOV DX, [SI]                 ; set DL=[SI]
     XCHG DX, [DI]                ; set DL=[DI] , [DI]=DL
     MOV [SI], DX                 ; set [SI]=DL
    LOOP @OUTER_LOOP2             ; jump to label @OUTER_LOOP2 while CX!=0
   
    @SKIP_SORTING:                ; SKIP_SORTING label    
     @ENDSORT:                    ; ENDSORT label                                      
      LEA DX, PROMPT_6            ; load and display the string PROMPT_6 
      MOV AH, 9                   ;AH value for dos interrupt output a message
      INT 21H           
      LEA SI, ARRAY               ; set SI=offset address of ARRAY
      POP BX                      ; pop a value from STACK into BX
      CALL PRINT_ARRAY            ; call the procedure PRINT_ARRAY
      LEA DX, PROMPT_7            ; load and display the string PROMPT_7 
      MOV AH, 9                   ;AH value for dos interrupt output a message
      INT 21H
      CALL PRINT_ARRAY_REVERSE  ; call the procedure PRINT_ARRAY_REVERSE
      MOV AH, 4CH                  ; return control to DOS
      INT 21H
      MOV AH, 4CH                  ; return control to DOS
      INT 21H
      RET 
  CONDITION ENDP
;-------------------------------------------------------------------------
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
 ;-----------------------------  READ_ARRAY  -------------------------------;
 
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
 ;--------------------------------  OUTDEC  --------------------------------;
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
 PRINT_ARRAY PROC
   ; this procedure will print the elements of a given array
   ; input : SI=offset address of the array
   ;       : BX=size of the array
   ; output : none
   PUSH AX                        ; push AX onto the STACK   
   PUSH CX                        ; push CX onto the STACK
   PUSH DX                        ; push DX onto the STACK
   MOV CX, BX                     ; set CX=BX
   @PRINT_ARRAY:                  ; loop label
     XOR AH, AH                   ; clear AH
     MOV AX, [SI]                 ; set AL=[SI]
     CALL OUTDEC                  ; call the procedure OUTDEC
     MOV AH, 2                    ; set output function
     MOV DL, 20H                  ; set DL=20H
     INT 21H                      ; print a character

     INC SI                       ; set SI=SI+2
     INC SI
   LOOP @PRINT_ARRAY              ; jump to label @PRINT_ARRAY while CX!=0

   POP DX                         ; pop a value from STACK into DX
   POP CX                         ; pop a value from STACK into CX
   POP AX                         ; pop a value from STACK into AX

   RET                            ; return control to the calling procedure
 PRINT_ARRAY ENDP
  PRINT_ARRAY_REVERSE PROC
    ; this procedure will print reverse the elements of a given array
   ; input : SI=offset address of the array
   ;       : BX=size of the array  
   ; output : none 
   PUSH AX                        ; push AX onto the STACK   
   PUSH CX                        ; push CX onto the STACK
   PUSH DX                        ; push DX onto the STACK 
   LEA SI,ARRAY                    
   MOV CX,BX                         ;CX=CX+BX
   MOV DI,SI                        ;set DI=SI
   SUB BX,1                         ;set bx=bx-1 
   ADD BX,BX                        ;BX=BX*2
   ADD SI,BX                        ; set CX=BX
   @PRINT_ARRAY_REVERSE:           ; loop label
     XOR AH, AH                   ; clear AH
     MOV AX, [SI]                 ; set AL=[SI]
     CALL OUTDEC                  ; call the procedure OUTDEC
     MOV AH, 2                    ; set output function
     MOV DL, 20H                  ; set DL=20H
     INT 21H                      ; print a character
     DEC SI                       ; set SI=SI-2
    DEC SI  
   LOOP @PRINT_ARRAY_REVERSE       ; jump to label @PRINT_ARRAY while CX!=0
   POP DX                         ; pop a value from STACK into DX
   POP CX                         ; pop a value from STACK into CX
   POP AX                         ; pop a value from STACK into AX
   RET                            ; return control to the calling procedure   
  
 PRINT_ARRAY_REVERSE ENDP

 END MAIN
