class Cloud {
  int chooseWord; // This variable will later choose a word from the text that this cloud-instance should "carry"
  int id;
  float cloudW;
  float cloudL;
  float cloudH;
  float startX, startY, startZ;
  float flying, flyingCreation;
  String[] words;
  boolean stopCloud;

  // Constructor
  Cloud(int id, float startZ, float flying, String text) {
    this.cloudW = random(60, 130); // Each cloud has random width (X)
    this.cloudH = random(100, 200); // Random Height (Y)
    this.cloudL = random(15, 30); // And random Length (Z)
    this.startX = random(-w/2, w/1.5); // Random X-Positioning
    this.startY = random(-500, 150-cloudL); // Random Y-Positioning
    this.startZ = startZ; // Fixed Z-Positioning at start
    this.id = id; // Each cloud has it's own ID for debugging reasons
    this.flyingCreation = flying; // Reset the flying speed to creation-time
    this.stopCloud = false; // Boolean that checks if cloud is stopped, clouds start "unstopped"
    splitText(text); // Call the function to split the input String into an Array of containing words
  }

  // Draw the clouds with animation depending on the input value and return the Z-coordinate of cloud as float
  float drawCloud(float flying) {
    this.flying = flying-flyingCreation; // Calculate flyingSpeed based on the creation-time
    
    // All transformations appear in pushMatrix
    pushMatrix();

    // Positioning of the cloud + world-rotation of it
    translate(startX, startY, startZ); // Position of the cloud
    rotateX(PI/2.5);
    rotateX(HALF_PI);
    
    // Check if cloud has not been stopped
    if (!stopCloud) {
      this.flying *= cloudFlyingMod; // Increase flying in order to get "flying-animation"
    } else { // If it has been stopped, pause flying animation
      flyingCreation = this.flying;
    }
    
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

    // Back-face of cloud
    vertex(-cloudW, cloudL, cloudH);
    vertex(cloudW, cloudL, cloudH);
    vertex(cloudW, -cloudL, cloudH);
    vertex(-cloudW, -cloudL, cloudH);

    // Front-face of cloud
    vertex(-cloudW, cloudL, -cloudH);
    vertex(cloudW, cloudL, -cloudH);
    vertex(cloudW, -cloudL, -cloudH);
    vertex(-cloudW, -cloudL, -cloudH);
    endShape();

    // Call the drawn on the clouds; before popping the matrix to keep transformations active
    drawText(words);
    
    // Get 2D-screen positions of the cloud; happens within transformations to prevent weird offsets
    float screenStartX = screenX(-cloudW, -cloudL, -cloudH);
    float screenStartY = screenY(-cloudW, cloudL, -cloudH);
    
    // End transformations
    popMatrix();
    
    // Set stop cloud if cloudStopper is active
    //if (mouseX >= screenStartX-20 && mouseX <= screenStartX + cloudW && mouseY >= screenStartY-5 && mouseY <= screenStartY + cloudL && cloudStopper == true) {
    //  stopCloud = true;
    //}
    
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
