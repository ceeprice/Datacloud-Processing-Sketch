int quakeno = 0;
String[] halves;

String date;
  String time;
  float lat;
  float lon;
  int mag;
  float dep;
  String region;
  
  int delaytimer;


void irislatest() {
  
  delaytimer++;
  int startrow = tablerows[quakeno];
  int endrow = tablerows[quakeno+1];
  
  //Breaks up chunks of html between TR's
  
  //time&date
  String datetime = latestquakes[startrow+1];
  halves = datetime.split("> ");
  String[] datetimehalf = halves[1].split(" ");
  date = datetimehalf[0];
  time = datetimehalf[1];
  
  //Region
  String rline = latestquakes[startrow+6];
  halves = rline.split(">");
  region = halves[2];
  
  //Lat, Long, Mag & Depth
  for (int i = 2; i<6; i++) {
    String line = latestquakes[startrow+i];
  halves = line.split("> ");
  String[] split = halves[1].split(" ");
  if(i == 2) {
    lat = float(split[0]);
  } else if(i ==3) {
    lon = float(split[0]);
  } else if (i==4) {
    mag = int(split[0]);
  } else if(i == 5) {
    dep = float(split[0]);
  }
  }
  //println(lat + " " + lon + " " +  mag + " " + dep + " " + date  + " " + time); 
  
  textAlign(RIGHT);
  text("Iris Latest Stream", width-10, 40);
  text("Time: " + time, width-10, height-50);
  text("Date: " + date, width-10, height-20);
  textAlign(LEFT);
  
  text("Lat: " + lat, 20, height-20);
  text("Lon: " + lon, 200, height-20);
  text("Mag: " + mag, 400, height-20);
  text("Depth:" + dep, 600, height-20);
  text("Region: " + region, 20, 20);
  
  
  if(round(amps)<dep) {
    amps+=0.5;
  } else if (round(amps)>dep) {
    amps-=0.5;
  } else if(round(amps)==dep) {
    if(delaytimer >= 300) {
    quakeno++;
    delaytimer=0;
    }
  }
  
  println(amps + " " + mag*50);
  
  /*if(quakeno == tablerows.length-1) {
    quakeno=0;
  }*/
  
  
  
  
  
  
  
  
  
  
  
  
}