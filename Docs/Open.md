When the program is first run, the open button appears in the middle of the screen. However, immediately after the user uploads their selected image, the open button disappears from the canvas and is inserted on the right sidebar below the save button, but above the exit button. 
```
void setupOpenButton() {
  // Adjust dimensions to accommodate all resolutions
  openButton.viewWidth = canvas.viewWidth/16;
  openButton.viewHeight = canvas.viewHeight/16;
  
  openButton.xPos = canvas.viewWidth/2-openButton.viewWidth/2;
  openButton.yPos = canvas.viewHeight/2-openButton.viewHeight/2;
  
 
  openButton.responder = new MouseResponder() {
    public void isClicked() {
      selectInput("Choose Image", "imageSelected");
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  canvas.addChildView(openButton);
}
```
The above code is utilized in order to create the open button. The third and fourth lines are utilized in order to produce the correct dimensions at any level of resolution. This is done by setting the dimensions of the open button to each of the dimensions of the canvas divided by a value of 16. Next, in lines 5 and 6 the button is centered in the canvas. This is done by subtracting the canvas height and width divided by two by the button height and width divided by two. The results for the height and width are then utilized as the button’s x and y positions (respectfully). At this point, the responder is then called so that if the button is clicked, a separate page displaying accessible files on the user’s computer appears. Additionally, hovering over this button causes it to be shaded black while the text becomes white. 

