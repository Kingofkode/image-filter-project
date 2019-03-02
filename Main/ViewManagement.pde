// VIEW MANAGEMENT methods

// Must be called during mouseMoved() & mousePressed()
void interactWithTopView(Mouse interaction) {
  View currentView = mainView;
  View currentInteractableView = mainView.responder == null ? null : mainView;
  // Searches for the frontmost view that contains the mouse and has a non-null delegate
  while (currentView.getTopChildViewThatContainsMouse() != null) {
    currentView = currentView.getTopChildViewThatContainsMouse();
    if (currentView.responder != null) currentInteractableView = currentView;
  }
  
  if (currentInteractableView != null) {
    switch (interaction) {
      case Click:
        currentInteractableView.click();
        break;
      case LeftButton:
        currentInteractableView.leftButtonDown();
        break;
      case RightButton:
        currentInteractableView.rightButtonDown();
        break;
      case Hover:
        currentInteractableView.hover();
    }
  }
}

// Must be called during draw()
void determineIfLeftOrRightMouseButtonIsDown() {
  // Left mouse button is held down
  if (mousePressed && (mouseButton == LEFT)) {
    interactWithTopView(Mouse.LeftButton);
  }else if (mousePressed && (mouseButton == RIGHT)) {
    // Right mouse button is held down
    interactWithTopView(Mouse.RightButton);
  }
}
