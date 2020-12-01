void progressionB() {
  if(increaseB == true){
    currentStepB += 1;
    if(currentStepB > stepsB){
      currentStepB = int(stepsB);
      increaseB = false;
    }
  }
  else{
    currentStepB -= 1;
    if(currentStepB < 1){
      currentStepB = 1;
      increaseB = true;
    }
  }
}
