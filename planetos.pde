int numVehicles = 250;
PVector center;
float pd; //planet diameter

FlowField flowfield;
ArrayList<Vehicle> vehicles;
PVector diagonal;

void setup() {
  size(800, 800, P3D);
  center = new PVector(width/2, height/2, 0);
  diagonal = new PVector(0, 0, 0);

  smooth(4);
  pd = 300;

  flowfield = new FlowField(5);
  vehicles = new ArrayList<Vehicle>();

  for (int i = 0; i < 100; i++) {
    vehicles.add(new Puff(new PVector(random(width), random(height)), random(0.5, 1.5), random(0.1, 0.45)));
  }
  for (int i = 0; i < 600; i++) {
    vehicles.add(new Tube(new PVector(random(width), random(height)), random(0.5, 1.5), random(0.1, 0.45)));
  }
  background(255);
  noStroke();
  for(int i=400; i>0; i--){
    fill(map(i, 400,0, 255,0));
    ellipse(width/2,height/2, i,i);
  }
}

void draw() {
  
  diagonal = PVector.sub(new PVector(mouseX,mouseY), center);
  diagonal.normalize();
  diagonal.mult(0.1);

  flowfield.run();
  for (Vehicle v : vehicles) {
    //v.applyForce(diagonal);
    v.follow(flowfield);
    v.run();
  }

  //for(DarkSpot ds : spots)
  //ds.display();
}


