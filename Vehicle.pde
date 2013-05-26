class Vehicle { 

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float vsize, vcurr;
  float innerOffset, outerOffset;
  float a_innerOffset, a_outerOffset;
  float nDarkness;
  

  Vehicle(PVector l, float ms, float mf) {
    location = l.get();
    r = 3.0;
    vsize = 5;
    maxspeed = ms;
    maxforce = mf;
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);
    innerOffset = random(5, 70);
    outerOffset = random(5, 70);
    a_innerOffset = random(5, 70);
    a_outerOffset = random(5, 70);
    
  }

  public void run() {
    update();
    borders();
    display();
  }
  
  void follow(FlowField flow) {
    PVector desired = flow.lookup(location);
    // Scale it up by maxspeed
    desired.mult(maxspeed);
    // Steering is desired minus velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    applyForce(steer);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    location.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
  }

  void display() {
    //override in sub class
  }

  // Wraparound
  void borders() {
    if (location.x < -r) location.x = printSize+r;
    if (location.y < -r) location.y = printSize+r;
    if (location.x > printSize+r) location.x = -r;
    if (location.y > printSize+r) location.y = -r;
  }
}

