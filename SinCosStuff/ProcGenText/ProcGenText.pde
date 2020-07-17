PGraphics buffer;
PGraphics buffer2;

// Credit to "PurePixel" and "MadPixel" for creating the font
PFont font;

int frame = 6560;
int textX, textY;

void setup() {
  size(800, 800, P2D);
  font = createFont("Minecrafter.Reg.ttf", 32);
  textFont(font);
  buffer = createGraphics(width, height, P2D);
  buffer2 = createGraphics(width, height, P2D);
}

void draw() {
  drawBuffer(textX, textY);

  int cells = 50;
  int spacing = width / cells;

  buffer2.beginDraw();
  buffer2.clear();
  buffer2.noFill();
  //buffer2.stroke(255);
  buffer2.noStroke();
  for (int y = 0; y < cells; y++) {
    for (int x = 0; x < cells; x++) {
      int wave = floor(sin(radians(frame + x/2*y/2)) * 1000/cells);

      int sx = x * spacing + wave;
      int sy = y * spacing;
      int sw = spacing;
      int sh = spacing;

      int dx = x * spacing;
      int dy = y * spacing;
      int dw = spacing;
      int dh = spacing;

      buffer2.copy(buffer, sx, sy, sw, sh, dx, dy, dw, dh);
      buffer2.rect(x * spacing, y * spacing, spacing, spacing);
    }
  }
  buffer2.endDraw();

  //image(buffer, 0, 0);
  image(buffer2, 0, 0);
}


void drawBuffer(int textX, int textY) {
  buffer.beginDraw();
  buffer.clear();
  buffer.translate(width/2, height/2);
  buffer.noStroke();
  buffer.fill(0);
  buffer.textSize(height/12);
  buffer.textAlign(CENTER, CENTER);
  buffer.text("Procedural Generation", textX, textY);
  buffer.endDraw();
}

void keyPressed() {
  if (key == ' ') {
    frame++;
    println(frame);
  }
  else if(key == 's'){
    buffer2.save("procGenText.png");
  }
}
