int numVehicles = 250;
PVector center;
float pd; //planet diameter
PGraphics canvas;
int printSize = 2500;

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

  flowfield = new FlowField(5);
  vehicles = new ArrayList<Vehicle>();

  for (int i = 0; i < 100; i++) {
    vehicles.add(new Puff(new PVector(random(printSize), random(printSize)), random(0.5, 1.5), random(0.1, 0.45)));
  }
  for (int i = 0; i < 500; i++) {
    vehicles.add(new Tube(new PVector(random(printSize), random(printSize)), random(0.5, 1.5), random(0.1, 0.45)));
  }

  canvas.background(255);
  canvas.noStroke();
  for (int i=500; i>0; i--) {
    canvas.fill(map(i, 500, 0, 255, 0));
    canvas.ellipse(printSize/2, printSize/2, i, i);
  }
  canvas.endDraw();
}

void draw() {
  canvas.beginDraw();
  diagonal = PVector.sub(new PVector(mouseX, mouseY), center);
  diagonal.normalize();
  diagonal.mult(0.1);

  flowfield.run();
  for (Vehicle v : vehicles) {
    //v.applyForce(diagonal);
    v.follow(flowfield);
    v.run();
  }

  if (millis() - pm >= 300000) {
    println("Saving Image");
    canvas.save("planet.tif");
  }

  canvas.endDraw();

  //image(canvas, 0, 0, 500, 500);
  //for(DarkSpot ds : spots)
  //ds.display();
}

