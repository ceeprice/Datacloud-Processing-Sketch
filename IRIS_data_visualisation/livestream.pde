int counter=0;
boolean rtb = false;
boolean newCode = true;

boolean record = false;

String randomCode;
String randomNetwork;

float xreading = 0;
float yreading = 0;
float zreading = 0;

String recordKey = "P49rN7o5znueo0pZJlgP";
String recordURL = "DJm4dyMxKaHDW2dZRNp8";

int currentSecond = 0;

void livestream() {
  if ((arduino != null) && (arduino.available()>0)) {
    String message = arduino.readStringUntil('\n');
    
    if (message != null) {
      
      String[] wholeMessage = message.split(" ");
      
    if (wholeMessage.length == 2) {
        String axis = wholeMessage[0];
        String reading = wholeMessage[1];
        float number = Float.parseFloat(reading);
        if(axis.equals("x")) {
          xreading = number;
        } else
        if(axis.equals("y")) {
          yreading = number;
        } else
        if(axis.equals("z")) {
          zreading = number;
        } else
        
         if(axis.equals("m")) {
          amps = number;
        }
        counter = 0;
    }       
  }
      
     
}
counter++;

if(newCode == true) {
  db.query("select * from stationcodes order by rand() limit 1;");
  while(db.next()) {
    randomCode = db.getString("code");
randomNetwork = db.getString("location");
newCode = false;
    
  }
}

textFont(futurist, 15);
//record button
if(record == true) {
fill(200, 50, 50);
} else {
  fill(200);
}
ellipse(width-300, 20, 30, 30);
fill(200);
textAlign(CENTER);
text("Record", width-300, 50);
textAlign(LEFT);

if(record == true && currentSecond != second()) {
  loadStrings("http://data.sparkfun.com/input/" + recordURL + "?private_key="+ recordKey + "&xaxis=" + xreading + "&yaxis=" + yreading + "&zaxis=" + zreading
  + "&mag=" + amps + "&locationcode=" + randomCode);
  currentSecond = second();
}

String sec = Integer.toString(second());
if(second()<10) {
  sec = "0" + sec;
}
String min = Integer.toString(minute());
if(minute()<10) {
  min = "0" + min;
}



  text("X: " + xreading, 20, height-20);
  text("Y: " + yreading, 200, height-20);
  text("Z: " + zreading, 400, height-20);
  text("Mag:" + round(amps), 600, height-20);
  text("Code: " + randomCode, 20, 20);
  text("Location: " + randomNetwork, 200, 20);
   textAlign(RIGHT);
  text("Livestream", width-10, 40);
  text("New Location", width-10, 80);
  text("Time: " + hour() + ":" + min + ":" + sec, width-10, height-50);
  text("Date: " + day() + ":" + month() + ":" + year(),width-10, height-20);
  textAlign(LEFT);

//Return to base rate
if(counter==100) {
  rtb = true;
}

if(rtb == true && amps!=10) {
  if(amps>10) {
    amps-=0.1;
  } else if(amps<10) {
    amps+=0.1;
  }
} else {
  rtb = false;
}
}