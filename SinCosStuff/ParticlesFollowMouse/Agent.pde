class Agent {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  ArrayList<Agent> others;
  int id, otherId;
  float distance;
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
      if (this.id != this.others.get(i).id) {
        distance = dist(this.position.x, this.position.y, this.others.get(i).position.x, this.others.get(i).position.y);
        otherId = this.others.get(i).id;
        closest.add(closest.size(), new FloatList(distance, otherId));

        stroke(255);
      }
    }
    for (int i = 0; i < closest.size()-1; i++) {
      FloatList cur = closest.get(i);
      for (int j = i; j < closest.size(); j++) {
        FloatList next = closest.get(j);
        if (next.get(0) < cur.get(0)) {
          FloatList tmp = cur;
          closest.set(i, closest.get(j));
          closest.set(j, tmp);
          break;
        }
      }
    }
    if (this.id == 0) {
      int nearestId = (int)closest.get(0).get(1);
      beginShape(TRIANGLES);
      vertex(this.others.get(nearestId).position.x, this.others.get(nearestId).position.y);
      vertex(this.position.x, this.position.y);
      vertex(mouseX, mouseY);
      endShape();
    }
    closest.clear();
  }
}
