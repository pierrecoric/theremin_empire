void fun() {
  noFill();
  stroke(255,0,0);
  fill(255,0,0,20);
  circle(width/2,height/2,freqA*masterFreq);
  stroke(0,255,0);
  fill(0,255,0,20);
  circle(width/2,height/2,freqB*masterFreq);
  stroke(0,0,255);
  fill(0,0,255,20);
  circle(width/2,height/2,freqC*masterFreq);
}
