void drawA() {
  
  
  ellipse(ax1,ay1,ray,ray);
  ellipse(ax2,ay2,ray,ray);
  stroke(255);
  line(ax1,ay1,ax2,ay2);
  fill(255);
  text ("A1 - q",ax1,ay1);
  text ("A2 - w",ax2,ay2);
  
  computeAx = dist(ax1,ay1,ax2,ay1)/stepsA;
  computeAy = dist(ax2,ay2,ax2,ay1)/stepsA;
  computeAx *= currentStepA;
  computeAy *= currentStepA;
  
  masterAx = round(computeAx);
  masterAy = round(computeAy);
  
  if(ax2 < ax1 && ay2 < ay1){
    masterAx = ax1 - masterAx;
    masterAy = ay1 - masterAy;
  }
  else if(ax2 > ax1 && ay2 < ay1){
    masterAx = ax1 + masterAx;
    masterAy = ay1 - masterAy;
  }
  else if(ax2 < ax1 && ay2 > ay1){
    masterAx = ax1 - masterAx;
    masterAy = ay1 + masterAy;
  }
  else if (ax2 > ax1 && ay2 > ay1){
    masterAx += ax1;
    masterAy += ay1;
  }
  
  else {
    masterAx = masterAx;
    masterAy = masterAy;
  }
  
  
  
  
  fill(255);
  text(stepsA,masterAx,masterAy);
  ellipse(masterAx,masterAy,ray*2,ray*2);
  
  
}
