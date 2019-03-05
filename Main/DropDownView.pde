class DropDownView extends Button {
  String[] options;
  MouseResponder[] responders;
  boolean isExpanded = false;
  
  DropDownView(String startTitle, String[] startOptions, float startXPos, float startYPos, float startViewWidth, float startViewHeight) {
    super(startTitle, startXPos, startYPos, startViewWidth, startViewHeight);
    options = startOptions;
  }
  
  void click() {
    super.click();
    println("Clicked");
    if (!isExpanded) {
      showOptions();
    }else{
      hideOptions();
    }
  }
  
  void showOptions() {
    isExpanded = true;
    for (int i = 0; i < options.length; i++) {
      Button optionBtn = new Button(options[i], 0, viewHeight*(i+1), viewWidth, viewHeight);
      optionBtn.responder = responders[i];
      addChildView(optionBtn);
    }
  }
  
  void hideOptions() {
    isExpanded = false;
    // i = 1 so label is not removed
    for (int i = childViews.size()-1; i > 0; i--) {
      childViews.get(i).removeFromParentView();
    }
  }
  
  void hover() {
    super.hover();
    
  }
  
  
  
  
}
