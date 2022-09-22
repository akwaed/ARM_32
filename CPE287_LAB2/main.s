
GPIO_PORTF_DATA_R  EQU 0x400253FC

	AREA    |.text|, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT  Start
	EXPORT 	Example_Function
	EXPORT 	Part3_Function
	EXPORT	Part4_Function
	IMPORT	delay
	IMPORT	leds_off
	IMPORT  PortF_Init
	IMPORT	Example
	IMPORT	Part3
	IMPORT  Part4
		
Start
	BL PortF_Init 	; Initialize the LEDs and Pushbuttons
	BL debug		; Useful for parts 2 and 3
loop
	LDR R1, =GPIO_PORTF_DATA_R
	LDR R0, [R1]
	AND R0, #0x11	;Get just the pushbutton values
	CMP R0, #0x11	;No buttons pressed?
	BNE checkSW1
	BL Example
	B loop
checkSW1
	CMP R0, #0x01 	;SW1 pressed?
	BNE checkSW2
	BL Part3
	B blink
checkSW2
	CMP R0, #0x10 	;SW2 pressed?
	BL Part4
	B blink

	
	;Create blinking effect
blink
	BL delay
	BL leds_off
	BL delay

	B loop



debug
	;Place parts 1 and 2 here
	MOV R0, # 0x00000006          ;x
	MOV R1, # 0xFFFFFFFB          ;y
	MOV R2, # 0x7FFFFFFF          ;z
	ADDS R3, R0, R1
	SUBS R3, R0, R0
	ADDS R3, R0, R2
	SUBS R3, R1, R2
	ADDS R3, R1, R2
	
	; PART 2
	MOV R7, #0x20000000
	LDR R6,[R7]
	LDRH R6,[R7]
	LDRB R6,[R7]
	LDRSH R6,[R7]
	LDRSB R6,[R7]
	
	MOV R7, #0x20000000
	ADD R7, #2
	
	LDR R6,[R7]
	LDRH R6,[R7]
	LDRB R6,[R7]
	LDRSH R6,[R7]
	LDRSB R6,[R7]

	BX LR ;Returns to main function



; Returns Z = A+B
; A and B are in R0 and R1, respectively
; Z should be placed in R0
Example_Function
	ADD R0, R0, R1 ;Comment out this instruction to see the Example fail
	BX LR


; Should return Z = (A >> 3)|(B & 55)
; Assume A and B are in R0 and R1, respectively
; The value of Z should be placed in R0 at the end
Part3_Function

	LSR R0,R0, #3
	AND R1,R1, #55
	ORR R0,R0, R1
	

	BX LR
	
	
; Should return x^n
; Follows AAPCS: Assume x is in R0, n is in R1
; The result should be placed in R0 at the end

Part4_Function
	; Your Part 4 Code Here
	CMP R1, #0
	MOV R5, R0
	BEQ expZeroP4
	
loopP4
	MUL R5, R5, R0 ; z=x*x
	SUB R1, R1, #1 ; n=n-1
	CMP R1,#1 ; restart if n !=1
	BEQ  doneP4;
	B loopP4

expZeroP4
	MOV R5, #1
    ;BX LR
	
doneP4
	MOV R0, R5
	BX LR
	
	ALIGN        ; make sure the end of this section is aligned
	END          ; end of file
