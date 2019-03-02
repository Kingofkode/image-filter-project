View mainView = new View(0,0,600,400);

void setup () {
  size(600,400);
}

void draw() {
  mainView.render(); // VIEW MANAGEMENT
  determineIfLeftOrRightMouseButtonIsDown(); // VIEW MANAGEMENT
}

void mouseMoved() {
  interactWithTopView(Mouse.Hover); // VIEW MANAGEMENT
}

void mousePressed() {
  interactWithTopView(Mouse.Click); // VIEW MANAGEMENT
}
