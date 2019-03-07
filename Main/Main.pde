 
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
  
  for (int i = 0; i < options.length; i++) {
    final int index = i;
    MouseResponder responderToAdd = new MouseResponder() {
      public void isClicked() {
        println("Clickkkkkkk");
        switch (index) {
          case 0: println("This"); break;
          case 1: println("That"); break;
          case 2: println("Save"); break;
          case 3: println("Open"); break;
        };
        
      }
      public void isHovering() {}
      public void buttonDown(Mouse button) {}
    };
    
    dropDown.responders.add(responderToAdd);
  }
  
  mainView.addChildView(dropDown);
}
