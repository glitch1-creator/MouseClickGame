
//inherite from Animal class
class Friendly extends Animal{
 Friendly(float x, float y, float size){
  super(x,y,size);
 }

  @Override
  protected void loadImages(){
   for(int i = 0; i < AnimalImg.length; i++){
     String fn = "starfish_pose_" + (i+1) +".png";
    AnimalImg[i] = loadImage(fn);
    if (AnimalImg[i] == null) println("missing  " + fn); //check incase an image fails to load
   }
  }

  @Override
  void checkClick(float mx, float my) {
    float d = dist(mx, my, x, y); // CENTER mode expected
    if (d < size/2) {
      lives--;                 // penalty
      markedForRemoval = true; // let draw() method remove + respawn
  
      if (lives <= 0) {
        triggerGameOver("You clicked too many Friendlies");
      }
    }
  }


  // friendlies don't chase the goal; they drift around 
  @Override
  void update(Goal g) {
    // simple drifting movement with gentle wobble
    x += sin((frameCount + x) * 0.01) * 1.5;
    y += cos((frameCount + y) * 0.01) * 1.2;

    // keep animation running (friendlies can still animate)
    // (we call updateAnimalImg() in draw like the others)
  }
}
