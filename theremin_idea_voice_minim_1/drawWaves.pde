void drawWaves() {
  for( int i = 0; i < out.bufferSize() - 1; i++ )
  {
    stroke(125);
    // find the x position of each buffer value
    float x1  =  map( i, 0, out.bufferSize(), 0, width );
    float x2  =  map( i+1, 0, out.bufferSize(), 0, width );
    // draw a line from one buffer position to the next for both channels
    line( x1, height/2  - out.left.get(i)*50,  x2, height/2  - out.left.get(i+1)*50);
    line( x1, height/2 - out.right.get(i)*50, x2, height/2 - out.right.get(i+1)*50);
  } 
}
