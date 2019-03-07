public enum Mouse {
  Click, Hover, LeftButton, RightButton,
}

interface MouseResponder {
    public void isClicked();
    public void isHovering();
    public void buttonDown(Mouse button);
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
