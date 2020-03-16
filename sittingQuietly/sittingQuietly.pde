String title = "Silence";

boolean isWPressed = false;
boolean isSPressed = false;
boolean isAPressed = false;
boolean isDPressed = false;
boolean isUpPressed = false;
boolean isDownPressed = false;
boolean isLeftPressed = false;
boolean isRightPressed = false;

PShape bench;
PShape window;
PShape lampPost;
PShape tree;

PImage dirtTexture;

PFont defaultFont;

SittingQuietlyController controller;

public void settings(){
  size(1000, 1000, P3D);
}

public void setup() {
  surface.setTitle(title);
  
  bench = loadShape("Park_Bench.obj");
  dirtTexture = loadImage("ground_texture.jpg");
  
  lampPost = loadShape("lamp_post.obj");
  tree = loadShape("tree01.obj");
  
  defaultFont = createFont("Arial", 15);
  
  controller = new SittingQuietlyController();
}

public void draw() {
  //noCursor();
  background(1);
  controller.run();
}

public float relativeWidth(float rel) {
    return width * rel; 
}

public float relativeHeight(float rel) {
    return height * rel; 
}

void keyPressed() {
  if (key == 'w' || key == 'W') {
    isWPressed = true;    
  }
  
  if (key == 'a' || key == 'A') {
    isAPressed = true;    
  }
  
  if (key == 's' || key == 'S') {
    isSPressed = true;    
  }
  
  if (key == 'd' || key == 'D') {
    isDPressed = true;    
  }
  
  if (key == CODED) {
    if (keyCode == UP) {
      isUpPressed = true; 
    }
    
    if (keyCode == DOWN) {
      isDownPressed = true;
    }
    
    if (keyCode == LEFT) {
      isLeftPressed = true; 
    }
    
    if (keyCode == RIGHT) {
      isRightPressed = true;
    }
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') {
    isWPressed = false;    
  }
  
  if (key == 'a' || key == 'A') {
    isAPressed = false;    
  }
  
  if (key == 's' || key == 'S') {
    isSPressed = false;    
  }
  
  if (key == 'd' || key == 'D') {
    isDPressed = false;    
  }
  
  if (key == CODED) {
    if (keyCode == UP) {
      isUpPressed = false; 
    }

    if (keyCode == DOWN) {
      isDownPressed = false;
    }
    
    if (keyCode == LEFT) {
      isLeftPressed = false; 
    }
    
    if (keyCode == RIGHT) {
      isRightPressed = false;
    }
  }
}

public float getRelativeToCanvasWidth(float rel) {
    return width * rel; 
}

public float getRelativeToCanvasHeight(float rel) {
    return height * rel; 
}
