
class Bubble{
 float x, y, size;

 //overridable
 float drawSize(){
   return size;
 }

 //constructor
 Bubble(float x, float y, float size){
  this.x = x;
  this.y = y;
  this.size = size;
 }

 void displayBubble(){ //display bubble
   pushStyle();
   noStroke();
   fill(255, 255, 255, 80);
   float s = drawSize();
   ellipse(x, y, s, s);
   popStyle();
 }

 void moveBubble(){ //move bubble
   y = y - 3; //with specified speed 

   // ADDED: use drawSize() so big bubbles wrap correctly
   if (y < -drawSize()){
    x = random(width);
    y = height + random(0, height); //stagger respawn so bubbles feel continuous
   }
 }
}
