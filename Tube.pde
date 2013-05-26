class Tube extends Vehicle {

  float offset;
  
  Tube(PVector l, float ms, float mf) {
    super(l, ms, mf);
    offset = random(300, 800);
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


    //float darkness = map(velocity.heading2D(), -PI,PI, 0,255);
    float darkness = map(d, offset,0, 255,0);
    //nDarkness = noise((location.x*location.y)/150000.0) * 255;

    //The gradient bar
    for (float i=0; i<vsize; i++) {
     float val = map(i, vsize, 0, 50, darkness);
     stroke(val, alpha);
     point(i, 0);
     }

    popMatrix();
  }
}

