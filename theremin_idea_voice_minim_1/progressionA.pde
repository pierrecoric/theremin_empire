void progressionA() {
  if(increaseA == true){
    currentStepA += 1;
    if(currentStepA > stepsA){
      currentStepA = int(stepsA); 
      increaseA = false;
    }
  }
  else{
    currentStepA -= 1;
    if(currentStepA < 1){
      currentStepA = 1;
      increaseA = true;
    }
  }
}
