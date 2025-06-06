import peasy.*;
PeasyCam cam;
PImage textura;
Planeta[] planetas;

void setup() {
  size(1500, 1000, P3D);
  cam = new PeasyCam(this, 500);

  planetas = new Planeta[9];
  planetas[0] = new Planeta(100, 0.01, 10, "data/mercu.jpg");
  planetas[1] = new Planeta(150, 0.008, 15, "data/ven.jpg");
  planetas[2] = new Planeta(200, 0.006, 16, "data/tier.jpg");
  planetas[3] = new Planeta(250, 0.005, 12, "data/mar.jpg");
  planetas[4] = new Planeta(320, 0.004, 25, "data/jup.jpg");
  planetas[5] = new Planeta(400, 0.003, 22, "data/sat.jpg");
  planetas[6] = new Planeta(460, 0.002, 20, "data/uran.jpg");
  planetas[7] = new Planeta(520, 0.001, 18, "data/nep.jpg");
  planetas[8] = new Planeta(580, 0.0008, 10, "data/plut.jpg");
}

void draw() {
  background(0);
  lights();

  // Sol
  pushMatrix();
  fill(255, 200, 0);
  sphereDetail(30);
  sphere(50);
  popMatrix();

  // Planetas
  for (Planeta p : planetas) {
    p.actualizar();
    p.mostrar();
  }
  
}
