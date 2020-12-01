void superDraw(){
  stroke(255,0,0);
  line(masterAx,masterAy,masterBx,masterBy);
  stroke(0,255,0);
  line(masterBx,masterBy,masterCx,masterCy);
  stroke(0,0,255);
  line(masterCx,masterCy,masterAx,masterAy);
  freqA = (dist(masterAx, masterAy, masterBx, masterBy));
  freqB = (dist(masterBx, masterBy, masterCx, masterCy));
  freqC = (dist(masterCx, masterCy, masterAx, masterAy));
  freqA = map(freqA,0,width,55,880);
  freqB = map(freqB,0,width,55,880);
  freqC = map(freqC,0,width,55,880);
  //assign new frequency to each osc
  factor = map(readA1,100,1000,0,1.5);
  generalAmp = map (readA2,100,1000,0,1);
  
  freqA = freqA*factor;
  freqB = freqB*factor;
  freqC = freqC*factor;
  //
  displayInfo();
  wave1.setFrequency( freqA );
  wave2.setFrequency( freqB );
  wave3.setFrequency( freqC );
  
  wave1.setAmplitude( generalAmp );
  wave2.setAmplitude( generalAmp );
  wave3.setAmplitude( generalAmp );
  

}
