void mousePressed() {
  if(mode.equals("livestream") && mouseX > width-60 && mouseY > 70 && mouseY < 90) {
    newCode = true;
  }
  
  if(mode.equals("livestream") && mouseY<50 && mouseX>width-300-20 && mouseX < width-300+20) {
    record=!record;
  }
  
  if(mode.equals("otherstream") && mouseY < 40) {
    if(mouseX <30) {
      initials = "sj";
    } else if(mouseX >30 && mouseX < 70) {
      initials = "os";
    } else if(mouseX >70 && mouseX < 110) {
      initials = "cp";
    } else if(mouseX >110 && mouseX < 150) {
      initials="sw";
    }
    updatePerson();
  }
  
  if(mouseX> width-100 && mouseY < 50) {
    
    amps=10;
    if(mode.equals("otherstream")) {
      mode = "irisstream";
      irisEnt = 1;
      
    } else if(mode.equals("irisstream")) {
      mode = "irislatest";
      amps=0;
      
      
    } else if(mode.equals("irislatest")) {
      mode="maxstream";
    }
    
    else if(mode.equals("maxstream")) {
     mode = "livestream";
      
    } else if(mode.equals("livestream")) {
      mode = "otherstream";
      rtb=true;
      updatePerson();
      
    } 
    
  }
  
}