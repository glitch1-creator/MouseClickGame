
class BigBubble extends Bubble{

  BigBubble(float x, float y, float size){
   super(x,y,size);
  }

  //new size for bubble display
  @Override
  float drawSize(){
   return size + 10;
 }
}
