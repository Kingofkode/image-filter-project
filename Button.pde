class Button {
  float xPos, yPos;
  String title;
  // Inititalizer
  Button (int xPosition, int yPosition, String buttonTitle) {
    xPos = xPosition;
    yPos = yPosition;
    title = buttonTitle;
    drawButton();
    
  }
  
  void drawButton() {
    fill(255);
    rect(xPos, yPos, 130, 40, 10);
    fill(55);
    text(title, xPos+15, yPos+25);
  }
  
}
