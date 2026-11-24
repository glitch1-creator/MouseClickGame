

//inherite from Animal class
class Enemy extends Animal{
 Enemy(float x, float y, float size){
  super(x,y,size);
 }
 
 @Override
  void checkClick(float mx, float my) {
    float d = dist(mx, my, x, y);
    if (d < size/2) {
      // only score the first time you freeze it
      if (!frozen) {
        frozen = true;
        freezeTime = millis();
        score++; // increase score
      }
    }
  }

 @Override
  protected void loadImages(){
   for(int i = 0; i < AnimalImg.length; i++){
     String fn = "octopus_pose_" + (i+1) +".png";
    AnimalImg[i] = loadImage(fn);
    if (AnimalImg[i] == null) println("missing  " + fn); //check incase an image fails to load
   }
  }

  // enemies move a bit faster than base Animal for clearer threat
  @Override
  void moveAnimalTowardsGoal(Goal g) {
    float dx = g.x - x; // g.x is goal's x position and x is enemy position
    float dy = g.y - y;
    float d = sqrt(dx*dx + dy*dy);

    if (d > 0) { //normalizing direction from enemy to goal
      dx /= d;
      dy /= d;
    }

    float speed = 4; // enemy speed
    x += dx * speed;
    y += dy * speed;
  }
}
