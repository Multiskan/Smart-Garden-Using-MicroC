char seconds, minutes, hours, day, month, year;    // Global date/time variables
// Software I2C connections
sbit Soft_I2C_Scl           at RC3_bit;
sbit Soft_I2C_Sda           at RC4_bit;
sbit Soft_I2C_Scl_Direction at TRISC3_bit;
sbit Soft_I2C_Sda_Direction at TRISC4_bit;
// End Software I2C connections
//--------------------- Reads time and date information from RTC (DS1307)
void Read_Time() {
  Soft_I2C_Start();               // Issue start signal
  Soft_I2C_Write(0xA0);           // Address PCF8583, see DS1307datasheet
  Soft_I2C_Write(2);              // Start from address 2
  Soft_I2C_Start();               // Issue repeated start signal
  Soft_I2C_Write(0xA1);           // Address DS1307  for reading R/W=1

  seconds = Soft_I2C_Read(1);     // Read seconds byte
  minutes = Soft_I2C_Read(1);     // Read minutes byte
  hours = Soft_I2C_Read(1);       // Read hours byte
  day = Soft_I2C_Read(1);         // Read year/day byte
  month = Soft_I2C_Read(0);       // Read weekday/month byte
  Soft_I2C_Stop();                // Issue stop signal
}
//-------------------- Formats date and time
void Transform_Time() {
  seconds  =  ((seconds & 0xF0) >> 4)*10 + (seconds & 0x0F);  // Transform seconds
  minutes  =  ((minutes & 0xF0) >> 4)*10 + (minutes & 0x0F);  // Transform months
  hours    =  ((hours & 0xF0)  >> 4)*10  + (hours & 0x0F);    // Transform hours
  year     =   (day & 0xC0) >> 6;                             // Transform year
  day      =  ((day & 0x30) >> 4)*10    + (day & 0x0F);       // Transform day
  month    =  ((month & 0x10)  >> 4)*10 + (month & 0x0F);     // Transform month
}
//------------------ Performs project-wide init
void Init_Main() {
    char ANSEL,ANSELH ;
  TRISB = 0;
  PORTB = 0xFF;
  TRISB = 0xff;
  ANSEL  = 0;               // Configure AN pins as digital I/O
  ANSELH = 0;
  Soft_I2C_Init();           // Initialize Soft I2C communication

}
//----------------- Main procedure
void main() {

 Init_Main();               // Perform initialization

  while (1) {                // Endless loop
    Read_Time();             // Read time from RTC(DS1307)
    Transform_Time();        // Format date and time

  }
}