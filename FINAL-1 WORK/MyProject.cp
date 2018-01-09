#line 1 "C:/Users/HP/Desktop/FINAL-1 WORK/MyProject.c"
char seconds, minutes, hours, day, month, year;

sbit Soft_I2C_Scl at RC3_bit;
sbit Soft_I2C_Sda at RC4_bit;
sbit Soft_I2C_Scl_Direction at TRISC3_bit;
sbit Soft_I2C_Sda_Direction at TRISC4_bit;


void Read_Time() {
 Soft_I2C_Start();
 Soft_I2C_Write(0xA0);
 Soft_I2C_Write(2);
 Soft_I2C_Start();
 Soft_I2C_Write(0xA1);

 seconds = Soft_I2C_Read(1);
 minutes = Soft_I2C_Read(1);
 hours = Soft_I2C_Read(1);
 day = Soft_I2C_Read(1);
 month = Soft_I2C_Read(0);
 Soft_I2C_Stop();
}

void Transform_Time() {
 seconds = ((seconds & 0xF0) >> 4)*10 + (seconds & 0x0F);
 minutes = ((minutes & 0xF0) >> 4)*10 + (minutes & 0x0F);
 hours = ((hours & 0xF0) >> 4)*10 + (hours & 0x0F);
 year = (day & 0xC0) >> 6;
 day = ((day & 0x30) >> 4)*10 + (day & 0x0F);
 month = ((month & 0x10) >> 4)*10 + (month & 0x0F);
}

void Init_Main() {
 char ANSEL,ANSELH ;
 TRISB = 0;
 PORTB = 0xFF;
 TRISB = 0xff;
 ANSEL = 0;
 ANSELH = 0;
 Soft_I2C_Init();

}

void main() {

 Init_Main();

 while (1) {
 Read_Time();
 Transform_Time();

 }
}
