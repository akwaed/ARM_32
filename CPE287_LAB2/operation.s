

	AREA    |.text|, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT	Example
	EXPORT  Part3
	EXPORT	Part4

	IMPORT	Example_Function
	IMPORT	Part3_Function
	IMPORT	Part4_Function

	IMPORT  delay
	IMPORT	delay_dim
	IMPORT  blue_led_on
	IMPORT  blue_led_off
	IMPORT  red_led_on
	IMPORT  red_led_off
	IMPORT  green_led_on
	IMPORT  green_led_off
	IMPORT	leds_off
		

Example
	MOV R0, #2
	MOV R1, #3
	PUSH {LR}
	BL Example_Function
	CMP R0, #5
	BNE exfail
	BL blue_led_on
	B exend
exfail
	BL red_led_on
exend
	POP {LR}
	BX LR




Part3
	MOV R0, #0x04
	MOV R1, #0x11
	PUSH{LR}
	BL Part3_Function
	CMP R0, #0x11
	BNE fail3
	MOV R0, #0x05
	MOV R1, #0x47
	BL Part3_Function
	CMP R0, #0x07
	BL leds_off
	BL blue_led_on
	B end3
fail3
	BL leds_off
	BL red_led_on
end3
	POP	{LR}
	BX LR
	
	
Part4
	MOV R0, #0
	MOV R1, #2
	PUSH {LR}
	BL Part4_Function
	CMP R0, #0
	BNE fail4
	MOV R0, #2
	MOV R1, #4
	BL Part4_Function
	CMP R0, #16
	BNE fail4
	MOV R0, #5
	MOV R1, #4
	BL Part4_Function
	MOV R3, #624
	ADD R3, #1
	CMP R0, R3
	BNE fail4
	MOV R0, #8
	MOV R1, #9
	BL Part4_Function
	MOV R4, #134217728
	CMP R0, R4
	BNE fail4
	MOV R0, #9
	MOV R1, #0
	BL Part4_Function
	MOV R4, #1
	CMP R0, R4
	BNE fail4
	BL leds_off
	BL green_led_on
	B end4
fail4
	BL leds_off
	BL red_led_on
end4
	POP {LR}
	BX LR


	ALIGN
	END