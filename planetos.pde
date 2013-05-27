int numVehicles = 250;
PVector center;
float pd; //planet diameter
PGraphics canvas;
int printSize = 2500;
long pm = 0;

FlowField flowfield;
ArrayList<Vehicle> vehicles;
PVector diagonal;

void setup() {
  size(200, 200, P3D);
  canvas = createGraphics(printSize, printSize, P3D);
  canvas.beginDraw();
  center = new PVector(canvas.width/2, canvas.height/2, 0);
  println(canvas.width);
  diagonal = new PVector(0, 0, 0);

  canvas.smooth(4);
  pd = canvas.width/3;

  flowfield = new FlowField(10);
  vehicles = new ArrayList<Vehicle>();

  for (int i = 0; i < 400; i++) {
    //vehicles.add(new Puff(new PVector(random(printSize), random(printSize)), random(0.5, 2.5), random(0.1, 0.55)));
  }
  for (int i = 0; i < 1000; i++) {
    //vehicles.add(new Tube(new PVector(random(printSize), random(printSize)), random(0.5, 2.5), random(0.1, 0.55)));
  }
  for (int i = 0; i < 600; i++) {
    vehicles.add(new Fuzz(new PVector(random(printSize), random(printSize)), random(0.5, 2.5), random(0.1, 0.55)));
  }

  canvas.background(255);
  canvas.noStroke();
  for (int i=floor(1000); i>0; i--) {
    canvas.fill(map(i, 1000, 0, 255, 0));
    canvas.ellipse(canvas.width/2, canvas.height/2, i, i);
  }
  canvas.endDraw();
}

void draw() {
  canvas.beginDraw();
//  
//  canvas.pushStyle();
//  canvas.fill(255,2);
//  canvas.noStroke();
//  canvas.rect(0,0,canvas.width,canvas.height);
//  canvas.popStyle();
  
  diagonal = PVector.sub(new PVector(printSize,0), center);
  diagonal.normalize();
  diagonal.mult(1);

  flowfield.run();
  for (Vehicle v : vehicles) {
    //v.applyForce(diagonal);
    v.follow(flowfield);
    v.run();
  }

  if (millis() - pm >= 100000) {
    println("Saving Image");
    canvas.save("planet-"+frameCount+".tif");
    pm = millis();
  }
  canvas.endDraw();




  //image(canvas, 0, 0, 500, 500);
  //for(DarkSpot ds : spots)
  //ds.display();
}

