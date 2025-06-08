import peasy.*;
PeasyCam cam;
PImage textura;
PImage fondo; 
Planeta[] planetas;

void setup() {
  size(1500, 1000, P3D);
  cam = new PeasyCam(this, 500);

  fondo = loadImage("fondo.jpg");
  planetas = new Planeta[9];
  planetas[0] = new Planeta(100, 0.01, 10, "mercu.jpg");
  planetas[1] = new Planeta(150, 0.008, 15, "ven.jpg");
  planetas[2] = new Planeta(200, 0.006, 16, "tier.jpg");
  planetas[3] = new Planeta(250, 0.005, 12, "mar.jpg");
  planetas[4] = new Planeta(320, 0.004, 25, "jup.jpg");
  planetas[5] = new Planeta(400, 0.003, 22, "sat.jpg");
  planetas[6] = new Planeta(460, 0.002, 20, "uran.jpg");
  planetas[7] = new Planeta(520, 0.001, 18, "nep.jpg");
  planetas[8] = new Planeta(580, 0.0008, 10, "plut.jpg");
  
  Planeta lunaTierra = new Planeta(30, 0.03, 4, "luna1.jpg");
  planetas[2].agregarLunas(new Planeta[]{lunaTierra});
  
  Planeta[] lunasJupiter = {
  new Planeta(30, 0.02, 5, "luna2.jpg"),
  new Planeta(40, 0.015, 4, "luna1.jpg"),
  new Planeta(50, 0.01, 6, "luna3.jpg"),
  new Planeta(60, 0.007, 5, "luna2.jpg")
  };
  planetas[4].agregarLunas(lunasJupiter);
}

void draw() {
  background(0); 
  lights();  
  cam.beginHUD();
  image(fondo, 0, 0, width, height); // Fondo como imagen
  cam.endHUD();
  


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
