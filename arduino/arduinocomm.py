import serial
import urllib2
from time import sleep

ser = serial.Serial('/dev/ttyACM1', 9600)

while True:
    f = urllib2.urlopen('http://yyee.ca/gamma2hard/freq.php')
    freq = f.read()
    ser.write(freq+'\n')
    print freq
    sleep(1)
    