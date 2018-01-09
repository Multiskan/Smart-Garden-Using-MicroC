
_Read_Time:

;MyProject.c,9 :: 		void Read_Time() {
;MyProject.c,10 :: 		Soft_I2C_Start();               // Issue start signal
	CALL       _Soft_I2C_Start+0
;MyProject.c,11 :: 		Soft_I2C_Write(0xA0);           // Address PCF8583, see DS1307datasheet
	MOVLW      160
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,12 :: 		Soft_I2C_Write(2);              // Start from address 2
	MOVLW      2
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,13 :: 		Soft_I2C_Start();               // Issue repeated start signal
	CALL       _Soft_I2C_Start+0
;MyProject.c,14 :: 		Soft_I2C_Write(0xA1);           // Address DS1307  for reading R/W=1
	MOVLW      161
	MOVWF      FARG_Soft_I2C_Write_data_+0
	CALL       _Soft_I2C_Write+0
;MyProject.c,16 :: 		seconds = Soft_I2C_Read(1);     // Read seconds byte
	MOVLW      1
	MOVWF      FARG_Soft_I2C_Read_ack+0
	MOVLW      0
	MOVWF      FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      _seconds+0
;MyProject.c,17 :: 		minutes = Soft_I2C_Read(1);     // Read minutes byte
	MOVLW      1
	MOVWF      FARG_Soft_I2C_Read_ack+0
	MOVLW      0
	MOVWF      FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      _minutes+0
;MyProject.c,18 :: 		hours = Soft_I2C_Read(1);       // Read hours byte
	MOVLW      1
	MOVWF      FARG_Soft_I2C_Read_ack+0
	MOVLW      0
	MOVWF      FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      _hours+0
;MyProject.c,19 :: 		day = Soft_I2C_Read(1);         // Read year/day byte
	MOVLW      1
	MOVWF      FARG_Soft_I2C_Read_ack+0
	MOVLW      0
	MOVWF      FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      _day+0
;MyProject.c,20 :: 		month = Soft_I2C_Read(0);       // Read weekday/month byte
	CLRF       FARG_Soft_I2C_Read_ack+0
	CLRF       FARG_Soft_I2C_Read_ack+1
	CALL       _Soft_I2C_Read+0
	MOVF       R0+0, 0
	MOVWF      _month+0
;MyProject.c,21 :: 		Soft_I2C_Stop();                // Issue stop signal
	CALL       _Soft_I2C_Stop+0
;MyProject.c,22 :: 		}
L_end_Read_Time:
	RETURN
; end of _Read_Time

_Transform_Time:

;MyProject.c,24 :: 		void Transform_Time() {
;MyProject.c,25 :: 		seconds  =  ((seconds & 0xF0) >> 4)*10 + (seconds & 0x0F);  // Transform seconds
	MOVLW      240
	ANDWF      _seconds+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      15
	ANDWF      _seconds+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	ADDWF      R0+0, 0
	MOVWF      _seconds+0
;MyProject.c,26 :: 		minutes  =  ((minutes & 0xF0) >> 4)*10 + (minutes & 0x0F);  // Transform months
	MOVLW      240
	ANDWF      _minutes+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      15
	ANDWF      _minutes+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	ADDWF      R0+0, 0
	MOVWF      _minutes+0
;MyProject.c,27 :: 		hours    =  ((hours & 0xF0)  >> 4)*10  + (hours & 0x0F);    // Transform hours
	MOVLW      240
	ANDWF      _hours+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      15
	ANDWF      _hours+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	ADDWF      R0+0, 0
	MOVWF      _hours+0
;MyProject.c,28 :: 		year     =   (day & 0xC0) >> 6;                             // Transform year
	MOVLW      192
	ANDWF      _day+0, 0
	MOVWF      _year+0
	MOVLW      6
	MOVWF      R0+0
	MOVF       R0+0, 0
L__Transform_Time4:
	BTFSC      STATUS+0, 2
	GOTO       L__Transform_Time5
	RRF        _year+0, 1
	BCF        _year+0, 7
	ADDLW      255
	GOTO       L__Transform_Time4
L__Transform_Time5:
;MyProject.c,29 :: 		day      =  ((day & 0x30) >> 4)*10    + (day & 0x0F);       // Transform day
	MOVLW      48
	ANDWF      _day+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      15
	ANDWF      _day+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	ADDWF      R0+0, 0
	MOVWF      _day+0
;MyProject.c,30 :: 		month    =  ((month & 0x10)  >> 4)*10 + (month & 0x0F);     // Transform month
	MOVLW      16
	ANDWF      _month+0, 0
	MOVWF      R2+0
	MOVF       R2+0, 0
	MOVWF      R0+0
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	RRF        R0+0, 1
	BCF        R0+0, 7
	MOVLW      10
	MOVWF      R4+0
	CALL       _Mul_8x8_U+0
	MOVLW      15
	ANDWF      _month+0, 0
	MOVWF      R1+0
	MOVF       R1+0, 0
	ADDWF      R0+0, 0
	MOVWF      _month+0
;MyProject.c,31 :: 		}
L_end_Transform_Time:
	RETURN
; end of _Transform_Time

_Init_Main:

;MyProject.c,33 :: 		void Init_Main() {
;MyProject.c,35 :: 		TRISB = 0;
	CLRF       TRISB+0
;MyProject.c,36 :: 		PORTB = 0xFF;
	MOVLW      255
	MOVWF      PORTB+0
;MyProject.c,37 :: 		TRISB = 0xff;
	MOVLW      255
	MOVWF      TRISB+0
;MyProject.c,40 :: 		Soft_I2C_Init();           // Initialize Soft I2C communication
	CALL       _Soft_I2C_Init+0
;MyProject.c,42 :: 		}
L_end_Init_Main:
	RETURN
; end of _Init_Main

_main:

;MyProject.c,44 :: 		void main() {
;MyProject.c,46 :: 		Init_Main();               // Perform initialization
	CALL       _Init_Main+0
;MyProject.c,48 :: 		while (1) {                // Endless loop
L_main0:
;MyProject.c,49 :: 		Read_Time();             // Read time from RTC(DS1307)
	CALL       _Read_Time+0
;MyProject.c,50 :: 		Transform_Time();        // Format date and time
	CALL       _Transform_Time+0
;MyProject.c,52 :: 		}
	GOTO       L_main0
;MyProject.c,53 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
