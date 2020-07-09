import java.util.Collections;
import java.util.Comparator;

Agent myAgent;
AgentController aController;
ArrayList<Agent> agents;


void setup() {
  size(1000, 1000);
  int agentAmount = 15; // set the amount of agents/balls
  agents = new ArrayList<Agent>();
  for (int i = 0; i < agentAmount; i++) {
    agents.add(new Agent(i));
  }
  aController = new AgentController(agentAmount);
}

void draw() {
  background(0);
  for (Agent agent : agents) {
    agent.seek(new PVector(mouseX, mouseY));
    agent.update();
    agent.edges();
    agent.show();
    aController.connect(agents);
  }
}
