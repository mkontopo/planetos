class Vehicle { 

  PVector location;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  float vsize;
  float innerOffset, outerOffset;

    Vehicle(PVector l, float ms, float mf) {
    location = l.get();
    r = 3.0;
    vsize = 5;
    maxspeed = ms;
    maxforce = mf;
    acceleration = new PVector(0,0);
    velocity = new PVector(0,0);
    innerOffset = random(10,50);
    outerOffset = random(10,50);
  }

  public void run() {
    update();
    borders();
    display();
  }

  void follow(FlowField flow) {
    // What is the vector at that spot in the flow field?
    PVector desired = flow.lookup(location);
    // Scale it up by maxspeed
    desired.mult(maxspeed);
    // Steering is desired minus velocity
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    applyForce(steer);
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }

  // Method to update location
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
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    strokeWeight(3);
    pushMatrix();
    translate(location.x,location.y);
    rotate(theta);
    
    float d = PVector.dist(location, center);
    
    float alpha = map(d, pd-50,pd+10, 255,0);
    alpha = constrain(alpha, 0,255);
    
    vsize = map(d, pd-innerOffset, pd+outerOffset, 5,0);
    vsize = constrain(vsize, 0,5);
    
    for(float i=-vsize; i<vsize; i++){
       stroke(map(abs(i), 5,0, 40,255), 200);
       point(i,0);
    }
    popMatrix();
  }

  // Wraparound
  void borders() {
    if (location.x < -r) location.x = width+r;
    if (location.y < -r) location.y = height+r;
    if (location.x > width+r) location.x = -r;
    if (location.y > height+r) location.y = -r;
  }
}


