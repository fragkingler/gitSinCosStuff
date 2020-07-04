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
    maxSpeed = random(5,15);
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
    stroke(120, 100);
    fill(255, 100);
    circle(position.x, position.y, 50);
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
    acceleration.mult(random(0.2,0.8));
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
    if (this.id == 0) {
      fill(255, 100);
      this.others = others;
      for (int i = others.size()-1; i >= 0; i--) {
        distance = dist(mouseX, mouseY, this.others.get(i).position.x, this.others.get(i).position.y);
        otherId = this.others.get(i).id;
        closest.add(closest.size(), new FloatList(distance, otherId));
      }
      Collections.sort(closest, FL_CMP);

      int nearestId = (int)closest.get(0).get(1);
      int nearestId2 = (int)closest.get(1).get(1);
      beginShape(TRIANGLES);
      vertex(this.others.get(nearestId).position.x, this.others.get(nearestId).position.y);
      vertex(this.others.get(nearestId2).position.x, this.others.get(nearestId2).position.y);
      vertex(mouseX, mouseY);
      endShape();
      closest.clear();
    }
  }
}

static final Comparator<FloatList> FL_CMP = new Comparator<FloatList>() {
  @ Override final int compare(final FloatList a, final FloatList b) {
    int cmp;
    return
      (cmp = Float.compare(a.get(0), b.get(0))) != 0? cmp :      
      (cmp = Float.compare(a.get(1), b.get(1)));
  }
};
