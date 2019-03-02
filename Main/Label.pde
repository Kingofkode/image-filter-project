class Label extends View {
  String title;
  int fontSize = 12;
  int alignment = LEFT;
  float textHeight;
  float textWidth;
  Label(String startTitle, float startXPos, float startYPos) {
    super(startXPos, startYPos);
    title = startTitle;
  }
  
  void render() {
    super.render();
    fill(viewColor);
    textAlign(alignment);
    PFont f = createFont("Arial",fontSize,true);
    textFont(f,fontSize);
    // FUCK this one. IT DOESNT WORK EVER
    textHeight = textAscent() + textDescent();
    textWidth = textWidth(title);
    text(title, getSuperXPos(),getSuperYPos());
    
  }
}
