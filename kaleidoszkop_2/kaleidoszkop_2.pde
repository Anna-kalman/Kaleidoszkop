float rotationAngle = 0; // Az elforgatás szögének kezdőértéke
color currentBgColor;  // Jelenlegi háttérszín
color targetBgColor;   // Cél háttérszín

color currentStrokeColor;  // Jelenlegi vonalszín
color targetStrokeColor;   // Cél vonalszín

void setup() {
  size(800, 800);
  smooth(); // A sima élek érdekében
  noFill(); // Ne legyen kitöltve a rombuszok belseje

  // Kezdeti háttér és vonalszínek
  currentBgColor = color(random(255), random(255), random(255));
  targetBgColor = color(random(255), random(255), random(255));

  currentStrokeColor = color(random(255), random(255), random(255));
  targetStrokeColor = color(random(255), random(255), random(255));

  // Kezdeti háttér szín beállítása
  background(currentBgColor);
}

void draw() {
  // A háttér színét lassan váltjuk a lerpColor segítségével
  currentBgColor = lerpColor(currentBgColor, targetBgColor, 0.01);
  background(currentBgColor);

  // A rombuszok színét lassan váltjuk
  currentStrokeColor = lerpColor(currentStrokeColor, targetStrokeColor, 0.01);
  
  // A rombuszok elforgatásának folyamatos frissítése
  rotationAngle += 0.5; // A forogás sebessége
  
  float distance = 100; // A rombuszok eltolása 2 négyzetnyire (100 pixel)
  int numRhombuses = 12; // A rombuszok száma (12 darab rombusz a teljes kör körül)
  float angleStep = 360.0 / numRhombuses; // Az egyes rombuszok közötti szög

  // Az ablak középpontjába helyezzük a koordináta rendszert
  translate(width / 2, height / 2);

  // A rombuszok kirajzolása
  for (int i = 0; i < numRhombuses; i++) {
    float angle = i * angleStep; // A következő rombusz szöge
    stroke(currentStrokeColor);  // A rombuszok vonala az aktuális színnel
    strokeWeight(6); // Fix vonalvastagság
    drawRhombus(angle, distance);
  }

  // Véletlenszerűen beállítjuk a cél színeket a következő körhöz
  targetBgColor = color(random(255), random(255), random(255));
  targetStrokeColor = color(random(255), random(255), random(255));
}

void drawRhombus(float angle, float distance) {
  pushMatrix(); // A matrix mentése, hogy az elforgatás ne befolyásolja a többi rombuszt
  rotate(radians(angle + rotationAngle)); // Az elforgatás változtatása, a rombuszok forognak

  translate(distance, 0); // Eltoljuk a rombuszt a kívánt távolságra
  
  beginShape();
  vertex(0, -50); // Felső csúcs
  vertex(50, 0);  // Jobb csúcs
  vertex(0, 50);  // Alsó csúcs
  vertex(-50, 0); // Bal csúcs
  endShape(CLOSE);

  popMatrix(); // A matrix visszaállítása, hogy a következő rombusz ne legyen elforgatva
}
