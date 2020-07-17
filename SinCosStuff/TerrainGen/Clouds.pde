class Cloud {
  int chooseWord;
  float cloudW = 100;
  float cloudH = 20;
  float cloudL = 150;
  float startX, startY, startZ;
  float flying, flyingCreation;
  String[] words;

  Cloud(float startZ, float flying, String text) {
    this.cloudW = random(60, 130);
    this.cloudL = random(100, 200);
    this.cloudH = random(15, 30);
    this.startX = random(-w/2, w/1.5);
    this.startY = random(-500, 150-cloudH);
    this.startZ = startZ;
    this.flyingCreation = flying;
    splitText(text);
  }

  float drawCloud(float flying) {
    this.flying = flying-flyingCreation;
    pushMatrix();
    translate(startX, startY, startZ); // position of the cloud
    rotateX(PI/2.5); // Rotate the Terrain that will be drawn
    rotateX(HALF_PI);
    this.flying *= cloudFlyingMod;
    translate(0, 0, this.flying);
    noStroke();
    fill(255, 100);
    beginShape(QUADS);

    // Top-face of cloud
    vertex(-cloudW, -cloudH, -cloudL, cloudW*2, cloudL*2);
    vertex( cloudW, -cloudH, -cloudL, cloudW*2, cloudL*2);
    vertex( cloudW, -cloudH, cloudL, cloudW*2, cloudL*2);
    vertex(-cloudW, -cloudH, cloudL, cloudW*2, cloudL*2);

    // Right-face of cloud
    vertex( cloudW, -cloudH, -cloudL);
    vertex( cloudW, cloudH, -cloudL);
    vertex( cloudW, cloudH, cloudL);
    vertex( cloudW, -cloudH, cloudL);

    // Bottom-face of cloud
    vertex( cloudW, cloudH, -cloudL);
    vertex(-cloudW, cloudH, -cloudL);
    vertex(-cloudW, cloudH, cloudL);
    vertex( cloudW, cloudH, cloudL);

    // Left-face of cloud
    vertex(-cloudW, cloudH, -cloudL);
    vertex(-cloudW, -cloudH, -cloudL);
    vertex(-cloudW, -cloudH, cloudL);
    vertex(-cloudW, cloudH, cloudL);

    // Front-face of cloud
    vertex(-cloudW, cloudH, cloudL);
    vertex(cloudW, cloudH, cloudL);
    vertex(cloudW, -cloudH, cloudL);
    vertex(-cloudW, -cloudH, cloudL);

    // Back-face of cloud
    vertex(-cloudW, cloudH, -cloudL);
    vertex(cloudW, cloudH, -cloudL);
    vertex(cloudW, -cloudH, -cloudL);
    vertex(-cloudW, -cloudH, -cloudL);
    endShape();
    drawText(words);
    popMatrix();
    return (this.flying/cloudFlyingMod)*-1;
  }
  void splitText(String text) {
    textSize(32);
    textAlign(CENTER, CENTER);
    this.words = split(text, ' ');
    chooseWord = round(random(0, words.length-1));
  }

  void drawText(String[] words) {
    pushMatrix();
    fill(0);
    rotateX(-HALF_PI);
    rotateZ(-HALF_PI);
    text(words[chooseWord], 0, 0, cloudH+1);
    popMatrix();
  }
}
