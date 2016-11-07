//Processing visualisation based on data sources from MySQL, webpages, cloud server Phant, and Arduino

import processing.serial.*;
import de.bezier.data.sql.*;

PFont futurist;

//Sine wave
float diameter = 2;
float t = 0.0;
float dt = 0.2;
float amps = 10;
int x = 0;
float frequency = 0.05;
int baseline;

//MySQL
MySQL db;
String username = "root";
  String password = "omitted";  
  String database = "quakeinfo";
  
  //Arduino
  String serialPortName = "";
Serial arduino;

//Switch modes
Boolean livestream = false ;
Boolean externalstream = false;
boolean maxstream = false;
boolean irisstream = true;
boolean irislatest = false;

String mode = "irislatest";

//ExternalStream person
String preInitials;
String initials = "sw";

//JSON Docs
JSONArray maxData;
JSONArray exData;
String source;
String station;
String location;

//Iris doc
int irislength = 10000;

String[] irisdoc;
float[] irisvalues = new float [irislength];
String[] irisdates = new String[irislength];
String[] iristimes = new String[irislength];

//Iris latest

//Iris table page
String[] latestquakes;

//Indexes of TR lines in html page
int[] tablerows;

void scanForArduino()
{
  try {
    for (int i=0; i<Serial.list ().length; i++) {
      if (Serial.list()[i].contains("tty.usb")) {
        arduino = new Serial(this, Serial.list()[i], 9600);
      }
    }
  } 
  catch(Exception e) {
    // println("Cannot connect to Arduino !");
  }
}



void setup() {
  printArray(Serial.list());
  
  size(1000, 800);
  smooth();
  baseline = height/2;
  futurist = createFont("Futurist", 20);
  
  //arduino
  if (serialPortName.equals("")) scanForArduino();
  else arduino = new Serial(this, serialPortName, 9600);
  
  //MySQL
  db = new MySQL( this, "127.0.0.1:3307", database, username, password);
  db.connect();
  
  //JSON
  maxData = loadJSONArray("http://data.sparkfun.com/output/bGawX1zyX4s4zDaGm23R.json");
  entryno = maxData.size()-1;
  
 db.query("select * from networkinfo where initials='" + initials + "';");
  while(db.next()) {
    source = db.getString("url");
    station = db.getString("station");
    location = db.getString("location");
  println(db.getString("url"));
  }
  exData = loadJSONArray(source + ".json");
  preInitials = initials;
  
  //iris
  irisdoc = loadStrings("irissource.txt");
  for(int i = 1; i<irislength; i++) {
    String[] halves = irisdoc[i].split("  ");
    String[] timehalves = halves[0].split("T");
    String[] datepieces = timehalves[0].split("-");
    String year = datepieces[0];
    String month = datepieces[1];
    String day = datepieces[2];
    String time = timehalves[1];
    iristimes[i] = time.substring(0, 8);
    irisdates[i] = (day+"/"+month+"/"+year);
    
    
    String value = halves[1];
    float irisvalue = float(value);
    irisvalues[i] = irisvalue;
    
    //println(irisvalues[i] + " " + irisdates[i] + " " + iristimes[i]);
    
  }
  
  //Finds amount of TR instances in document
  latestquakes = loadStrings("http://ds.iris.edu/seismon/eventlist/index.phtml");
  int rownumber = 0;
  for(int i = 272; i<latestquakes.length; i++) {
    latestquakes[i] = trim(latestquakes[i]);
    if(latestquakes[i].equals("<tr>")) {
      rownumber++;
    }
  }
  
  //Initialises array to number of instances of TR
  tablerows = new int[rownumber];
  
  //Fills array with indexes of TR
  rownumber = 0;
  for(int i = 0; i<latestquakes.length; i++) {
    if(latestquakes[i].equals("<tr>")) {
      tablerows[rownumber] = i;
      rownumber++;
    }
  }
  
  }
  
  
  

void draw() {
  //draw sine wave
  background(#070f1e, 0.5);
  noStroke();
  
  for(float i=0; i<width/2; i+=10) {
    fill(#248b7c);
    float ellipseX = i*diameter;
    float ellipseY = baseline + amps*sin(frequency*(t+i));
  ellipse(i*diameter, baseline + amps*sin(frequency*(t+i)+1), diameter, diameter);
  ellipse(i*diameter, baseline + amps*sin(frequency*(t+i)+2), diameter, diameter);
  strokeWeight(1);
  //bar opacity
  fill(255, (baseline-ellipseY)*2);
  if(ellipseY>baseline) {
    fill(255, (ellipseY - baseline)*2);
  }
  rectMode(CORNERS);
  rect(ellipseX, ellipseY, ellipseX+10, baseline);
  }
  t += dt;
  
  //mode switch
  textFont(futurist, 15);
  fill(255);
  textAlign(RIGHT);
  text("Mode", width-10, 20);
  textAlign(LEFT);
 
 if(mode.equals("livestream")) {
    livestream();
 } else if (mode.equals("maxstream")) {
  maxstream();
 } else if(mode.equals("otherstream")) {
    otherstream();
 } else if(mode.equals("irisstream")) {
  irisstream();
 } else if (mode.equals("irislatest")) {
irislatest();
 }

}