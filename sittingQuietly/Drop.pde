class Drop {
  PVector start;
  PVector end;
  PVector position;
  PVector size;
  float speed = random(10, 20);
  
  public Drop(PVector start, PVector end) {
    this.start = start;
    this.end = end;
    position = new PVector(
      random(start.x, end.x),
      random(start.y, start.y+10),
      random(start.z, end.z)
    ); 
    size = new PVector(
      random(1, 2),
      random(3, 4),
      1
    );
  }
  
  private void fall() {
    position.y += speed;
    if (position.y >= end.y) {
      position.x = random(start.x, end.x);
      position.y = random(start.y, start.y+10);
      position.z = random(start.z, end.z);
    }
  }
  
  public void run() {
    fall();
    pushMatrix();
    translate(position.x, position.y, position.z);
    fill(12, 183, 242);
    box(size.x, size.y, size.z);
    popMatrix();
  }
}
