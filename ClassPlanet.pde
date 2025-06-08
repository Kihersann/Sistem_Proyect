class Planeta {
  float distancia, angulo, velocidad, radio;
  PImage textura;
  Planeta[] lunas;

  Planeta(float distancia, float velocidad, float radio, String archivo) {
    this.distancia = distancia;
    this.velocidad = velocidad;
    this.radio = radio;
    this.angulo = random(TWO_PI);
    this.textura = loadImage(archivo);
  }

  void actualizar() {
    angulo += velocidad;
  }

  void mostrar() {
    pushMatrix();
    rotateY(angulo);
    translate(distancia, 0, 0);
    noStroke();

    if (textura != null) {
      //textureMode(NORMAL);
      //sphereDetail(24);
      //texture(this.textura);
      //sphere(radio);
      PShape plan = createShape(SPHERE, radio);
      plan.setTexture(this.textura);
      shape(plan);
      // No pongas endShape(); porque no estás usando vértices
    } else {
      fill(100, 100, 255);
      sphere(radio);
    }
    popMatrix();

    if (lunas != null) {
    for (Planeta luna : lunas) {
      luna.actualizar();
      pushMatrix();
      rotateY(this.angulo); // que orbitan con el planeta
      translate(this.distancia, 0, 0); // posición del planeta
      luna.mostrar();
      popMatrix();
    }
  }

}
  
  
  void agregarLunas(Planeta[] lunas) {
  this.lunas = lunas;
  }

  
}
