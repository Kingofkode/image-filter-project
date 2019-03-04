class DropDownView extends Button {
  String[] options;
  DropDownView(String startTitle, String[] startOptions, float startXPos, float startYPos, float startViewWidth, float startViewHeight) {
    super(startTitle, startXPos, startYPos, startViewWidth, startViewHeight);
    options = startOptions;
  }
  
  void click() {
    super.click();
    println("Clicked");
    showOptions();
  }
  
  void showOptions() {
    for (int i = 0; i < options.length; i++) {
      Button optionBtn = new Button(options[i], 0, viewHeight*i, viewWidth, viewHeight);
      addChildView(optionBtn);
    }
  }
  
  void hover() {
    super.hover();
    
  }
  
  
  
  
}
