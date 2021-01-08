BUBBLE_SORT PROC
    mov ds,bx
    mov dx, ds
    oloop:
        mov dx, ds
        lea si,ARRAY

        iloop:
            mov al, [si]                 ; Because compare can't have both memory
            cmp al, [si+1]
            jl common                      ; if al is less than [si+1] Skip the below two lines for swapping.
            xchg al, [si+1]
            mov [si], al                    ; Coz we can't use two memory locations in xchg directly.

            common:
                INC si
                loop iloop

        dec dx
        jnz oloop

                          
 BUBBLE_SORT ENDP