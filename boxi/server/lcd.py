from RPLCD.i2c import CharLCD

lcd = CharLCD('PCF8574', 0x3f)

def LCD_disp(str_in):
	lcd.clear()
	lcd.write_string(str_in)

if __name__ == "__main__":
	LCD_disp('asjklfkjlasdkjlfjkldfsj;aaf')


