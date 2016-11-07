int exentno = 0;
boolean dataRetrieved = false;

void updatePerson() {
    db.query("select * from networkinfo where initials='" + initials + "';");
    while(db.next()) {
    source = db.getString("url");
    station = db.getString("station");
    location = db.getString("location");
    
  println(source);
  println(station);
  println(location);
    }
  exData = loadJSONArray(source + ".json");
  exentno = exData.size()-1;
  preInitials = initials;
  
}

void otherstream() {
   textAlign(RIGHT);
  text("External Stream", width-10, 40);
  textAlign(LEFT);
  
  float[] mags = new float[exData.size()];
  float[] xs = new float[exData.size()];
  float[] ys = new float[exData.size()];
  float[] zs = new float[exData.size()];
  String[] times = new String[exData.size()];
  String[] dates = new String[exData.size()];
  
  if(!initials.equals("UI")) {
  
  for(int i = exData.size()-1; i>0; i--) {
    JSONObject entry = exData.getJSONObject(i);
    float floatMag;
    float x;
    float y;
    float z;
      x = entry.getFloat("xaxis");
     y = entry.getFloat("yaxis");
    z = entry.getFloat("zaxis");
     floatMag = entry.getFloat("mag");
    String timestamp = entry.getString("timestamp");
    String[] timestampchunks = timestamp.split("T");
    String[] datechunks =  timestampchunks[0].split("-");
    String day = datechunks[2];
    String month = datechunks[1];
    String year =  datechunks[0];
    
    String date = (day + "/" + month + "/" + year);
    String time = timestampchunks[1];
    time = time.substring(0, 8);
    
    mags[i] = round(floatMag);
    xs[i] = x;
    ys[i] = y;
    zs[i] = z;
    times[i] = time;
    dates[i] = date;
    
  } 

  
  textFont(futurist, 15);
  fill(200);
  text("X: " + xs[exentno], 20, height-20);
  text("Y: " + ys[exentno], 200, height-20);
  text("Z: " + zs[exentno], 400, height-20);
  text("Mag:" + mags[exentno], 600, height-20);
  text("SJ", 10, 20);
  text("OS", 50, 20);
  text("CP", 90, 20);
  text("SW", 130, 20);
  textAlign(RIGHT);
  text("Time: " + times[exentno], width-10, height-50);
  text("Date: " + dates[exentno], width-10, height-20);
  textSize(10);
  text("Station Code", width-10, 75);
  text("Location Code", width-10, 130);
  textSize(15);
  String displaystat = station.toUpperCase();
  text(displaystat, width-10, 100);
  text(location, width-10, 150);
  textAlign(LEFT);
  
  
  if(amps<mags[exentno]) {
    amps+=0.5;
  } else if(amps>mags[exentno]) {
    amps-=0.5;
  } else {
    exentno--;
  }
  
  if(exentno == 0) {
    exentno = exData.size()-1;
  }
  
  println(exentno);
    
  
  
  
  }
  
}