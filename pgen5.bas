10 REM ****SETUP*********
20 SCREEN 1,1:COLOR 15,5,1:KEYOFF
30 RESTORE700
40 WD=23:HG=23:DEFINT Z
50 PI=4*ATN(1)
60 FOR I=0 TO 7
70 READ V: VPOKE I,V:VPOKE 8+I,0
80 NEXT I
90 BLOAD"LAB.BIN":DEFUSR0=&HC000
100 GOSUB 630: REM  ** SPRITES **
110 SD=5
120 DEF FNRN(Q)=INT(16*RND(-Q*Q))
130 X=0:Y=0: SX=8*16:SY=8*12:REM * POSCION INICIAL *
140 AG=0:VL=0:D=0:SP=1
150 ON STRIG GOSUB 790
160 REM ** PINTAR HABITACION **
170 GOSUB 310: REM ** HABITACION **
180 GOSUB 400: REM ** PINTAR **
190 STRIG(0) ON
200 PUT SPRITE0,(SX,SY),1,SP+1:PUTSPRITE1,(SX,SY),10,SP
210 K=STICK(0)
220 IF K>0 AND (K MOD 2)>0 THEN D=K:SP=D
230 IF D=1 THEN GOSUB 530:GOTO 270
240 IF D=3 THEN GOSUB 430:GOTO 270
250 IF D=5 THEN GOSUB 580:GOTO 270
260 IF D=7 THEN GOSUB 480
270 IF X1=X AND Y1=Y THEN GOTO 200
280 X=X1:Y=Y1
290 GOTO 170
300 REM ** CREACION HABITACION **
310 S0=(Y+1)*WD+(X+1)
320 Z=FNRN(SD+S0)
325 TN=.2*RND(1)
330 IF Y<HG-1 THEN SU=(Z AND 4) ELSE SU=0
340 IF X<WD-1 THEN ES=(Z AND 2) ELSE ES=0
350 IF Y=0 THEN NO=0 ELSE NO=(FNRN(SD+(S0-WD)) AND 4)/4
360 IF X=0 THEN OE=0 ELSE OE=4*(FNRN(SD+(S0-1)) AND 2)
370 Z=NO+ESTE+SUR+OESTE
380 RETURN
390 REM ** PINTAR HABITACION **
400 L=USR(Z)
410 RETURN
420 REM ** DERECHA **
430 SX=SX+4
440 IF (Z AND 2) AND SX>232 THEN X1=X+1: SX=8:RETURN
450 IF (Z AND 2)<1 AND SX>232 THEN IF RND(1)<TN AND X<WD-1 THEN X1=X+1 :SX=8 ELSE SX=SX-4:D=7:SP=7:RETURN
460 RETURN
470 REM ** IZQUIERDA **
480 SX=SX-4
490 IF (Z AND 8) AND SX<8 THEN X1=X-1: SX=232:RETURN
500 IF (Z AND 8)<1 AND SX<8 THEN IF RND(1)<TN AND X>0 THEN X1=X-1: SX=232 ELSE SX=SX+4:D=3:SP=3:RETURN
510 RETURN
520 REM ** ARRIBA **
530 SY=SY-4
540 IF (Z AND 1) AND SY<8 THEN Y1=Y-1:SY=168:RETURN
550 IF (Z AND 1)<1 AND SY<8 THEN IF RND(1)<TN AND Y>0 THEN Y1=Y-1:SY=168 ELSE SY=SY+4:D=5:SP=5:RETURN
560 RETURN
570 REM ** ABAJO **
580 SY=SY+4
590 IF (Z AND 4) AND SY>168 THEN Y1=Y+1:SY=8:RETURN
600 IF (Z AND 4)<1 AND SY>168 THEN IF RND(1)<TN AND Y<HG-1 THEN Y1=Y+1:SY=8 ELSE SY=SY-4:D=1:SP=1:RETURN
610 RETURN
620 REM ** DEFINE SPRITES **
630 FOR I=1 TO 8:S$=""
640 FOR J=1 TO 8
650 READ V:S$=S$+CHR$(V)
660 NEXT J
670 SPRITE$(I)=S$
680 NEXT I
690 RETURN
700 DATA &H00,&HE7,&HE7,&H00,&H00,&HFC,&HFC,&H00
710 DATA &H10,&H10,&H10,&H10,&H38,&H38,&H38,&H38
720 DATA &H00,&H28,&H28,&H00,&H00,&H44,&H54,&H00
730 DATA &H00,&H00,&HF0,&HFF,&HF0,&H00,&H00,&H00
740 DATA &H00,&H60,&H06,&H40,&H06,&H60,&H00,&H00
750 DATA &H38,&H38,&H38,&H38,&H10,&H10,&H10,&H10
760 DATA &H00,&H54,&H44,&H00,&H00,&H28,&H28,&H00
770 DATA &H00,&H00,&H0F,&HFF,&H0F,&H00,&H00,&H00
780 DATA &H00,&H06,&H60,&H02,&H60,&H06,&H00,&H00
790 STRIG(0) OFF:SCREEN0:END
