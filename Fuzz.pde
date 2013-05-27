class Fuzz extends Vehicle {

  float offset;
  float[] fringe;

  Fuzz(PVector l, float ms, float mf) {
    super(l, ms, mf);
    offset = random(300);
    fringe = new float[floor(random(7))];
    for (int i=0; i<fringe.length; i++) {
      fringe[i] = random(30, 100);
    }
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

    //Noisy bar length
    vcurr = noise(millis()/800.0+innerOffset) * 30;
    vsize = map(d, pd-innerOffset, pd+outerOffset, vcurr, 0);
    vsize = map(d, 100, 0, vcurr, 0);
    vsize = constrain(vsize, 0, vcurr);

    //*****Experimental
    canvas.scale(vsize/20.0);

    float darkness = map(d, pd+offset, 0, 255, 0);
    //nDarkness = noise((location.x*location.y)/130000.0) * 255;

    //The gradient bar
    for (float i=0; i<fringe.length; i++) {
      float val = map(i, vsize, 0, 40, darkness);
      canvas.stroke(val, alpha);
      canvas.line(0,0, random(-100, 100), fringe[int(i)] );
    }

    canvas.popMatrix();
  }
}

