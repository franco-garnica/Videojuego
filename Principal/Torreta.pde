class Torreta {

  Tanque1 tanque;
  float angulo;

  Torreta(Tanque1 tanque) {
    this.tanque = tanque;
  }

  void mover() {
    angulo = atan2(mouseY - tanque.y, mouseX - tanque.x) + HALF_PI;
  }

  void mostrar() {

    pushMatrix();

    translate(tanque.x, tanque.y);
    rotate(angulo);

    rectMode(CENTER);
    
 image(imagenTorreta, 0, 0);
    
    popMatrix();
    
  }
}
