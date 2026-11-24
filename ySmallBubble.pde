
class SmallBubble extends Bubble{

  SmallBubble(float x, float y, float size){
  super(x,y,size); //inheritance
 }

 //new size for bubble display
 @Override
 float drawSize(){
  return size - 5;
 }
}
