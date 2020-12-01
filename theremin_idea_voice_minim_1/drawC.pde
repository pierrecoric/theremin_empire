void drawC() {
  
  
  ellipse(cx1,cy1,ray,ray);
  ellipse(cx2,cy2,ray,ray);
  stroke(255);
  line(cx1,cy1,cx2,cy2);
  text ("C1 - y",cx1,cy1);
  text ("C2 - x",cx2,cy2);
  
  computeCx = dist(cx1,cy1,cx2,cy1)/stepsC;
  computeCy = dist(cx2,cy2,cx2,cy1)/stepsC;
  computeCx *= currentStepC;
  computeCy *= currentStepC;
  
  masterCx = round(computeCx);
  masterCy = round(computeCy);
  
  
  if(cx2 < cx1 && cy2 < cy1){
    masterCx = cx1 - masterCx;
    masterCy = cy1 - masterCy;
  }
  else if(cx2 > cx1 && cy2 < cy1){
    masterCx = cx1 + masterCx;
    masterCy = cy1 - masterCy;
  }
  else if(cx2 < cx1 && cy2 > cy1){
    masterCx = cx1 - masterCx;
    masterCy = cy1 + masterCy;
  }
  else if (cx2 > cx1 && cy2 > cy1){
    masterCx += cx1;
    masterCy += cy1;
  }
  
  else {
    masterCx = masterCx;
    masterCy = masterCy;
  }
  
  
  fill(255);
  text(stepsC,masterCx,masterCy);
  ellipse(masterCx,masterCy,ray*2,ray*2);
  
  
}
