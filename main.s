	
	AREA my_consts, DATA


;Constantes

;Colores Semaforo

RED EQU 0 
YEL EQU 1
GRE EQU 2
	
;Tiempos	
SECS_15 EQU 15
SECS_10 EQU 10
SECS_3 EQU 3

	
	
	AREA my_code, CODE
		ENTRY 
		EXPORT __main
			
__main
	
	;Set inicial de todos los semáforos
	LDR r0, =GRE	; Semaforo vehiculos Norte a Sur
	LDR r1, =RED	; Semaforo peatonal Norte a Sur
	LDR r2, =GRE	; Semaforo vehiculos Sur a Norte
	LDR r3, =RED	; Semaforo peatonal Sur a Norte
	
	LDR r4, =RED 	; Semaforo vehiculos Este a Oeste
	LDR r5, =GRE   	; Semaforo peatonal Este a Oeste
	LDR r6, =RED 	; Semaforo vehiculos Oeste a Este
	LDR r7, =GRE   	; Semaforo peatonal Oeste a Este
	
	LDR r8, =SECS_15 ; Variable de Delay
	LDR r9, = 0 ; Timer
	
	LDR r11, = 0 ; sensor Norte a Sur
	LDR r12, = 0 ; sensor Este a Oeste
	
	
	B start
	

start

	MOV r8, #SECS_15 
	BL delay1 ; Delay 15s
	
	
	
sensor_Norte_Sur
	MOV r8, #SECS_3 		; delay 3s
	
	CMP r11,#0 				; comparar sensores peatonales Norte a Sur con 0
	
	BEQ delay2
	
	BL cambio_Sem_Norte_Sur_YEL 	; cambio a amarillo
	
	
cambio_Sem_Norte_Sur_YEL 	; cambio a amarillo de semaforos vehicules N-S y S-N

	MOV r0, #YEL 
	MOV r2, #YEL
	
	MOV r8, #SECS_3 ; delay 3s
	
	BL delay3 		; delay 3s

cambio_semaforo_Norte_Sur
	
	;Semaforos N-S y S-N
	
	MOV r0, #RED 	; Norte a Sur vehicular
	MOV r1, #GRE 	; Norte a Sur peatonal
	MOV r2, #RED 	; Sur a Norte vehicular
	MOV r3, #GRE 	; Sur a Norte peatonal

	;Semaforos E-O y O-E

	MOV r4, #GRE 	; Este a Oeste vehicular
	MOV r5, #RED  	; Este a Oeste peatonal
	MOV r6, #GRE 	; Oeste a Este vehicular
	MOV r7, #RED 	; Oeste a Este peatonal
	
	MOV r8, #SECS_15
	BL delay4
	
	
sensor_Oeste_Este

	MOV r8, #SECS_3 ; delay 3s
	
	
	CMP r12,#0 ; comparar sensores peatonales Este a Oeste con 0
	
	BEQ delay5
	
	BL cambio_Sem_Este_Oeste_YEL ; cambio a amarillo


cambio_Sem_Este_Oeste_YEL

	MOV r4, #YEL; cambio a amarillo
	MOV r6, #YEL
	
	MOV r8, #SECS_3 ; delay 3s
	
	BL delay 		; delay 3s


cambio_semaforo_Oeste_Este
	
	;Semaforos N-S y S-N
	
	MOV r0, #GRE 	; Norte a Sur vehicular
	MOV r1, #RED 	; Norte a Sur peatonal
	MOV r2, #GRE 	; Sur a Norte vehicular
	MOV r3, #RED 	; Sur a Norte peatonal
	
	;Semaforos E-O y O-E
	
	MOV r4, #RED 	; Este a Oeste vehicular
	MOV r5, #GRE  	; Este a Oeste peatonal
	MOV r6, #RED 	; Oeste a Este vehicular
	MOV r7, #GRE  	; Oeste a Este peatonal

	BL start




delay6 
	ADD r9,r9,#1; timer += 1
	
	SUBS r10, r8, r9 ; if timer != Time
	
	BNE delay6 ; Repetir delay hasta que timer llegue a r8
	
	MOV r9, #0
	BL cambio_semaforo_Oeste_Este



delay5 
	ADD r9,r9,#1; timer += 1
	
	SUBS r10, r8, r9 ; if timer != Time
	
	BNE delay5 ; Repetir delay hasta que timer llegue a r8
	
	MOV r9, #0
	BL cambio_Sem_Este_Oeste_YEL




delay4 
	ADD r9,r9,#1; timer += 1
	
	SUBS r10, r8, r9 ; if timer != Time
	
	BNE delay4 ; Repetir delay hasta que timer llegue a r8
	
	MOV r9, #0
	BL sensor_Oeste_Este


	
delay3	
	ADD r9,r9,#1; timer += 1
	
	SUBS r10, r8, r9 ; if timer != Time
	
	BNE delay3 ; Repetir delay hasta que timer llegue a r8
	
	MOV r9, #0
	BL cambio_semaforo_Norte_Sur
	


delay2
	ADD r9,r9,#1; timer += 1
	
	SUBS r10, r8, r9 ; if timer != Time
	
	BNE delay2 ; Repetir delay hasta que timer llegue a r8
	
	MOV r9, #0
	BL cambio_Sem_Norte_Sur_YEL


delay1

	ADD r9,r9,#1; timer += 1
	
	SUBS r10, r8, r9 ; if timer != Time
	
	BNE delay1 ; Repetir delay hasta que timer llegue a r8
	
	MOV r9, #0
	BL sensor_Norte_Sur
	

stop    B stop

	END
	
	