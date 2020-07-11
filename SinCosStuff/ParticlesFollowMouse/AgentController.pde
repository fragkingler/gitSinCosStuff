class AgentController {
  ArrayList<FloatList> closest;
  float distance;
  ArrayList<Agent> others;
  int id, otherId;

  AgentController(int amount) {

    closest = new ArrayList<FloatList>(amount);
  }

  void connect(ArrayList others) { // connect objects with one-another
    this.others = others;
    
    for (int i = others.size()-1; i >= 0; i--) { // get distances between mouse and agents
      distance = dist(mouseX, mouseY, this.others.get(i).position.x, this.others.get(i).position.y);
      otherId = this.others.get(i).id;
      closest.add(closest.size(), new FloatList(distance, otherId));
    }
    
    Collections.sort(closest, FL_CMP); // sort by lowest distance to mouse

    int nearestId = (int)closest.get(0).get(1); // get nearest agent
    int nearestId2 = (int)closest.get(1).get(1); // get 2nd nearest agent
    fill(200, 20);
    beginShape(TRIANGLES); // draw triangle between mouse and the two nearest agents
    vertex(this.others.get(nearestId).position.x, this.others.get(nearestId).position.y);
    vertex(this.others.get(nearestId2).position.x, this.others.get(nearestId2).position.y);
    vertex(mouseX, mouseY);
    endShape();
    closest.clear();
  }
}

static final Comparator<FloatList> FL_CMP = new Comparator<FloatList>() { // comparator/sorting function
  @ Override final int compare(final FloatList a, final FloatList b) {
    int cmp;
    return
      (cmp = Float.compare(a.get(0), b.get(0))) != 0? cmp :      
      (cmp = Float.compare(a.get(1), b.get(1)));
  }
};
