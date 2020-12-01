//THEREMIN EMPIRE
//<3
//Manual:
//KEYBOARD CONTROL
//Press keys to draw path with the mouse.
//Q and W is the first path.
//A and S is the second path
//Y and X is the third path
//each path can go faster or slower.
//first one: E = slower, R = faster
//second one: G = slower, F = faster
//third one: C = slower, V = faster
//G = freeze everything
//B = unfreeze
//THEREMIN CONTROL
//The two big sensors: Master Pitch and Master speed
//the medium one: Amplitude of the oscilators
//the small one: slightly moves the dots around, nice effect.

//LIBRARIES
import processing.sound.*;
import processing.serial.*;
import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.spi.*;
import cc.arduino.*;
//Arduino
Arduino arduino;
//Minim Objects
Minim minim;
AudioOutput out;
LiveInput in;
//three oscilators, one for each path
Oscil wave1;
Oscil wave2;
Oscil wave3;
//lots of variables for each path and the big triangle of frequencies
int ax1;
int ay1;
int oldax1;
int olday1;
int ax2;
int ay2;
int masterAx;
int masterAy;
float computeAx;
float computeAy;
//b
int bx1;
int by1;
int oldbx1;
int oldby1;
int bx2;
int by2;
int masterBx;
int masterBy;
float computeBx;
float computeBy;
//c
int cx1;
int cy1;
int oldcx1;
int oldcy1;
int cx2;
int cy2;
int masterCx;
int masterCy;
float computeCx;
float computeCy;
//not so important
int ray = 3;
//initialise speed
float stepsA = 50;
int currentStepA = 0;
boolean increaseA = true;
//b
float stepsB = 50;
int currentStepB = 0;
boolean increaseB = true;
//c
float stepsC = 50;
int currentStepC = 0;
boolean increaseC = true;

//Initialise speed as well
float originStepA = 50;
float originStepB = 50;
float originStepC = 50;

//initaialise variable to read from the arduino
float freqA;
float freqB;
float freqC;
float freqD;




float generalAmp = 0.6;
float masterFreq = 1;
float factor = 2;
float factorSpeed = 1;



int A0 = 0;
int A1 = 1;
int A2 = 2;
int A3 = 3;
int readA0;
int readA1;
int readA2;
int readA3;

float increaseFactor = 0;

boolean freeze = false;






void setup() {
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(A0, Arduino.INPUT);
  arduino.pinMode(A1, Arduino.INPUT);
  arduino.pinMode(A2, Arduino.INPUT);
  arduino.pinMode(A3, Arduino.INPUT);
  fullScreen();
  ax1 = width/2;
  ax2 = width/2;
  ay1 = height/2;
  ay2 = height/2;
  bx1 = width/2;
  bx2 = width/2;
  by1 = height/2;
  by2 = height/2;
  cx1 = width/2;
  cx2 = width/2;
  cy1 = height/2;
  cy2 = height/2;
  
  minim = new Minim(this);
  out = minim.getLineOut();
  AudioStream inputStream = minim.getInputStream( Minim.MONO, 
                                                  out.bufferSize(), 
                                                  out.sampleRate(), 
                                                  out.getFormat().getSampleSizeInBits()
                                                 );
  ////
  in = new LiveInput( inputStream );
  Vocoder vocode = new Vocoder( 1024, 8 );
  in.patch( vocode.modulator );
  
  wave1 = new Oscil( 50, generalAmp, Waves.SAW ); 
  wave2 = new Oscil( 50, generalAmp, Waves.SAW ); 
  wave3 = new Oscil( 50, generalAmp, Waves.SAW ); 
  Summer synth = new Summer();
  wave1.patch( synth );
  wave2.patch( synth );
  wave3.patch( synth );
  
  synth.patch( vocode ).patch( out );
 
}

void draw() {
  //all the keyboard control
  if (keyPressed) {
     if (key == 'q' || key == 'Q'){
       currentStepA = 0;
       increaseA = true;
       ax1 = mouseX;
       ay1 = mouseY;
       oldax1 = mouseX;
       olday1 = mouseY;
     }
     if (key == 'w' || key == 'W'){
       currentStepA = 0;
       increaseA = true;
       ax2 = mouseX;
       ay2 = mouseY;
     }
     if (key == 'a' || key == 'A'){
       currentStepB = 0;
       increaseB = true;
       oldbx1 = mouseX;
       oldby1 = mouseY;
       bx1 = mouseX;
       by1 = mouseY;
     }
     if (key == 's' || key == 'S'){
       currentStepB = 0;
       increaseB = true;
       bx2 = mouseX;
       by2 = mouseY;
     }
     if (key == 'y' || key == 'Y'){
       currentStepC = 0;
       increaseC = true;
       oldcx1 = mouseX;
       oldcy1 = mouseY;
       cx1 = mouseX;
       cy1 = mouseY;
     }
     if (key == 'x' || key == 'X'){
       currentStepC = 0;
       increaseC = true;
       cx2 = mouseX;
       cy2 = mouseY;
     }
     if (key == 'e' || key == 'E'){
       originStepA ++;
     }
     if (key == 'r' || key == 'R'){
       if(stepsA > 5){
         originStepA --;
       }
     }
     if (key == 'd' || key == 'D'){
       originStepB ++;
     }
     if (key == 'f' || key == 'F'){
       if(stepsB > 5){
         originStepB --;
       }
     }
     if (key == 'c' || key == 'C'){
       originStepC ++;
     }
     if (key == 'v' || key == 'V'){
       if(stepsC > 5){
         originStepC --;
       }
     }
     if (key == 'g' || key == 'G'){
       freeze = true;
     }
     if (key == 'b' || key == 'B'){
       freeze = false;
     }
  }
  
  //read analog data from the arduino.
  readA0=arduino.analogRead(A0)+1;
  readA1=arduino.analogRead(A1)+1;
  readA2=arduino.analogRead(A2)+1;
  readA3=arduino.analogRead(A3)+1;
  
  
  //TO MOVE THE DOTS AROUND
  increaseFactor = map(readA3,100,1000,200,1);
  ax1 = int(increaseFactor) + oldax1;
  ay1 = int(increaseFactor) + olday1;
  bx1 = int(increaseFactor) + oldbx1;
  by1 = int(increaseFactor) + oldby1;
  cx1 = oldcx1 - int(increaseFactor);
  cy1 = oldcy1 - int(increaseFactor);

  
  
  //TO CHANGE THE SPEED
  factorSpeed = map(readA0,100,1000,4,1);
  stepsA = originStepA*factorSpeed;
  stepsB = originStepB*factorSpeed;
  stepsC = originStepC*factorSpeed;
  
  
  


  background(0);
  drawWaves();
  drawA();
  drawB();
  drawC();
  if(freeze == false) {
    progressionA();
    progressionB();
    progressionC();
  }
  superDraw();
  fun();
  
}
