
int entryno;
float maxM;

void maxstream() {
   textAlign(RIGHT);
  text("Peak Stream", width-10, 40);
  textAlign(LEFT);
  
  float[] mags = new float[maxData.size()];
  float[] xs = new float[maxData.size()];
  float[] ys = new float[maxData.size()];
  float[] zs = new float[maxData.size()];
  String[] times = new String[maxData.size()];
  String[] dates = new String[maxData.size()];
  
  for(int i = maxData.size()-1; i>0; i--) {
    JSONObject entry = maxData.getJSONObject(i);
    float floatMag = entry.getFloat("mag");
    float x = entry.getFloat("xaxis");
    float y = entry.getFloat("yaxis");
    float z = entry.getFloat("zaxis");
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
  text("X: " + xs[entryno], 20, height-20);
  text("Y: " + ys[entryno], 200, height-20);
  text("Z: " + zs[entryno], 400, height-20);
  text("Mag:" + mags[entryno], 600, height-20);
  textAlign(RIGHT);
  text("Time: " + times[entryno], width-10, height-50);
  text("Date: " + dates[entryno],width-10, height-20);
  textAlign(LEFT);
  
  
  if(round(amps)<mags[entryno]) {
    amps+=0.1;
  } else if(round(amps)>mags[entryno]) {
    amps-=0.1;
  } else {
    entryno--;
  }
  
  if(entryno == 0) {
    entryno = maxData.size();
  }
  
  println(amps + " " + mags[entryno]);
    
    
  
  
  
  
}