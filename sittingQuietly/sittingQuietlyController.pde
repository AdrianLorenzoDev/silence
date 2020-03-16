public class SittingQuietlyController {
  private PVector eyePosition = new PVector(730, -200, -830);
  private PVector eyeDirection = new PVector(0, 0, 1);
  private PVector eyeUp = new PVector(0, 1, 0);
  
  private float yaw = 130;
  private float pitch = -10;
  
  private boolean isLightOn = true; 

  private final float eyeTranslationDelta = 4;
  private final float eyeRotationDelta = 1.5;
  
  private final PVector benchPosition = new PVector(0, -95, -10);
  private final PVector treePosition = new PVector(-70, -20, 270);
  private final PVector lampPostPosition = new PVector(250, -25, -10);
  private final PVector lightPosition = new PVector(lampPostPosition.x, lampPostPosition.y-510, lampPostPosition.z);
  
  private final PVector floorSize = new PVector(600, 10, 600);
  private final PShape floor;
  
  private final RainSystem rain = new RainSystem(
    new PVector(-300, -800, -300),
    new PVector(300, -5, 500),
    1000
  );

  public SittingQuietlyController() {
    beginShape();
    floor = createShape(BOX, floorSize.x, floorSize.y, floorSize.z);
    floor.setTexture(dirtTexture);
    endShape();

    bench.scale(1);
    bench.rotateX(PI);

    lampPost.scale(30);
    lampPost.rotateX(PI);
    
    tree.scale(2);
    tree.rotateX(PI);
  }

  public void updateCameraMovement() {
    if (isWPressed) {
      eyePosition.add(PVector.mult(eyeDirection, eyeTranslationDelta));
    }

    if (isSPressed) {
      eyePosition.sub(PVector.mult(eyeDirection, eyeTranslationDelta));
    }

    if (isAPressed) {
      PVector crossProduct = new PVector();
      PVector.cross(eyeDirection, eyeUp, crossProduct);
      crossProduct.normalize();
      eyePosition.sub(PVector.mult(crossProduct, eyeTranslationDelta));
    }

    if (isDPressed) {
      PVector crossProduct = new PVector();
      PVector.cross(eyeDirection, eyeUp, crossProduct);
      crossProduct.normalize();
      eyePosition.add(PVector.mult(crossProduct, eyeTranslationDelta));
    }

    if (isUpPressed) {
      pitch -= eyeRotationDelta;
      pitch = pitch % 360;
    }

    if (isDownPressed) {
      pitch += eyeRotationDelta;
      pitch = pitch % 360;
    }

    if (isLeftPressed) {
      yaw -= eyeRotationDelta;
      yaw = yaw % 360;
    }

    if (isRightPressed) {
      yaw += eyeRotationDelta;
      yaw = yaw % 360;
    }

    PVector direction = new PVector(
      cos(radians(yaw)) * cos(radians(pitch)), 
      sin(radians(pitch)), 
      sin(radians(yaw)) * cos(radians(pitch))
      );

    direction.normalize();
    eyeDirection = direction;
  }

  public void showControls() {
    fill(255);
    textFont(defaultFont);
    text("WASD keys → Move camera", 
      getRelativeToCanvasWidth(0.02), 
      getRelativeToCanvasHeight(0.98));
    text("ARROWS keys → Rotate camera", 
      getRelativeToCanvasWidth(0.02), 
      getRelativeToCanvasHeight(0.96));
  }

  public void setCamera() {
    PVector dir = PVector.add(eyePosition, eyeDirection);
    camera(
      eyePosition.x, eyePosition.y, eyePosition.z, 
      dir.x, dir.y, dir.z, 
      eyeUp.x, eyeUp.y, eyeUp.z
    );
  }

  public void drawScene() {
    if (frameCount % (60 * 7) == 0) { 
      isLightOn = false; 
    } else if (frameCount % 30 == 0) {
      isLightOn = true; 
    }
    
    lightFalloff(0.2, 0, 0.000009);
    
    pushMatrix();
    translate(lightPosition.x, lightPosition.y, lightPosition.z);
    
    if (isLightOn) {
      emissive(240, 240, 240);
      ambientLight(240, 240, 240);
      spotLight(240, 240, 240, lightPosition.x, lightPosition.y, lightPosition.z, benchPosition.x, benchPosition.y, benchPosition.z, 1, 1);
    } else {
      emissive(50, 50, 50);
      ambientLight(50, 50, 50);
      spotLight(50, 50, 50, lightPosition.x, lightPosition.y, lightPosition.z, benchPosition.x, benchPosition.y, benchPosition.z, 1, 1);
    }
    
    sphere(20);
    popMatrix();
    
    pushMatrix();
    translate(0, -20, 0);
    shape(floor);
    popMatrix();

    pushMatrix();
    translate(benchPosition.x, benchPosition.y, benchPosition.z);
    shape(bench);
    popMatrix();

    pushMatrix();
    translate(lampPostPosition.x, lampPostPosition.y, lampPostPosition.z);
    shape(lampPost);
    popMatrix();
    
    pushMatrix();
    translate(treePosition.x, treePosition.y, treePosition.z);
    shape(tree);
    popMatrix();
  }

  public void run() {
    updateCameraMovement();
    setCamera();
    rain.run();
    drawScene();
    camera();
    hint(DISABLE_DEPTH_TEST);
    showControls();
    hint(ENABLE_DEPTH_TEST);
  }
}
