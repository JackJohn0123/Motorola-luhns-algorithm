; Add_Odd.asm
; Date:                 August 12 2022
;
; Purpose:              after multiplying each odd number by 2, get the sum of even numbers in a credit card
;
; Preconditions:        register y is loaded with pointer to credit card
;                       accumulator b is loaded with the # of digits in the card
;
; Postcondition:        register b contains the sum of the odds numbers.





Add_Odd ; Add_Odd.asm
            pshx                   ;save x
LoopAddOdd  ldaa    0,y       ; Get the value of the accumulator
            adda    2,y+               ; Add the value of the accumulator to the value of the accumulator
            daa                    ; Add the carry bit to the value of the accumulator
            cmpa    #$10          ; if the value is greater than $10 then subtract $10 from the value
            pshb                      ; save the value of the accumulator
            bge     AddAccross       ; if the value is greater than $10 then go to AddAccross
Cont        pulb                   ; get the value of the accumulator
            decb                    ; decrement the value of the accumulator
            decb                   ; decrement the value of the accumulator
            exg     a,b           ; exchange the value of the accumulator with the value of the accumulator
            abx                   ; add the value of the accumulator to the value of the accumulator
            exg     a,b          ; exchange the value of the accumulator with the value of the accumulator
            cmpb    #0           ; if the value of the accumulator is 0 then go to AddAccross
            bgt     LoopAddOdd    ; if the value of the accumulator is greater than 0 then go to LoopAddOdd

            tfr     x,a        ; exchange the value of the accumulator with the value of the accumulator
            pulx                ; get the value of the accumulator

            rts               ; return to the caller

AddAccross
            psha          ; save the value of the accumulator
            lsla         ; left shift the value of the accumulator
            lsla        ; left shift the value of the accumulator
            lsla       ; left shift the value of the accumulator
            lsla     ; left shift the value of the accumulator
            lsra       ; right shift the value of the accumulator
            lsra     ; right shift the value of the accumulator
            lsra  ; right shift the value of the accumulator
            lsra    ; right shift the value of the accumulator
            tfr     a,b       ; exchange the value of the accumulator with the value of the accumulator
            pula         ; get the value of the accumulator
            lsra         ; right shift the value of the accumulator
            lsra       ; right shift the value of the accumulator
            lsra    ; right shift the value of the accumulator
            lsra ; right shift the value of the accumulator
            aba         ; add the value of the accumulator to the value of the accumulator
            bra     Cont    ; go to Cont

            end  ;end