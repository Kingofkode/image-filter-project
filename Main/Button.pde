class Button extends View {
  String title;
  color highlightedTitleColor = 255;
  color highlightedViewColor = 0;
  Label titleLabel;
  
  Button(String startTitle, float startXPos, float startYPos, float startViewWidth, float startViewHeight) {
    super(startXPos, startYPos, startViewWidth, startViewHeight);
    title = startTitle;
    titleLabel = new Label(title, 0, 0);
    println(titleLabel.textHeight);
    titleLabel.viewColor = 0;
    addChildView(titleLabel);
    borderWidth = 1;
    //cornerRadius = 7;
  }
  
  void hover() {
    super.hover();
    
    
  }
  
  void render() {
    super.render();
    // Self sizing
    //viewWidth = titleLabel.textWidth+10;
    //viewHeight = titleLabel.textHeight+10;
    
    // Center label (glitches momentarily only works with one line of text)
    titleLabel.yPos = viewHeight/2 + titleLabel.textHeight/3;
    titleLabel.xPos = viewWidth/2 - titleLabel.textWidth/2;
    
    if (containsMouse()) {
      viewColor = highlightedViewColor;
      titleLabel.viewColor = highlightedTitleColor;
    }else{
      viewColor = 255;
      titleLabel.viewColor = 0;
    }
  }
  
}
