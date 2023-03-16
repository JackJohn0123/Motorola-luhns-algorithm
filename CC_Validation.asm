; CC_Validation.asm
;
#include C:\68HCS12\registers.inc
l;
; Date:                August 12 2022



; Address Constants - Do NOT change
STORAGE1        equ     $1000                   ; Storage starts here for original cards
FINALRESULTS    equ     $1030                   ; Final number of valid and invalid cards
PROGRAMSTART    equ     $2000                   ; Executable code starts here

; Hardware Configuration - Complete the Constant values
DIGIT3_PP0      equ    %1110                        ; HEX Display MSB (left most digit)
DIGIT0_PP3      equ    %0111                    ; Display LSB (right most digit)


; Program Constants - Do not change these values
NUMBERSOFCARDS  equ     6                       ; Six Cards to process
NUMDIGITS       equ     4                       ; Each Card has 4 digits

; You may add other Constant here if needed



; DO NOT CHANGE THE DELAY_VALUE; OTHERWISE THE VALUES WILL INCORRECTLY BE DISPLAYED
; IN THE SIMULATOR
DELAY_VALUE     equ     64                ; HEX Display Multiplexing Delay

                org        STORAGE1        ; Note: a Label cannot be placed
Cards                                        ; on same line as org statement
#include Sec_302_CC_Numbers.txt                ; substitute the appropriate file name here.
EndCards


; Do not change this code.
; Place your results here as you loop through your solution
                org         FINALRESULTS
InvalidResult   ds      1                ; Count of Invalid CARDs processed
ValidResult     ds      1                ; Count of Valid CARDs processed
; end of do not change

                org        ProgramStart
                lds        #ProgramStart        ; Stack used to protect values
; --- Your code starts here

                clr        ValidResult
                clr        InvalidResult

                ldy        #Cards                ; load Index register Y with the Cards
begin
                cpy        #EndCards        ; compare Y to Memory
                bge        Finished        ; If we are at the end of card it branch and ends the program
                ldaa        #0                ; Load accumulator A
                ldab        #4                ; Load accumulator B
                ldx        #0                ; Load index register X

                pshy                        ; push y into the stack
                pshy                        ; push y into the stack
                jsr        Add_Odd                ; jump to subroutine Add_Odd
                puly                        ; pull y from stack
                psha                        ; push a into the stack

                ldaa        #0                ; load accumulator A
                ldab        #4                ; load accumulator B

                jsr        Add_Even        ; jump to subroutine Add_Even

                pulb                        ; pull b from the stack (the result)

                jsr        Validate        ; jump to validate credit card
                puly                        ; pull y from the stack
                iny                        ; incremnt index register Y
                iny                        ; incremnt index register Y
                iny                        ; incremnt index register Y
                iny                        ; incremnt index register Y
                cmpa        #1                ; compare to accumulator A
                beq        storeValid        ; branch to store Valid if equal
                bra        storeInvalid        ; branch away and store into invalid

storeValid
                ldaa        ValidResult        ; load valid result
                inca                        ; incrament by one
                staa        ValidResult        ; store valid results
                bra        begin                ; branch to the begining of loop

storeInvalid
                ldx        #InvalidResult        ; load register x
                ldaa        InvalidResult        ; load invalid result
                inca                        ; increment by one
                staa        InvalidResult        ; store invalid results
                bra        begin                ; branch to begin
finish                                        ; finish
                swi                        ; Software interrupted
                end                        ; end program

; Do not change and code below here
Finished        jsr     Config_HEX_Displays
Display         ldaa    ValidResult
                ldab    #DIGIT3_PP0        ; Select MSB
                jsr     Hex_Display        ; Display the value
                ldaa    #DELAY_VALUE
                jsr     Delay_ms        ; Delay for DELAY_VALUE milliseconds
                ldaa    InValidResult
                ldab    #DIGIT0_PP3        ; Select LSB
                jsr     Hex_Display        ; Display the value
                ldaa    #DELAY_VALUE
                jsr     Delay_ms        ; Delay for DELAY_VALUE milliseconds
                bra     Display                ; Endless loop


; Filenames without a "C:\68HCS12\Lib\" path MUST be placed in the SOURCE FOLDER
#include Add_Odd.asm                        ; you write this one
#include Add_Even.asm                        ; you write this one
#include Validate_CC.asm                ; you write this one
#include Config_HEX_Displays.asm        ; provided to you - no changes permitted
#include Hex_Display.asm                ; provided to you - no changes permitted
#include C:\68HCS12\Lib\Delay_ms.asm       ; Library File    - no changes permitted

                end

