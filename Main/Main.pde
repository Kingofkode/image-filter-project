View mainView = new View(0,0,600,400);

void setup () {
  size(600,400);
  final View blueView = new View(10,10, 200, 200);
  blueView.viewColor = color(133, 205, 246);
  mainView.addChildView(blueView);
  blueView.responder = new MouseResponder() {
    public void isClicked() {
      blueView.viewWidth = 400;
    }
    // All 3 methods must be present even if they are not used
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
}
