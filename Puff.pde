class Puff extends Vehicle {

  PImage puff;

  Puff(PVector l, float ms, float mf) {
    super(l, ms, mf);
    puff = loadImage("puff.png");
  } 

  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(70);
    canvas.strokeWeight(3);
    canvas.pushMatrix();
    canvas.translate(location.x, location.y);
    canvas.rotate(theta);

    float d = PVector.dist(location, center);

    //Alpha channel linked to dist from center. 
    float alpha = map(d, 50, pd+a_outerOffset, 100, 0);
    alpha = constrain(alpha, 0, 100);

    //Noisy size
    vcurr = noise(millis()/800.0+innerOffset) * 10;
    vsize = map(d, pd-innerOffset, pd+outerOffset, vcurr, 0);
    vsize = constrain(vsize, 0, vcurr);

    nDarkness = map(velocity.heading2D(), -PI, PI, 0, 100);

    canvas.pushStyle();
    canvas.tint(nDarkness,nDarkness,nDarkness, alpha);
    canvas.image(puff, 0, 0, vsize, vsize);
    canvas.popStyle();

    canvas.popMatrix();
  }
}

