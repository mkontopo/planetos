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
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(70);
    strokeWeight(3);
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);

    float d = PVector.dist(location, center);

    //Alpha channel linked to dist from center. 
    float alpha = map(d, 50, pd+a_outerOffset, 100, 0);
    alpha = constrain(alpha, 0, 100);

    //Noisy bar length
    vcurr = noise(millis()/800.0+innerOffset) * 10;
    vsize = map(d, pd-innerOffset, pd+outerOffset, vcurr, 0);
    vsize = constrain(vsize, 0, vcurr);

    float darkness = map(velocity.heading2D(), 0,PI, 50,255);

    //The gradient bar
    for (float i=0; i<vsize; i++) {
      float val = map(i, vsize, 0, 50, darkness);
      stroke(val, alpha);
      point(i, 0);
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

