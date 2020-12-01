void progressionC() {
  if(increaseC == true){
    currentStepC += 1;
    if(currentStepC > stepsC){
      currentStepC = int(stepsC);
      increaseC = false;
    }
  }
  else{
    currentStepC -= 1;
    if(currentStepC < 1){
      currentStepC = 1;
      increaseC = true;
    }
  }
}
