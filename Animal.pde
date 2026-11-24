class Animal {
  float x, y, size;
  protected PImage[] AnimalImg = new PImage[10];

  boolean frozen = false;
  boolean falling = false;
  float freezeTime = 0;
  float fallSpeed = 0;

  int frameIndex = 0;
  int counter = 0;
  int frameDelay = 10;

  boolean imagesLoaded = false;
  boolean markedForRemoval = false;

  Animal(float x, float y, float size) {
    this.x = x;
    this.y = y;
    this.size = size;
  }

  protected void loadImages() { // default images (Friendy overrides, Enemy overrides)
    for (int i = 0; i < AnimalImg.length; i++) {
      String fn = "starfish_pose_" + (i+1) + ".png";
      AnimalImg[i] = loadImage(fn);
      if (AnimalImg[i] == null) println("Missing: " + fn);
    }
  }

  void ensureImagesLoaded() {
    if (!imagesLoaded) {
      loadImages();
      imagesLoaded = true;
    }
  }

  void updateAnimalImg() {
    counter++;
    if (counter >= frameDelay) {
      counter = 0;
      frameIndex++;
      if (frameIndex >= AnimalImg.length) frameIndex = 0;
    }
  }

  void update(Goal g) {
    // normal movement
    if (!frozen) {
      moveAnimalTowardsGoal(g);
      return;
    }

    // frozen -> after a short delay, start falling
    if (!falling && millis() - freezeTime > 500) {
      falling = true;
    }

    if (falling) {
      fallSpeed += 2.5;
      y += fallSpeed;
    }
  }

  void displayAnimal() {
    ensureImagesLoaded();
    if (AnimalImg[frameIndex] != null) {
      image(AnimalImg[frameIndex], x, y, size, size); // CENTER mode expected
    } else {
      pushStyle();
      fill(255, 0, 0);
      ellipse(x, y, size, size);
      popStyle();
    }
  }

  void moveAnimalTowardsGoal(Goal g) {
    float dx = g.x - x;
    float dy = g.y - y;
    float d = sqrt(dx*dx + dy*dy);

    if (d > 0) {
      dx /= d;
      dy /= d;
    }

    float speed = 1;
    x += dx * speed;
    y += dy * speed;
  }

  void checkClick(float mx, float my) {
    float d = dist(mx, my, x, y);
    if (d < size/2) {
      if (!frozen) {
        frozen = true;
        freezeTime = millis(); 
      }
    }
  }

  boolean isHit(Goal g) {
    float d = dist(x, y, g.x, g.y);
    return d < size/2 + g.size/2;
  }

  void resetState() {
    frozen = false;
    falling = false;
    fallSpeed = 0;
    freezeTime = 0;
    markedForRemoval = false;
  }
}
