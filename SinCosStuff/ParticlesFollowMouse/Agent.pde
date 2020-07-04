class Agent {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  ArrayList<Agent> others;
  int id, otherId;
  float distance;
  FloatList item = new FloatList();
  ArrayList<FloatList> closest;
  int amount;

  Agent(int id, int amount) {
    position = new PVector(random(0, width), random(0, height));
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
    maxSpeed = 10;
    this.id = id;
    closest = new ArrayList<FloatList>(amount);
    this.amount = amount;
  }

  void update() {
    position.add(velocity);
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
  }

  void show() {
    noStroke();
    fill(255);
    circle(position.x, position.y, 50);
  }

  void seek(PVector target) {
    PVector direction = new PVector();
    direction = PVector.sub(target, position);
    direction.normalize();
    acceleration = direction;
    acceleration.mult(0.5);
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

  void connect(ArrayList others) { // connect objects with one-another
    this.others = others;
    for (int i = others.size()-1; i >= 0; i--) {
      if (this.id != this.others.get(i).id) { // this comment saves me from out-of-bounds, workaround shouldn't be a big problem tho'
        distance = dist(this.position.x, this.position.y, this.others.get(i).position.x, this.others.get(i).position.y);
        otherId = this.others.get(i).id;
        item.append(distance);
        item.append(otherId);
        println("current item: " + item);
        closest.add(closest.size(), item);
        println("Array of items: " + closest);
        item.clear();

        stroke(255);
        if (this.id != 4) {
          beginShape(TRIANGLES);
          vertex(this.others.get(i).position.x, this.others.get(i).position.y);
          vertex(this.others.get(i).position.x, this.others.get(i).position.y);
          vertex(mouseX, mouseY);
          endShape();
        }
      }
    }
    closest.clear();
  }
}
