int diameter = 100;
int nCircles = 5;
int chooseColor1, chooseColor2, colorR1, colorR2, colorG1, colorG2, colorB1, colorB2;

void setup() {
  size(1000, 1000);
  frameCount = 60;
  fill(0, 100);
  strokeWeight(5);
}

void draw() {
  background(0);
  for (int n = 0; n < nCircles; n++) { // sin-cos on x and y
    float wave = sin(radians(frameCount/6-90 + n*nCircles));
    float vertWave = sin(radians(frameCount + n*nCircles));
    wave = map(wave, -1, 1, 0+diameter/2, width-diameter/2);
    vertWave = map(vertWave, -1, 1, 0+diameter/2, height-diameter/2);
    float wave2 = cos(radians(frameCount/6 + n*nCircles));
    float vertWave2 = cos(radians(frameCount + n*nCircles));
    wave2 = map(wave2, -1, 1, 0+diameter/2, width-diameter/2);
    vertWave2 = map(vertWave2, -1, 1, 0+diameter/2, height-diameter/2);
    stroke(colorR1, colorG1, colorB1);
    circle(wave, vertWave, diameter);
    stroke(colorR2, colorG2, colorB2);
    circle(wave2, vertWave2, diameter);
  }
  for (int n = 0; n < nCircles; n++) { // circles with lines inbetween
    float wave = sin(radians(frameCount/6-90 + n*nCircles));
    wave = map(wave, -1, 1, 0+diameter/2, width-diameter/2);
    float wave2 = cos(radians(frameCount/6 + n*nCircles));
    wave2 = map(wave2, -1, 1, 0+diameter/2, width-diameter/2);
    chooseColor1 = (int)map(wave, 0, width-diameter/2, 0, 765);
    if (chooseColor1 < 255) {  // choose which color should be adjusted on the upper circles
      colorR1 = (int)map(wave, 0+diameter/2, 255-diameter/2, 0, 255);
    } else if (chooseColor1 < 510) {
      colorG1 = (int)map(wave, 255+diameter/2, 510-diameter/2, 0, 255);
    } else {
      colorB1 = (int)map(wave, 510+diameter/2, width-diameter/2, 0, 255);
    }
    chooseColor2 = (int)map(wave2, 0, width-diameter/2, 0, 765);
    if (chooseColor2 < 255) {  // choose which color should be adjusted on the lower circles
      colorR2 = (int)map(wave2, 0+diameter/2, 255-diameter/2, 0, 255);
    } else if (chooseColor2 < 510) {
      colorG2 = (int)map(wave2, 255+diameter/2, 510-diameter/2, 0, 255);
    } else {
      colorB2 = (int)map(wave2, 510+diameter/2, width-diameter/2, 0, 255);
    }
    float y1 = diameter/2;
    float y2 = height-diameter/2;
    stroke(colorR1, colorG1, colorB1);  // actual circle-drawing
    circle(wave, y1, diameter);
    stroke(colorR2, colorG2, colorB2);
    circle(wave2, y2, diameter);
    color currColor1 = color(colorR1, colorG1, colorB1);
    color currColor2 = color(colorR2, colorG2, colorB2);
    gradientLine(wave, y1+diameter/2, wave2, y2-diameter/2, currColor1, currColor2);  // call the gradient line drawer
  }
}

void gradientLine(float x1, float y1, float x2, float y2, color color1, color color2) { // gradient Line calculation
  float lengthLine = y2-y1;  // calculate the length of the lines between upper and lower circles
  float offset = x1-x2;  // calculate the horizontal offset between the upper and lower circles
  for (int i=0; i <= (int)lengthLine; i++) {  // draw a dot at each pixel between upper and lower lines
    float inter = map(i, 0, (int)lengthLine, 0, 1);
    color c = lerpColor(color1, color2, inter);
    stroke(c);
    int thickness = 1;  // thickness of the gradient line
    float calcYoffset = map(i, 0, lengthLine, 0, 1);
    line(x1-(offset*calcYoffset), y1+i, x1+thickness-(offset*calcYoffset), y1+i);  // draw the actual dot with calculated x and y position based on current offset
  }
}
