#include <Servo.h>

String trama = "";
String aux = "";
int procesar = 0;
int vs1 = 1500;
int vs2 = 1500;
int vs3 = 1500;
int vs4 = 1500;
int vs5 = 1500;
int vs6 = 1500;

int pins1 = 8;
int pins2 = 9;
int pins3 = 10;
int pins4 = 11;
int pins5 = 12;
int pins6 = 13;

Servo servo1;
Servo servo2;
Servo servo3;
Servo servo4;
Servo servo5;
Servo servo6;

void setup() {
  servo1.attach(pins1);
  servo2.attach(pins2);
  servo3.attach(pins3);
  servo4.attach(pins4);
  servo5.attach(pins5);
  servo6.attach(pins6);

  Serial.begin(9600);
  //Serial.println("Control de Robot Serpiente");
}

void loop() {
  if (Serial.available() > 0) {       //recolecta los datos del puerto serial
    char dato=Serial.read();
    if(((dato >= '0')&&(dato <= '9')) || (dato == '<') || (dato == '>')){
        trama = String(trama + dato);
    }
    if (dato == '>'){                 //reconoce si es el fin de trama
      procesar = 1;
      //Serial.print("Trama Total: ");  // se envia la trama complet para visualizarla
      //Serial.println(trama);
    }

   
  }
  if (procesar == 1){
    aux = trama.substring(1,5);
    //Serial.print("SubTrama 1: ");     //se envia el valor del primer servo
    vs1 = aux.toInt();
    //Serial.println(vs1);
    aux = trama.substring(5,9);
    //Serial.print("SubTrama 2: ");     //se envia el valor del segundo servo
    vs2 = aux.toInt();
    //Serial.println(vs2);
    aux = trama.substring(9,13);
    //Serial.print("SubTrama 3: ");     //se envia el valor del tercer servo
    vs3 = aux.toInt();
    //Serial.println(vs3);
    aux = trama.substring(13,17);
    //Serial.print("SubTrama 4: ");     //se envia el valor del cuarto servo
    vs4 = aux.toInt();
    //Serial.println(vs4);

    aux = trama.substring(17,21);
    //Serial.print("SubTrama 5: ");     //se envia el valor del quinto servo
    vs5 = aux.toInt();
    //Serial.println(vs5);

     aux = trama.substring(21,25);
    //Serial.print("SubTrama 6: ");     //se envia el valor del sexto servo
    vs6 = aux.toInt();
    //Serial.println(vs6);
    
    procesar = 0;
    trama = "";
  }
  servo1.writeMicroseconds(vs1);
  delay(15);
  servo2.writeMicroseconds(vs2);
  delay(15);
  servo3.writeMicroseconds(vs3);
  delay(15);
  servo4.writeMicroseconds(vs4);
  delay(15);
  servo5.writeMicroseconds(vs5);
  delay(15);
  servo6.writeMicroseconds(vs6);
  delay(15);
}
