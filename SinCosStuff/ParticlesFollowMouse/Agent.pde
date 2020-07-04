class Agent {
  int id;
  PVector position, velocity, acceleration;
  float maxSpeed, diameter;
  ArrayList<Agent> others;

  Agent(int id) {
    position = new PVector(random(0, width), random(0, height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    maxSpeed = random(5,15);
    this.id = id;
    diameter = random(30, 80);
  }

  void update() {
    position.add(velocity);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
  }

  void show() {
    stroke(120, 100);
    fill(255, 100);
    circle(position.x, position.y, diameter);
    textSize(40);
    textAlign(CENTER, CENTER);
    fill(255, 0, 0);
    text(this.id, position.x, position.y);
  }

  void seek(PVector target) {
    PVector direction = new PVector();
    direction = PVector.sub(target, position);
    direction.normalize();
    acceleration = direction;
    acceleration.mult((random(0.4,0.6)/diameter)*20);
    stroke(255);
    //line(position.x, position.y, mouseX, mouseY);
  }

  void edges() {
    if (position.x < 0) {
      position.x = width;
    }
    if (position.x > width) {
      position.x = 0;
    }

    if (position.y < 0) {
      position.y = height;
    }
    if (position.y > height) {
      position.y = 0;
    }
  }
}
