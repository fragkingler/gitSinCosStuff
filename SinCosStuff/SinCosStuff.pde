int diameter = 100;
int nCircles = 5;

void setup() {
  size(1000, 1000);
  frameCount = 60;
  fill(0, 100);
  strokeWeight(5);
}

void draw() {
  background(0);
  for (int n = 0; n < nCircles; n++) {
    float wave = sin(radians(frameCount/6 + n*nCircles));
    float vertWave = sin(radians(frameCount + n*nCircles));
    wave = map(wave, -1, 1, 0+diameter/2, width-diameter/2);
    vertWave = map(vertWave, -1, 1, 0+diameter/2, height-diameter/2);
    circle(wave, vertWave, diameter);
  }
  for (int n = 0; n < nCircles; n++) {
    float wave = sin(radians(frameCount/6 + n*nCircles));
    wave = map(wave, -1, 1, 0+diameter/2, width-diameter/2);
    float wave2 = cos(radians(frameCount/6 + n*nCircles));
    wave2 = map(wave2, -1, 1, 0+diameter/2, width-diameter/2);
    float y1 = diameter/2;
    float y2 = height-diameter/2;
    circle(wave, y1, diameter);
    circle(wave2, y2, diameter);
    stroke(255);
    line(wave,y1+diameter/2,wave2,y2-diameter/2);
  }
}
