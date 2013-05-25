class DarkSpot{
   float diameter;
   float rad;
   PVector location;
   DarkSpot(){
     diameter = random(50,350);
     rad = diameter/2.0;
     float theta = random(TWO_PI);
     float rad = random(width/4);
     location = new PVector(width/2+cos(theta)*rad, height/2+sin(theta)*rad);
   }    
   
   void display(){
      pushStyle();
      noFill();
      stroke(255,0,0);
      ellipse(location.x, location.y, diameter,diameter);
      popStyle(); 
   }
}
