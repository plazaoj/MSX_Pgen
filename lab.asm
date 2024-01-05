	.zilog
	.bios
	.basic
	.start 0xC000
	org 0xC000
	PARAM equ 0xF7F8	; Direccion donde el BASIC coloca el parametro que se pasa
	VDP_ADDR equ 0x99 	; Para seleccionar direccion en el VDP
	VDP_DATA equ 0x98 	; Para indicar dato al VDP
	
START:	ld A,(PARAM)		; Recupera parametro (valor 0-15)
	ld (ZVAL),A		; Guardalo en memoria	
	DI			; Deshabilita interrupciones
	
	;;  Pintar al norte
	xor A 			
	ld HL,ZVAL		; Recupera ZVAL
	bit 0,(HL)		; bit ose[N]
	JR Z,ANORTE		; si el bit está a 0, Z=1 (Hay muro)
	ld A,1  		; No hay muro, A=1
ANORTE:	call MNORTE

	;; Pintar al sur
	xor A			; Borra A
	ld HL,ZVAL		; Recupera ZVAL
	bit 2,(HL)		; Bit o[S]en
	JR Z,ASUR		; Z=1 si bit e de E está a 0 (hay muro)
	ld A,1 			; No hay muro
ASUR:	call MSUR

	;; Pintar al Este
	xor A			; borra A
	ld HL,ZVAL		; Recupera ZVAL
	bit 1,(HL)		; bit os[E]n
	JR Z,AESTE	
	ld A,1 			; No hay muro
AESTE:	call MESTE
	
	;; Pintar al oeste
	xor A			; Borre A
	ld HL,ZVAL		; Recupera ZVAL
	bit 3,(HL)		; bit [O]sen
	JR Z,AOESTE	
	ld A,1 			; No hay muro
AOESTE:	call MOESTE

;;;  *********************
;;; 	FINAL DE SUBRUTINA
	EI			; Habilita interrpuciones
	ret
;;; **********************
;;;
	
	;;
	;; PINTAR MURO NORTE
	;;
	
MNORTE: push AF
	ld HL,(NORTE)
	in A,(VDP_ADDR) 	;Sincroniza VDP
	ld A,L
	out (VDP_ADDR),A 	;Direccion VDP (low)
	ld A,H
	add A,64
	out (VDP_ADDR),A 	; Direccion VDP (high)
	ld B,32
	pop AF
BUCLEN:	out (VDP_DATA),A		
	djnz BUCLEN
	ret
	
	;; ****************
	;; Pintar muro SUR
	;; *************** 
MSUR:	push AF
	ld HL,(SUR)
	in A,(VDP_ADDR) 	;Sincroniza VDP
	ld A,L
	out (VDP_ADDR),A 	;Direccion VDP (low)
	ld A,H
	add A,64
	out (VDP_ADDR),A 	; Direccion VDP (high)
	ld B,32
	pop AF
BUCLES:	out (VDP_DATA),A		
	djnz BUCLES
	ret

	;; ****************
	;; Pintar muro ESTE
	;; ****************
MESTE:	push AF
	ld DE,32
	ld HL,(ESTE)
	ld B,22
	in A,(VDP_ADDR)		;Sincroniza VDP
BUCLEE:	ld A,L
	out (VDP_ADDR),A 	;Direccion VDP (low)
	ld A,H
	add A,64
	out (VDP_ADDR),A 	; Direccion VDP (high)
	pop AF
	out (VDP_DATA),A
	push AF
	add HL,DE
	djnz BUCLEE
	pop AF
	ret

	;; ******************
	;; Pintar muro OESTE
	;; *****************
MOESTE:	push AF
	ld DE,32
	ld HL,(OESTE)
	ld B,22
	in A,(VDP_ADDR) 		;Sincroniza VDP
BUCLEO:	ld A,L
	out (VDP_ADDR),A 		;Direccion VDP (low)
	ld A,H
	add A,64
	out (VDP_ADDR),A 		; Direccion VDP (high)
	pop AF
	out (VDP_DATA),A
	push AF
	add HL,DE
	djnz BUCLEO
	pop AF
	ret
	
ZVAL:	defb 0	
	;;  Direcciones VRAM
NORTE:	defw 0x1800		; hasta 0x181F, 32 columnas
OESTE:	defw 0x1820		; cada 32 bytes hasta 0x1AC0, 21 lineas
ESTE:	defw 0x183F		; cada 32 bytes hasta 0x1ABF, 21 lineas
SUR:	defw 0x1AE0		; hasta 0x1AFF, 32 columnas
