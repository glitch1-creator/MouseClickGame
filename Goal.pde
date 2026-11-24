
class Goal{
 float x, y, size;
 PImage goalImg;

 Goal(float x, float y, float size){
   this.x = x;
   this.y = y;
   this.size = size;
  goalImg = loadImage("diver_frame_1.png");
 }

 void displayGoal(){ // display goal method
   imageMode(CENTER);
   if (goalImg != null) {
     image(goalImg, x, y, size, size);
   } else {
     //fallback if diver image missing
     pushStyle();
     fill(0, 200, 255);
     ellipse(x, y, size, size);
     popStyle();
   }
   imageMode(CORNER);
  }
}
