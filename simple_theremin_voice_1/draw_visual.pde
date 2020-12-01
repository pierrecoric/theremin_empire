void drawVisual() {
  //dim
  stroke(freq3 * 200);
  noFill();
  //
  
  //draw the circles and display the frequency
  circle(width/2,height/2,freq1);
  circle(width/2,height/2,freq2);
  fill(255);
  text(freq1, width/2 + 5 - freq1/2, height/2);
  text(freq2, width/2 + 5 - freq2/2, height/2);

}
