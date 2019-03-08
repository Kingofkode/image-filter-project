The brush tool has four main sections of code associated with it. The first section is the part which draws the button:
```
void setupBrushButton() {
  brushButton = new Button("Brush", 0, mosaicButton.viewHeight*4, mainView.viewWidth/20, mainView.viewHeight/16);
  brushButton.responder = new MouseResponder() {
    public void isClicked() {
      if (squareEnabled) {
        squareButton.isStuck = !squareButton.isStuck;
        squareEnabled = squareButton.isStuck;
      }
      if (cropEnabled) {
        cropButton.isStuck = !cropButton.isStuck;
        cropEnabled = cropButton.isStuck;
      }
      brushButton.isStuck = !brushButton.isStuck;
      brushEnabled = brushButton.isStuck;
      if (brushEnabled) {
        PImage brushImage = loadImage("artistic-brush.png");
        brushImage.resize(32, 32);
        cursor(brushImage);
      }else{
        cursor(ARROW);
      }
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  mainView.addChildView(brushButton);
}
```
This adds the button using the standard method, turns all of the other tools off, changes the cursor to a brush, and changes the variables `brushButton.isStuck` and `brushEnabled` in order to keep the button toggled on and allow the brush to edit the image, respectively. (If these variables are already on, they are turned off instead.) The other tools apply a similar methodology for their buttons.  
The second section of code falls under `imageView.responder` for when the mouse is clicked:
```
        if (brushEnabled) {
          images.subList(currentImageIndex, images.size()).clear();
          images.add(imageView.photo.copy());
          currentImageIndex++;
        }
```
This simply adds the current image to the list of images for undo/redo functionality.  
The third section of code applies to the image when the mouse is pressed (not just clicked):
```
       if (brushEnabled) {
          imageView.photo.loadPixels();
          int pixelX = int((mouseX - canvas.xPos - imageView.xPos)/(shrinkRatio1*shrinkRatio2));
          int pixelY = int((mouseY - canvas.yPos - imageView.yPos)/(shrinkRatio1*shrinkRatio2));
          for (int index = 0; index < imageView.photo.pixels.length; index++) {
            if (index%imageView.photo.width >= pixelX-int(5/(shrinkRatio1*shrinkRatio2)) && index%imageView.photo.width <= pixelX+int(5/(shrinkRatio1*shrinkRatio2))) {
              if (index/imageView.photo.width >= pixelY-int(5/(shrinkRatio1*shrinkRatio2)) && index/imageView.photo.width <= pixelY+int(5/(shrinkRatio1*shrinkRatio2))) {
                imageView.photo.pixels[index] = color(combinedButton.highlightedViewColor);
              }
            }
          }          
          imageView.photo.updatePixels();
        }
```
This does the following: First, the image loads the array of pixels and determines the x-position and y-position of the mouse relative to the grid of pixels (i.e. what row and column of pixels it is currently over). Second, the program scans every pixel to determine if it is within a certain distance of the cursor's position. The `shrinkRatio1*shrinkRatio2` part scales the area so that resized pictures don't appear to have narrower lines on the screen. Finally, the image's pixels are updated, creating a new dot on the image. A series of these dots strung together creates the appearance of a line.  
The fourth section of code pertaining to the brush regards the brush's color. (It also adjusts the square tool's color as well.) The three RGB buttons at the bottom are created using similar code, so for the sake of simplicity, only one button will be explained here:
```
  redButton = new Button("Red: " + redValue, 8*mainView.viewWidth/20, height-mainView.viewHeight/20, mainView.viewWidth/20, mainView.viewHeight/20);
  redButton.highlightedViewColor = color(redValue, 0, 0);
  redButton.isStuck = true;
  redButton.responder = new MouseResponder() {
    public void isClicked() {}
    public void isHovering() {}
    public void buttonDown(Mouse button) {
      if (mouseButton == LEFT && redValue > 0) redValue--;
      if (mouseButton == RIGHT && redValue < 255) redValue++;
      redButton.highlightedViewColor = color(redValue, 0, 0);
      redButton.titleLabel.title = "Red: " + redValue;
      updateCombinedButton();
    }
  };
  mainView.addChildView(redButton);
```
This creates a button for red values that displays the current red value being applied. If a mouse button is pressed over it, the program checks if it is the left or right button and decreases or increases the value, respectively (assuming the values will not exceed the minimum or maximum accepted values.) It also makes sure to update the label so the correct value is displayed. The variable `redValue`, along with its corresponding variables `greenValue` and `blueValue`, are combined in the final button, called `combinedButton`, which displays the actual color being used. To obtain this color, the code for the brush calls for `combinedButton.highlightedButtonColor`, as can be seen above.
