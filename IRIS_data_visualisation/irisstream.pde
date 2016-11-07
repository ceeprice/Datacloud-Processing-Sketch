int irisEnt = 1;

void irisstream() {
  
  textAlign(RIGHT);
  text("Iris Stream", width-10, 40);
  text("Time: " + iristimes[irisEnt], width-10, height-50);
  text("Date: " + irisdates[irisEnt],width-10, height-20);
  textAlign(LEFT);
  
  float reqAmp = round(abs(irisvalues[irisEnt])/100);
  //println(reqAmp);
  
  text("Magnitude (relative): " + reqAmp, width/4, height-20);
  
  
  if(amps<reqAmp) {
    amps++;
  } else if(amps>reqAmp) {
    amps--;
  } else if(amps==reqAmp) {
  irisEnt++;
  }
  
  if(irisEnt == irislength) {
    irisEnt = 1;
  }
  
  
  
}