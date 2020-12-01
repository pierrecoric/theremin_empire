//THEREMIN EMPIRE
//THREE KINGS
//<3
//libraries
import processing.serial.*;
import cc.arduino.*;
import ddf.minim.*;
import ddf.minim.ugens.*;
import ddf.minim.spi.*;

//Variables:
//Arduino
Arduino arduino;
//Analog pins of the arduino 
int A0 = 0;
int A1 = 1;
int A2 = 2;
int A3 = 3;
//To store the values read by these pins
int readA0;
int readA1;
int readA2;
int readA3;
//Minim Object
Minim minim;
AudioOutput out;
//Two Oscillators (Pierre and Rhea)
Oscil wave1;
Oscil wave2;
//to map the value read by the pins and do something with that
float freq1;
float freq2;
float freq3;
float freq4;
//general amplitude of the instrument
float generalAmp = 0.4;
//an array with the frequencies of each semitones to draw the grid
float semiTones[] = {16.35,17.32,18.35,19.45,20.60,21.83,23.12,24.50,25.96,27.50,29.14, 
30.87,32.70,34.65,36.71,38.89,41.20,43.65,46.25,49.00,51.91,55.00,58.27,61.74,65.41,69.30,
73.42, 77.78,82.41,87.31,92.50,98.00,103.83,110.00,116.54,123.47,130.81,138.59,146.83,155.56,164.81,174.61,185.00,196.00,207.65,220.00,233.08,246.94,
261.63,277.18,293.66,311.13,329.63,349.23,369.99,392.00,415.30,440.00};

//SETUP
void setup() {
  size(500,500);
  //setting up the arduino
  arduino = new Arduino(this, Arduino.list()[0], 57600);
  arduino.pinMode(A0, Arduino.INPUT);
  arduino.pinMode(A1, Arduino.INPUT);
  arduino.pinMode(A2, Arduino.INPUT);
  arduino.pinMode(A3, Arduino.INPUT);
  //setting up minim
  minim = new Minim(this);
  out = minim.getLineOut();
  AudioStream inputStream = minim.getInputStream( Minim.MONO, 
                                                  out.bufferSize(), 
                                                  out.sampleRate(), 
                                                  out.getFormat().getSampleSizeInBits()
                                                 );
       
    //making a summer object to patch both oscillators out                                           
    Summer synth = new Summer();
    //starting the oscillators 
    //(SINE can be changes by SAW or SQUARE)
    wave1 = new Oscil( 50, generalAmp, Waves.SINE ); 
    wave2 = new Oscil( 50, generalAmp, Waves.SINE ); 
    //patching the oscillators on the summer
    wave1.patch( synth );
    wave2.patch( synth );
    //and patching the summer out
    synth.patch(out);
}


void draw() {  
  //draw the grid
  background(0);
  semitones();
  
  //read the light
  readA0=arduino.analogRead(A0)+1;
  readA1=arduino.analogRead(A1)+1;
  readA2=arduino.analogRead(A2)+1;
  readA3=arduino.analogRead(A3)+1;
  //map the values
  freq1 = map(readA0,100,1000,55,220);
  freq2 = map(readA1,100,1000,55,440);
  freq3 = map(readA2,200,1000,0,1);
  freq4 = map(readA3,300,1000,0.4,1.2);
  
  //multiply freq1 and freq2 by freq4 (master pitch)
  freq1 *= freq4;
  freq2 *= freq4;
  
  //set the amplitude (controlled by freq3)
  wave1.setAmplitude(freq3);
  wave2.setAmplitude(freq3);
  //set the frequencies of each oscillator
  wave1.setFrequency( freq1 );
  wave2.setFrequency( freq2 );
  
  //draw the circles
  drawVisual();
  
  //print info
  printInfo();
}
