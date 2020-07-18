class Cloud {
  int chooseWord; // This variable will later choose a word from the text that this cloud-instance should "carry"
  float cloudW;
  float cloudL;
  float cloudH;
  float startX, startY, startZ;
  float flying, flyingCreation;
  String[] words;

  // Constructor
  Cloud(float startZ, float flying, String text) {
    this.cloudW = random(60, 130); // Each cloud has random width (X)
    this.cloudH = random(100, 200); // Random Height (Y)
    this.cloudL = random(15, 30); // And random Length (Z)
    this.startX = random(-w/2, w/1.5); // Random X-Positioning
    this.startY = random(-500, 150-cloudL); // Random Y-Positioning
    this.startZ = startZ; // Fixed Z-Positioning at start
    this.flyingCreation = flying; // Reset the flying speed to creation-time
    splitText(text); // Call the function to split the input String into an Array of containing words
  }

  // Draw the clouds with animation depending on the input value and return the Z-coordinate of cloud as float
  float drawCloud(float flying) {
    this.flying = flying-flyingCreation; // Calculate flyingSpeed based on the creation-time
    pushMatrix();
    
    // Positioning of the cloud + world-rotation of it
    translate(startX, startY, startZ); // position of the cloud
    rotateX(PI/2.5);
    rotateX(HALF_PI);
    this.flying *= cloudFlyingMod; // Increase flying in order to get "flying-animation"
    translate(0, 0, this.flying); // Apply Flying-effect
    noStroke();
    fill(255, 100); // Transparent cloud
    
     // Actual cloud-drawing
    beginShape(QUADS);
    
    // Top-face of cloud
    vertex(-cloudW, -cloudL, -cloudH);
    vertex( cloudW, -cloudL, -cloudH);
    vertex( cloudW, -cloudL, cloudH);
    vertex(-cloudW, -cloudL, cloudH);

    // Right-face of cloud
    vertex( cloudW, -cloudL, -cloudH);
    vertex( cloudW, cloudL, -cloudH);
    vertex( cloudW, cloudL, cloudH);
    vertex( cloudW, -cloudL, cloudH);

    // Bottom-face of cloud
    vertex( cloudW, cloudL, -cloudH);
    vertex(-cloudW, cloudL, -cloudH);
    vertex(-cloudW, cloudL, cloudH);
    vertex( cloudW, cloudL, cloudH);

    // Left-face of cloud
    vertex(-cloudW, cloudL, -cloudH);
    vertex(-cloudW, -cloudL, -cloudH);
    vertex(-cloudW, -cloudL, cloudH);
    vertex(-cloudW, cloudL, cloudH);

    // Front-face of cloud
    vertex(-cloudW, cloudL, cloudH);
    vertex(cloudW, cloudL, cloudH);
    vertex(cloudW, -cloudL, cloudH);
    vertex(-cloudW, -cloudL, cloudH);

    // Back-face of cloud
    vertex(-cloudW, cloudL, -cloudH);
    vertex(cloudW, cloudL, -cloudH);
    vertex(cloudW, -cloudL, -cloudH);
    vertex(-cloudW, -cloudL, -cloudH);
    endShape();
    
    // Call the drawn on the clouds; before popping the matrix to keep transformations active
    drawText(words);
    popMatrix();
    return (this.flying/cloudFlyingMod)*-1; // Returned Z-Value of the cloud to calculate "despawn"
  }
  
  // Split the input String into an Array of containing words and set text-transformations
  void splitText(String text) {
    textSize(32);
    textAlign(CENTER, CENTER);
    this.words = split(text, ' ');
    chooseWord = round(random(0, words.length-1)); // Choose a random word of the text that this cloud should "carry"
  }

  // Draw the text on the words
  void drawText(String[] words) {
    pushMatrix();
    fill(0);
    rotateX(-HALF_PI);
    rotateZ(-HALF_PI);
    text(words[chooseWord], 0, 0, cloudL+1); // Draw the word on top of the cloud (cloudL). Add "+1" to avoid "glitch-effects"
    popMatrix();
  }
}
