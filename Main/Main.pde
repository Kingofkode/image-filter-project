
final View mainView = new View(0,0,0,0); 
DropDownView dropDown;

void setup () {
  fullScreen();
  setupMainView();
  setupDropDown();
}

void setupMainView() {
  mainView.viewWidth = width;
  mainView.viewHeight = height;
}

void setupDropDown() {
  String[] options = {"This", "That", "Save", "Open"};
  dropDown = new DropDownView("File", options, 0, 0, 100, 50);
  dropDown.responder = new MouseResponder() {
    public void isClicked() {}
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  mainView.addChildView(dropDown);
}
