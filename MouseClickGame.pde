PImage bg; //background image
Goal g; //goal
//Animal[] animal;
ArrayList<Animal> animal;
Bubble[] bubble; //Array of Bubbles

//  different game states so the game is playable and can be restarted
final int STATE_START = 0;
final int STATE_PLAY  = 1;
final int STATE_GAME_OVER = 2;
int gameState = STATE_START;


int score = 0;
int lives = 3;
String gameOverReason = "";

void setup(){
 //size(900,700);
 fullScreen();

 // for smoother animation and consistent timing
 frameRate(60);

 bg = loadImage("bg.jpeg");

 animal = new ArrayList<Animal>();

 bubble = new Bubble[100]; //Array of Bubbles

 g = new Goal(width/2, height/2, 150); // goal

 /*
 looping throught the array
 insted of typing individual array
 index everytime.
 */
 for (int i=0; i<bubble.length; i++){
  if(i%2 == 0){
    bubble[i] = new SmallBubble(0, 0, 30);
 }
   else{
    bubble[i] = new BigBubble(0, 0, 30);
   }

   // start bubbles at random positions
   bubble[i].x = random(width);
   bubble[i].y = random(height);
 }

 //loop animal
 for (int z=0; z<10; z++){ // initial number of animals  on screen
  float[] p = edgeSpawn(60); // spawn at the edges so enemies clearly travel toward the goal
  if(z%2 == 0){
    animal.add (new Enemy(p[0], p[1], 70));
 }
   else{
    // friendlies spawn randomly 
    animal.add (new Friendly(random(width), random(height), 60));
   }
 }
}


/*------------RENDERING ON THE SCREEN--------------------*/
/*------------RENDERING ON THE SCREEN--------------------*/
/*------------RENDERING ON THE SCREEN--------------------*/
void draw() {
  imageMode(CORNER);
  if (bg != null) {
    image(bg, 0, 0, width, height);
  } else {
    background(10, 30, 60); // fallback if bg.jpeg missing
  }

  g.displayGoal(); //display the goal

  for (Bubble b : bubble) { //display and move bubbles
    b.displayBubble();
    b.moveBubble();
  }

  imageMode(CENTER);


//SETTING THE DIFFERENT GAME STATE FUNCTIONS
  // Start screen
  if (gameState == STATE_START) {
    drawHUD();
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(44);
    text("Click to Start", width/2, height/2 - 40);
    textSize(20);
    text("Stop Enemies reaching the diver.\nClick o Enemies (Octopus) to freeze them.\nAvoid clicking Friendlies (Starfish) you lose lives.", width/2, height/2 + 40);
    return;
  }

  // Game over screen
  if (gameState == STATE_GAME_OVER) {
    drawHUD();
    fill(255);
    textAlign(CENTER, CENTER);
    textSize(60);
    text("Game Over", width/2, height/2 - 60);
    textSize(22);
    text("Reason: " + gameOverReason + "\nClick to restart", width/2, height/2 + 30);
    return;
  }

  /*------------PLAY state: update animals-----------*/
// PLAY state: update animals
for (int i = animal.size() - 1; i >= 0; i--) {
  Animal a = animal.get(i);

  a.update(g);
  a.updateAnimalImg();
  a.displayAnimal();

  // FRIENDLY logic
  if (a instanceof Friendly) {
    Friendly f = (Friendly) a;

    // clicked on any friendly will remove and replace
    if (f.markedForRemoval) {
      animal.remove(i);
      spawnFriendly();
      continue;
    }

    // if drifted off-screen, remove and replace
    if (f.y < -100 || f.y > height + 100 || f.x < -100 || f.x > width + 100) {
      animal.remove(i);
      spawnFriendly();
      continue;
    }
  }

  // ENEMY logic
  if (a instanceof Enemy) {
    Enemy e = (Enemy) a;

    // if enemy not frozen and hits the goal sub 1 life
  if (!e.frozen && e.isHit(g)) {
    lives--; // take away 1 life
    animal.remove(i); //remove that animal form arrayList
    
    if (lives <= 0){ //if lives is zero call triggerGameOver
     triggerGameOver("Enemy reached Diver too many times"); 
     break;
    }
    
    spawnEnemy(); //add new enemy animal
    continue;
  }
  
  // frozen enemy fell off-screen do remove and respawn
  if (e.frozen && e.y > height + 150) {
    animal.remove(i);
    spawnEnemy();
    continue;
  }

 }
}
/*----------------END OF PLAY STATE---------------------*/
/*----------------END OF PLAY STATE---------------------*/
/*----------------END OF PLAY STATE---------------------*/


  drawHUD(); // show score/lives every frame
}
/*------------RENDERING ON THE SCREEN--------------------*/
/*------------RENDERING ON THE SCREEN--------------------*/
/*------------RENDERING ON THE SCREEN--------------------*/



/*----------------MOUSECLICK METHOD---------------------*/
/*----------------MOUSECLICK METHOD---------------------*/
/*----------------MOUSECLICK METHOD---------------------*/
void mouseClicked() {

  // state-based click handling (start + restart)
  if (gameState == STATE_START) {
    resetGame();
    gameState = STATE_PLAY;
    return;
  }
  if (gameState == STATE_GAME_OVER) {
    resetGame();
    gameState = STATE_PLAY;
    return;
  }

  //for (Animal e : animal) {
  //  e.checkClick(mouseX, mouseY);
  //}
  for (int i = animal.size() - 1; i >= 0; i--) { // check click on all animal (iterate backward)
  animal.get(i).checkClick(mouseX, mouseY);
}

}
/*----------------END MOUSECLICK METHOD---------------------*/
/*----------------END MOUSECLICK METHOD---------------------*/
/*----------------END MOUSECLICK METHOD---------------------*/

/* BASIC METHOD FOR DISPLAYING SCORE AND LIVES */
/* BASIC METHOD FOR DISPLAYING SCORE AND LIVES */
/* BASIC METHOD FOR DISPLAYING SCORE AND LIVES */
void drawHUD() {
  fill(255);
  textAlign(LEFT, TOP);
  textSize(20);
  text("Score: " + score, 20, 20);
  text("Lives: " + lives, 20, 46);
}
/* END OF BASIC METHOD FOR DISPLAYING SCORE AND LIVES */
/* END OF BASIC METHOD FOR DISPLAYING SCORE AND LIVES */
/* END OF BASIC METHOD FOR DISPLAYING SCORE AND LIVES */



/*restartGame method to be used to reset game state */
/*restartGame method to be used to reset game state */
/*restartGame method to be used to reset game state */
void resetGame() {
  score = 0;
  lives = 3;
  gameOverReason = "";
  
  animal.clear();
  
  for(int z=0; z<10; z++){ //total number of animal at resetGame() call
   float [] p = edgeSpawn(60);
   if (z%2 == 0){ //half of total for enemy
    animal.add(new Enemy(p[0], p[1], 70)); 
   }
   else{ //half for friendly hence 50/50
    animal.add(new Friendly(random(width), random(height), 60)); 
   }
  }
}
/*restartGame method to be used to reset game state */
/*restartGame method to be used to reset game state */
/*restartGame method to be used to reset game state */



/* Method to be used to ends the game cleanly */
/* Method to be used to ends the game cleanly */
void triggerGameOver(String reason) {
  gameOverReason = reason;
  gameState = STATE_GAME_OVER;
}
/* Method to be used to ends the game cleanly */
/* Method to be used to ends the game cleanly */



/* An Array to edge Animal (both enimies and friendlies form off screen to screen) */
/* An Array to edge Animal (both enimies and friendlies form off screen to screen) */
/* An Array to edge Animal (both enimies and friendlies form off screen to screen) */
float[] edgeSpawn(float margin) {
  int side = int(random(4));
  float x = 0;
  float y = 0;

  if (side == 0) {          // top
    x = random(margin, width - margin);
    y = -margin;
  } else if (side == 1) {   // right
    x = width + margin;
    y = random(margin, height - margin);
  } else if (side == 2) {   // bottom
    x = random(margin, width - margin);
    y = height + margin;
  } else {                  // left
    x = -margin;
    y = random(margin, height - margin);
  }
  return new float[]{x, y}; //return new array locations for the array used for offscreen spawn
}
/* An Array to edge Animal (both enimies and friendlies form off screen to screen) */
/* An Array to edge Animal (both enimies and friendlies form off screen to screen) */
/* An Array to edge Animal (both enimies and friendlies form off screen to screen) */





// respawn enemies from outside screen to inside screen
void spawnEnemy() {
  float[] p = edgeSpawn(60);
  animal.add(new Enemy(p[0], p[1], 70));
}

// friendly respawn from random location
void spawnFriendly() {
  animal.add(new Friendly(random(width), random(height), 60));
}
