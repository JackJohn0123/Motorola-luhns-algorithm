; Validate_CC.asm
; Date:                 August 12 2022
;
; Purpose:              determine if the sum of a credit card number makes it a valid credit card
;
; Preconditions:        accumulator a contains even sum
;                       accumulator b contains odd sum
;
; Postcondition:        accumulator a contains the indicator.
;
;



Validate
                aba                ; add accumulator a and b
                
                tfr        a,b     ; transfer register to register (B = A)
                clra            ; clear accumlater A
        
                ldx     #10        ; Load 10 to register X
        
                idiv            ; divided B by 10
        
                cpd        #0      ; compare the reminder to 0
                beq        true    ; branch to equal if true
                ldaa        #0             ; load accumlator A with 0 if false
        
return
                rts                ; Valid or Invalid Indicator returned

                end
        
true                ldaa        #1            ; load accumlater A to 1 if true
                bra            return  ; branch out