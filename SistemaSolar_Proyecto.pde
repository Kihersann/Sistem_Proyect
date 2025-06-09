// librerias
import peasy.*;
import ddf.minim.*;

PeasyCam cam; // iniciando peasycam
Minim minim; // iniciando minim
AudioPlayer musica; 

PImage textura, fondo, texsol; // iniciando variables en PImage para ocupar imagenes externas
int botonY = 10, botonX = 10; // posicion del boton 
int botonA = 285, botonL = 110; // tamaño del boton 
boolean detector = false; // variable para detectar boton
boolean modocambiado = false; // variable para saber si hubo cambio o no de modo

Planeta[] planetas; //arreglo de planetas ocupando la clase planeta

// valores o datos de los planetas en modo realista
float[][] propiedadesRealistas = {
  {58, 0.04, 2.4},
  {108, 0.02, 6},
  {150, 0.01, 6.4},
  {228, 0.008, 3.4},
  {300, 0.004, 20},
  {400, 0.003, 17},
  {460, 0.002, 9},
  {520, 0.0015, 9},
  {580, 0.0008, 1.2}
};

// valores o datos de los planetas en modo decorativo
float[][] propiedadesDecorativas = {
  {100, 0.01, 10},
  {150, 0.008, 15},
  {200, 0.006, 16},
  {250, 0.005, 12},
  {320, 0.004, 25},
  {400, 0.003, 22},
  {460, 0.002, 20},
  {520, 0.001, 18},
  {580, 0.0008, 10}
};

// texturas de planetas
String[] texturasPlanetas = {
  "mercu.jpg", "ven.jpg", "tier.jpg", "mar.jpg", "jup.jpg",
  "sat.jpg", "uran.jpg", "nep.jpg", "plut.jpg"
};

void setup() {
  size(1500, 1000, P3D);
  cam = new PeasyCam(this, 500);
  minim = new Minim(this);
  fondo = loadImage("fondo.jpg");
  texsol = loadImage("sun.jpg");
  musica = minim.loadFile("cornfieldChase.mp3");
  musica.loop(); 

  planetas = new Planeta[9];
  for (int i = 0; i < planetas.length; i++) {
    float[] props = propiedadesDecorativas[i];
    planetas[i] = new Planeta(props[0], props[1], props[2], texturasPlanetas[i]);
  }
  agregarLunas();
  
}

void draw() {
  background(0); 
 // lights(); 
 
  cam.beginHUD();
  hint(DISABLE_DEPTH_TEST);
  
  image(fondo, 0, 0, width, height); // Fondo como imagen
  
  detector = mouseX > botonX && mouseX < botonX + botonA &&
              mouseY > botonY && mouseY < botonY + botonL;
  
  if (detector) {
    fill(150,200,255);
  } else{
    fill(100,150,200);
  }
  rect(botonX, botonY, botonA, botonL); // se dibuja boton redondeado 
  
  // texto del boton
  fill(255);
  textAlign(CENTER, CENTER);
  textSize(16);
  if (modocambiado) {
    text("Da clic para cambiar a MODO DECORATIVO", botonX + botonA / 2, botonY + botonL / 2);
  } else { 
    text ("Da clic para cambiar a MODO REALISTA", botonX + botonA / 2, botonY + botonL / 2);
  }
  
  hint(ENABLE_DEPTH_TEST);
  cam.endHUD();
  
  // Sol
  
  
  PShape texturasol = createShape(SPHERE, 50);
      texturasol.setTexture(texsol);
      shape(texturasol);
  
  /*pushMatrix();
  fill(255, 200, 0);
  sphereDetail(30);
  sphere(50);
  popMatrix();*/

  // Planetas
  for (Planeta p : planetas) {
    p.actualizar();
    p.mostrar();
  }  
}

// genera cambio de valor bool de modocambiado, detecta en que modo esta
void mousePressed() {
  if (detector) {
    modocambiado = !modocambiado;
    actualizarModoSistema(modocambiado);
  }
}

void actualizarModoSistema(boolean realista) {
  float[][] propiedades = realista ? propiedadesRealistas : propiedadesDecorativas;

  for (int i = 0; i < planetas.length; i++) {
    float[] props = propiedades[i];
    planetas[i].distancia = props[0];
    planetas[i].velocidad = props[1];
    planetas[i].radio = props[2];
  }
}

void agregarLunas() {
  // Tierra
  Planeta lunaTierra = new Planeta(30, 0.03, 4, "luna1.jpg");
  planetas[2].agregarLunas(new Planeta[]{lunaTierra});

  // Júpiter
  Planeta[] lunasJupiter = {
    new Planeta(30, 0.02, 5, "luna2.jpg"),
    new Planeta(40, 0.015, 4, "luna1.jpg"),
    new Planeta(50, 0.01, 6, "luna3.jpg"),
    new Planeta(60, 0.007, 5, "luna2.jpg")
  };
  planetas[4].agregarLunas(lunasJupiter);
}

void stop(){
  musica.close();
  minim.stop();
  super.stop();
}
