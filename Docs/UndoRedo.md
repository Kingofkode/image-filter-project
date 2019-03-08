// Undo Redo Buttons
Button undoButton, redoButton;

The above code displays the initialization of both the undo and redo buttons utilizing the class developed for buttons (detailed within the section “Buttons”). 

setupUndoRedoButtons();

This line is then included within the void setup loop. The code here calls the void setupUndoRedoButtons loop also included within the code. 

 undoButton = new Button("Undo", width-mainView.viewWidth/20, 0, mainView.viewWidth/20, mainView.viewHeight/16);
  undoButton.responder = new MouseResponder() {
    public void isClicked() {
      if (currentImageIndex > 0) {
        if (currentImageIndex == images.size()) {
          images.add(imageView.photo.copy());
        }
        imageView.photo = images.get(currentImageIndex-1);
        currentImageIndex--;
      }
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  }

The void setupUndoRedoButtons loop contains the code which effectively enables the undo and redo functionality. The above lines of code display that which is utilized in order to construct the undo button. First of all, the button itself is created utilizing the proper formatting for the button class. In this case the parameters for the button created are “Undo” as the title name, “width-mainView.viewWidth/20” for the starting x position and 0 as the starting y position. Additionally, “mainView.viewWidth/20” is utilized in order to represent the button’s width and “mainView.viewHeight/16” to represent the height. 

The following line of code uses the mouse responder interface (developed within “View Interaction”) in order to plan exactly what will occur when the undo button is selected by the user. The following lines of code show that when the button is clicked an if statement is utilized in order to determine whether the image is stored as an index greater than zero. Zero is excluded because that index value would simply represent the original image. Following this, the previous state of the image is selected by creating a view which is stored in the position ‘currentImageIndex-1’. Finally, the statement ‘public void isHovering() {}’ checks to see if the mouse is positioned above the button, if this is indeed the case the button is filled black and the interior text becomes white. 

Next, the redo button is constructed. The concept driving the functionality of this button is rather simple considering that it is essentially the opposite of the undo button. The code below is what is used to manage this particular tool. 

  redoButton = new Button("Redo", width-mainView.viewWidth/20, undoButton.viewHeight, mainView.viewWidth/20, mainView.viewHeight/16);
  redoButton.responder = new MouseResponder() {
    public void isClicked() {
      if (currentImageIndex < images.size()-1) {
        imageView.photo = images.get(currentImageIndex+1);
        
        if (imageView.photo.width > canvas.viewWidth) {
          shrinkRatio1 = canvas.viewWidth/imageView.photo.width;
          imageView.photo.resize((int)(shrinkRatio1 * imageView.photo.width), (int)(shrinkRatio1 * imageView.photo.height));
        } else {
          shrinkRatio1 = 1;
        }
        if (imageView.photo.height > canvas.viewHeight) {
          shrinkRatio2 = canvas.viewHeight/imageView.photo.height;
          imageView.photo.resize((int)(shrinkRatio2 * imageView.photo.width), (int)(shrinkRatio2 * imageView.photo.height));
        } else {
          shrinkRatio2 = 1;
        }
        
        imageView.viewWidth = imageView.photo.width;
        imageView.viewHeight = imageView.photo.height;
        // Center in canvas
        imageView.xPos = (canvas.viewWidth-imageView.viewWidth)/2;
        imageView.yPos = (canvas.viewHeight-imageView.viewHeight)/2;
        
        currentImageIndex++;
      }
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };

As with the redo button the first line contains the parameters to be used within the button class. The only major difference here is that the distance of this button from the top of the screen is given as ‘undoButton.viewHeight’. This positions the button directly below the undo button. Following this, the responder is utilized in order to select the image from an index value which is one greater than the current index. 

Next, a resize function is included in order to ensure that the image is properly resized in order to fit within the canvas area. This process would regularly be followed if the user opens an image within the program. It is used in the redo button because the user could have opened a new image and then undid changes thus taking them to a prior image. If they decided they wanted to return to the new image which they uploaded, the image must be resized once more when it is displayed again. 

Finally, the index is increased by a value of 1 in order to represent the new position, and ‘public void isHovering() {}’ is called once more in order to shade the button when the mouse is moved over it.  
