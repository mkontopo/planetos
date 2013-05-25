int numVehicles = 500;

FlowField flowfield;
ArrayList<Vehicle> vehicles;

void setup() {
  size(800, 800, P3D);
  smooth(4);
  // Make a new flow field with "resolution" of 16
  flowfield = new FlowField(5);
  vehicles = new ArrayList<Vehicle>();
  // Make a whole bunch of vehicles with random maxspeed and maxforce values
  for (int i = 0; i < numVehicles; i++) {
    vehicles.add(new Vehicle(new PVector(random(width), random(height)), random(0.5, 1.5), random(0.1, 0.45)));
  }
  background(255);
  
}

void draw() {
  //background(255);
  // Display the flowfield in "debug" mode
  flowfield.run();
  // Tell all the vehicles to follow the flow field
  for (Vehicle v : vehicles) {
    v.follow(flowfield);
    v.run();
  }
}



