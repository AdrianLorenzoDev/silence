class RainSystem {
  Drop[] drops;
  
  public RainSystem(PVector start, PVector end, int numParticles) {
    drops = new Drop[numParticles];
    for(int i = 0; i < numParticles; i++) {
      drops[i] = new Drop(start, end); 
    }
  }
  
  public void run() {
    for(int i = 0; i < drops.length; i++) {
      drops[i].run(); 
    }
  }

}
