class Button extends View {
  String title;
  color highlightedTitleColor = 255;
  color highlightedViewColor = 0;
  Label titleLabel;
  boolean isStuck = false;
  
  Button(String startTitle, float startXPos, float startYPos, float startViewWidth, float startViewHeight) {
    super(startXPos, startYPos, startViewWidth, startViewHeight);
    title = startTitle;
    titleLabel = new Label(title, 0, 0);
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
    // Center label (glitches momentarily only works with one line of text)
    titleLabel.yPos = viewHeight/2 + titleLabel.textHeight/3;
    titleLabel.xPos = viewWidth/2 - titleLabel.textWidth/2;
    if (!isStuck) {      
      if (containsMouse()) {
        highlight();
      }else{
        viewColor = 255;
        titleLabel.viewColor = 0;
      }
    } else {
      highlight();
    }
  }
  
  void highlight() {
    viewColor = highlightedViewColor;
    titleLabel.viewColor = highlightedTitleColor;
  }
  
}
