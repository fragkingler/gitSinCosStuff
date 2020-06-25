// Klick auf Objekt zerstört dieses
// Drücken der Taste S ändert die Farbwerte um jeweils +x
// Drücken der Taste P lässt die Objekte runterfallen
int numBalls = 20;
float spring = 1;
float gravity = 0.03;
float friction = -0.4;
ArrayList<Ball> balls = new ArrayList<Ball>();
int colorChange = 1;
boolean looping = true;

void setup() {  
  size(1000, 800);
  for (int i = 0; i < numBalls; i++) {
    balls.add(new Ball(random(width), random(height), random(30, 70), i, balls, color(random(0, 255), random(0, 255), random(0, 255))));
  }
  noStroke();
  fill(255, 204);
}

void draw() {
  if (looping) {
    background(0);
    for (Ball ball : balls) {
      ball.collide();
      ball.move();
      ball.display();
    }
  }
}

void keyPressed() {
  if (key == 's' || key == 'S') {
    for (int i = 0; i < balls.size(); i++) {
      if (red(balls.get(i).colorBall) < 255) { 
        balls.get(i).colorBall += color(colorChange, 0, 0);
      } else if (green(balls.get(i).colorBall) < 255) { 
        balls.get(i).colorBall += color(0, colorChange, 0);
      } else if (blue(balls.get(i).colorBall) < 255) { 
        balls.get(i).colorBall += color(0, 0, colorChange);
      } else { 
        balls.get(i).colorBall = color(random(0, 255), random(0, 255), random(0, 255));
      }
    }
  }
}

void keyReleased() {
  if (key == 32) {
    looping = !looping;
  } else if (keyCode == 10) {
    balls.add(new Ball(random(width), random(height), random(30, 70), balls.size(), balls, color(random(0, 255), random(0, 255), random(0, 255))));
  }
}

void mouseReleased() {
  if (looping) {
    for (int i = balls.size()-1; i >= 0; i--) {
      Ball ball = balls.get(i);
      if ((ball.x + ball.diameter) > mouseX && (ball.x - ball.diameter) < mouseX && (ball.y + ball.diameter) > mouseY && (ball.y - ball.diameter) < mouseY) {
        ball.kill(i);
      }
    }
  }
}
