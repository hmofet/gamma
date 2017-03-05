// color swirl! connect an RGB LED to the PWM pins as indicated
// in the #defines
// public domain, enjoy!
 
#define REDPIN 6
#define GREENPIN 5
#define BLUEPIN 3
 
void setup() {
  pinMode(REDPIN, OUTPUT);
  pinMode(GREENPIN, OUTPUT);
  pinMode(BLUEPIN, OUTPUT);
  Serial.begin(9600);
}
 
int f = 1;
int ledState = LOW;             // ledState used to set the LED
long previousMillis = 0;        // will store last time LED was updated
long D = 1000/(2*f);
String inputString = "";

void loop() {
  unsigned long currentMillis = millis();
 
  if(currentMillis - previousMillis > D) {

    previousMillis = currentMillis;   

    // if the LED is off turn it on and vice-versa:
    if (ledState == LOW) {
      ledState = HIGH;
      analogWrite(REDPIN, 255);
      analogWrite(BLUEPIN, 0);
      analogWrite(GREENPIN, 0);
    }
    else {
      ledState = LOW;
      analogWrite(REDPIN, 0);
      analogWrite(BLUEPIN, 0);
      analogWrite(GREENPIN, 0);
    }
  }
}

void serialEvent() {
  while (Serial.available()) {
    // get the new byte:
    char inChar = (char)Serial.read(); 
    // add it to the inputString:
    inputString += inChar;
    // if the incoming character is a newline, set a flag
    // so the main loop can do something about it:
    if (inChar == '\n') {
      f = inputString.toInt();
      Serial.write('Changing frequency to: ');
      Serial.write(f);
      Serial.write('\n');
      D = 1000/(2*f);  
      inputString = "";
    } 
  }
}
