void drawB() {
  
  
  ellipse(bx1,by1,ray,ray);
  ellipse(bx2,by2,ray,ray);
  stroke(255);
  line(bx1,by1,bx2,by2);
  text ("B1 - a",bx1,by1);
  text ("B2 - s",bx2,by2);
  
  computeBx = dist(bx1,by1,bx2,by1)/stepsB;
  computeBy = dist(bx2,by2,bx2,by1)/stepsB;
  computeBx *= currentStepB;
  computeBy *= currentStepB;
  
  masterBx = round(computeBx);
  masterBy = round(computeBy);
  
  
  if(bx2 < bx1 && by2 < by1){
    masterBx = bx1 - masterBx;
    masterBy = by1 - masterBy;
  }
  else if(bx2 > bx1 && by2 < by1){
    masterBx = bx1 + masterBx;
    masterBy = by1 - masterBy;
  }
  else if(bx2 < bx1 && by2 > by1){
    masterBx = bx1 - masterBx;
    masterBy = by1 + masterBy;
  }
  else if (bx2 > bx1 && by2 > by1){
    masterBx += bx1;
    masterBy += by1;
  }
  
  else {
    masterBx = masterBx;
    masterBy = masterBy;
  }
  
  
  fill(255);
  text(stepsB,masterBx,masterBy);
  ellipse(masterBx,masterBy,ray*2,ray*2);
  
  
}
