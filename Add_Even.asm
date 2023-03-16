; Add_Even.asm
; Date:                 August 12 2022
;
; Purpose:              get the sum of even numbers in a credit card
;
; Preconditions:        register y is loaded with pointer to credit card
;                       accumulator b is loaded with the # of digits in the card
;
; Postcondition:        register b contains the sum of the even numbers.
;


Add_Even
                iny                        ; Increment index register Y
                decb                        ; decrement memory location for B
                pshx                        ; push x into the stack
LoopAddEven     ldaa        2,y+                ; starts of the lop store the 2 digit into y and increment y
                daa                        ; adjust the sum into BCD
                decb                        ; decrement memory location for b
                decb                        ; decrement memory location for b
                exg        a,b              ; exchange B=A
                abx                        ; Translates to LEAX B,Y
                exg        a,b                ; Exchange B=A
                cmpb        #0                ; compare to B if equals to 0
        
                bgt        LoopAddEven          ; branch to Loop add even if its greater

                tfr        x,a                  ; transfer the register a to x
                pulx                        ; pull x from the stack
        
                rts                     ; Sum of Even Digits returned

                end