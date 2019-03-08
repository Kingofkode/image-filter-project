// Used by undo and redo feature
ArrayList<PImage> images = new ArrayList<PImage>();
int currentImageIndex = 0;
// Used to manage buttons
boolean brushEnabled = false;
boolean squareEnabled = false;
boolean cropEnabled = false;
boolean squareStarted = false;
boolean cropStarted = false;
// Used by crop and rectangle feature to determine where the mouse was first pressed
int xStart, yStart;
// Used by color picker at the bottom of the editor
int redValue = 127;
int greenValue = 127;
int blueValue = 127;
// Used to resize the imported image if necessary
float shrinkRatio1, shrinkRatio2;
// mainView is the window of the program
final View mainView = new View(0,0,0,0);
// The canvas is the place where the image is worked with
final View canvas = new View(0,0,0,0);
// The view that renders the image being worked with
ImageView imageView;
final Button openButton = new Button("Open", 0, 0, 100, 50);
// Filter Buttons
Button mosaicButton, edgesButton, noiseButton;
// Undo Redo Buttons
Button undoButton, redoButton;
// Save button
Button saveButton;
// Brush and square buttons
Button brushButton, squareButton;
// Exit button
Button exitButton;
// Color selector buttons
Button redButton, greenButton, blueButton, combinedButton;
// Crop button
Button cropButton;

void setup () {
  // Calls helper methods to set up the UI
  fullScreen();
  setupMainView();
  setupCanvas();
  setupOpenButton();
  setupFilterButtons();
  setupUndoRedoButtons();
  setupSaveButton();
  setupBrushButton();
  setupSquareButton();
  setupExitButton();
  setupCropButton();
  setupColorButtons();
}
// Helper Methods
void setupMainView() {
  mainView.viewWidth = width;
  mainView.viewHeight = height;
}

void setupCanvas() {
  // Gives the canvas some breathing room
  canvas.viewColor = 100;
  canvas.xPos = 0.05*width;
  canvas.yPos = 0.05*height;
  canvas.viewWidth = 0.9*width;
  canvas.viewHeight = 0.9*height;
  
  mainView.addChildView(canvas);
}

void setupOpenButton() {
  // Adjust dimensions to accommodate all resolutions
  openButton.viewWidth = canvas.viewWidth/16;
  openButton.viewHeight = canvas.viewHeight/16;
  
  openButton.xPos = canvas.viewWidth/2-openButton.viewWidth/2;
  openButton.yPos = canvas.viewHeight/2-openButton.viewHeight/2;
  
 // What code to execute when the open button is pressed.
  openButton.responder = new MouseResponder() {
    public void isClicked() {
      selectInput("Choose Image", "imageSelected");
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  canvas.addChildView(openButton);
}

void imageSelected(File input) {
  if (input == null) {
    print("Error loading image.");
  } else {
    if (imageView != null) {
      imageView.removeFromParentView();
    }
    // Show that the image is loading
    cursor(WAIT);
    PImage image = loadImage(input.getAbsolutePath());
    imageView = new ImageView(input.getAbsolutePath(), 0, 0, 0, 0);
    
    // Resize if necessary
    if (image.width > canvas.viewWidth) {
      shrinkRatio1 = canvas.viewWidth/image.width;
      image.resize((int)(shrinkRatio1 * image.width), (int)(shrinkRatio1 * image.height));
    } else {
      shrinkRatio1 = 1;
    }
    if (image.height > canvas.viewHeight) {
      shrinkRatio2 = canvas.viewHeight/image.height;
      image.resize((int)(shrinkRatio2 * image.width), (int)(shrinkRatio2 * image.height));
    } else {
      shrinkRatio2 = 1;
    }
    
    imageView.viewWidth = image.width;
    imageView.viewHeight = image.height;
    // Center in canvas
    imageView.xPos = (canvas.viewWidth-imageView.viewWidth)/2;
    imageView.yPos = (canvas.viewHeight-imageView.viewHeight)/2;
    canvas.addChildView(imageView);
    openButton.removeFromParentView();
    openButton.xPos = width-mainView.viewWidth/20;
    openButton.yPos = undoButton.viewHeight*3;
    openButton.viewWidth = mainView.viewWidth/20;
    openButton.viewHeight = mainView.viewHeight/16;
    mainView.addChildView(openButton);
    
    imageView.responder = new MouseResponder() {
      public void isClicked() {
        // Manipulate the image depending on what tool is selected
        // Brush tool
        if (brushEnabled) {
          images.subList(currentImageIndex, images.size()).clear();
          images.add(imageView.photo.copy());
          currentImageIndex++;
        }
        // Rectangle Tool
        if (squareEnabled) {
          if (!squareStarted) {
            xStart = mouseX;
            yStart = mouseY;
            squareStarted = !squareStarted;
          } else {
            images.subList(currentImageIndex, images.size()).clear();
            images.add(imageView.photo.copy());
            currentImageIndex++;
            imageView.photo.loadPixels();
            int xLarger, yLarger, xSmaller, ySmaller;
            if (mouseX > xStart) {
              xLarger = int((mouseX - canvas.xPos - imageView.xPos)/(shrinkRatio1*shrinkRatio2));
              xSmaller = int((xStart - canvas.xPos - imageView.xPos)/(shrinkRatio1*shrinkRatio2));
            } else {
              xLarger = int((xStart - canvas.xPos - imageView.xPos)/(shrinkRatio1*shrinkRatio2));
              xSmaller = int((mouseX - canvas.xPos - imageView.xPos)/(shrinkRatio1*shrinkRatio2));
            }
            if (mouseY > yStart) {
              yLarger = int((mouseY - canvas.yPos - imageView.yPos)/(shrinkRatio1*shrinkRatio2));
              ySmaller = int((yStart - canvas.yPos - imageView.yPos)/(shrinkRatio1*shrinkRatio2));
            } else {
              yLarger = int((yStart - canvas.yPos - imageView.yPos)/(shrinkRatio1*shrinkRatio2));
              ySmaller = int((mouseY - canvas.yPos - imageView.yPos)/(shrinkRatio1*shrinkRatio2));
            }
            for (int index = 0; index < imageView.photo.pixels.length; index++) {
              if (index%imageView.photo.width >= xSmaller && index%imageView.photo.width <= xLarger) {
                if (index/imageView.photo.width >= ySmaller && index/imageView.photo.width <= yLarger) {
                  imageView.photo.pixels[index] = color(combinedButton.highlightedViewColor);
                }
              }
            }
            imageView.photo.updatePixels();
            squareStarted = !squareStarted;
          }
        }
        // Crop Tool
        if (cropEnabled) {
          if (!cropStarted) {
            xStart = mouseX;
            yStart = mouseY;
            cropStarted = !cropStarted;
          } else {
            images.subList(currentImageIndex, images.size()).clear();
            images.add(imageView.photo.copy());
            currentImageIndex++;
            imageView.photo.loadPixels();
            int xLarger, yLarger, xSmaller, ySmaller;
            if (mouseX > xStart) {
              xLarger = int((mouseX - canvas.xPos - imageView.xPos)/(shrinkRatio1*shrinkRatio2));
              xSmaller = int((xStart - canvas.xPos - imageView.xPos)/(shrinkRatio1*shrinkRatio2));
            } else {
              xLarger = int((xStart - canvas.xPos - imageView.xPos)/(shrinkRatio1*shrinkRatio2));
              xSmaller = int((mouseX - canvas.xPos - imageView.xPos)/(shrinkRatio1*shrinkRatio2));
            }
            if (mouseY > yStart) {
              yLarger = int((mouseY - canvas.yPos - imageView.yPos)/(shrinkRatio1*shrinkRatio2));
              ySmaller = int((yStart - canvas.yPos - imageView.yPos)/(shrinkRatio1*shrinkRatio2));
            } else {
              yLarger = int((yStart - canvas.yPos - imageView.yPos)/(shrinkRatio1*shrinkRatio2));
              ySmaller = int((mouseY - canvas.yPos - imageView.yPos)/(shrinkRatio1*shrinkRatio2));
            }
            PImage temp = imageView.photo.get(xSmaller, ySmaller, xLarger-xSmaller, yLarger-ySmaller);
            if (temp.width > canvas.viewWidth) {
              shrinkRatio1 = canvas.viewWidth/temp.width;
              temp.resize((int)(shrinkRatio1 * temp.width), (int)(shrinkRatio1 * temp.height));
            } else {
              shrinkRatio1 = 1;
            }
            if (temp.height > canvas.viewHeight) {
              shrinkRatio2 = canvas.viewHeight/temp.height;
              temp.resize((int)(shrinkRatio2 * temp.width), (int)(shrinkRatio2 * temp.height));
            } else {
              shrinkRatio2 = 1;
            }
            imageView.photo = temp;
            imageView.viewWidth = temp.width;
            imageView.viewHeight = temp.height;
            // Center in canvas
            imageView.xPos = (canvas.viewWidth-imageView.viewWidth)/2;
            imageView.yPos = (canvas.viewHeight-imageView.viewHeight)/2;
            cropStarted = !cropStarted;
          }
        }
      }
      public void isHovering() {}
      public void buttonDown(Mouse button) {
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
      }
    };
  }
  // Hide loading indicator
  cursor(ARROW);
  brushEnabled = false;
  brushButton.isStuck = false;
  squareEnabled = false;
  squareButton.isStuck = false;
  squareStarted = false;
  cropEnabled = false;
  cropButton.isStuck = false;
  cropStarted = false;
}

void setupFilterButtons() {
  // Mosaic Button
  mosaicButton = new Button("Mosaic", 0, 0, mainView.viewWidth/20, mainView.viewHeight/16);
  mosaicButton.responder = new MouseResponder() {
    public void isClicked() {
      images.subList(currentImageIndex, images.size()).clear();
      images.add(imageView.photo.copy());
      currentImageIndex++;
      imageView.applyFilter(MOSAIC);
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  mainView.addChildView(mosaicButton);
  // Edges Button
  edgesButton = new Button("Edges", 0, mosaicButton.viewHeight, mainView.viewWidth/20, mainView.viewHeight/16);
  edgesButton.responder = new MouseResponder() {
    public void isClicked() {
      images.subList(currentImageIndex, images.size()).clear();
      images.add(imageView.photo.copy());
      currentImageIndex++;
      imageView.applyFilter(EDGES);
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  mainView.addChildView(edgesButton);
  
  // Noise Button
  noiseButton = new Button("Noise", 0, mosaicButton.viewHeight*2, mainView.viewWidth/20, mainView.viewHeight/16);
  noiseButton.responder = new MouseResponder() {
    public void isClicked() {
      images.subList(currentImageIndex, images.size()).clear();
      images.add(imageView.photo.copy());
      currentImageIndex++;
      imageView.applyFilter(NOISE);
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  mainView.addChildView(noiseButton);
}
void setupUndoRedoButtons() {
  // Undo Button
  undoButton = new Button("Undo", width-mainView.viewWidth/20, 0, mainView.viewWidth/20, mainView.viewHeight/16);
  undoButton.responder = new MouseResponder() {
    public void isClicked() {
      if (currentImageIndex > 0) {
        if (currentImageIndex == images.size()) {
          images.add(imageView.photo.copy());
        }
        imageView.photo = images.get(currentImageIndex-1);

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
        
        currentImageIndex--;
      }
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  mainView.addChildView(undoButton);
  // Redo Button
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
  mainView.addChildView(redoButton);
}

void setupSaveButton() {
  saveButton = new Button("Save", width-mainView.viewWidth/20, undoButton.viewHeight*2, mainView.viewWidth/20, mainView.viewHeight/16);
  
  saveButton.responder = new MouseResponder() {
    public void isClicked() {
      if (imageView.photo != null) {
        selectOutput("Save Image", "saveFile");
      }
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  mainView.addChildView(saveButton);
}

void saveFile(File output) {
  if (output != null) {
    // Save photo to specified destination when "Save" button is pressed.
    imageView.photo.save(output.getAbsolutePath());
  }
}

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
        // Change curser to brush
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

void setupExitButton() {
  exitButton = new Button("Exit", width-mainView.viewWidth/20, undoButton.viewHeight*4, mainView.viewWidth/20, mainView.viewHeight/16);
  exitButton.responder = new MouseResponder() {
    public void isClicked() {
      exit();
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  mainView.addChildView(exitButton);
}

void setupSquareButton() {
  squareButton = new Button("Square", 0, mosaicButton.viewHeight*5, mainView.viewWidth/20, mainView.viewHeight/16);
  squareButton.responder = new MouseResponder() {
    public void isClicked() {
      if (brushEnabled) {
        brushButton.isStuck = !brushButton.isStuck;
        brushEnabled = brushButton.isStuck;
        cursor(ARROW);
      }
      if (cropEnabled) {
        cropButton.isStuck = !cropButton.isStuck;
        cropEnabled = cropButton.isStuck;
      }
      squareButton.isStuck = !squareButton.isStuck;
      squareEnabled = squareButton.isStuck;
      squareStarted = false;
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  mainView.addChildView(squareButton);
}
// Color picker at the bottom of the editor
void setupColorButtons() {
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
  
  greenButton = new Button("Green: " + greenValue, 9*mainView.viewWidth/20, height-mainView.viewHeight/20, mainView.viewWidth/20, mainView.viewHeight/20);
  greenButton.highlightedViewColor = color(0, greenValue, 0);
  greenButton.isStuck = true;
  greenButton.responder = new MouseResponder() {
    public void isClicked() {}
    public void isHovering() {}
    public void buttonDown(Mouse button) {
      if (mouseButton == LEFT && greenValue > 0) greenValue--;
      if (mouseButton == RIGHT && greenValue < 255) greenValue++;
      greenButton.highlightedViewColor = color(0, greenValue, 0);
      greenButton.titleLabel.title = "Green: " + greenValue;
      updateCombinedButton();
    }
  };
  mainView.addChildView(greenButton);
  
  blueButton = new Button("Blue: " + blueValue, 10*mainView.viewWidth/20, height-mainView.viewHeight/20, mainView.viewWidth/20, mainView.viewHeight/20);
  blueButton.highlightedViewColor = color(0, 0, blueValue);
  blueButton.isStuck = true;
  blueButton.responder = new MouseResponder() {
    public void isClicked() {}
    public void isHovering() {}
    public void buttonDown(Mouse button) {
      if (mouseButton == LEFT && blueValue > 0) blueValue--;
      if (mouseButton == RIGHT && blueValue < 255) blueValue++;
      blueButton.highlightedViewColor = color(0, 0, blueValue);
      blueButton.titleLabel.title = "Blue: " + blueValue;
      updateCombinedButton();
    }
  };
  mainView.addChildView(blueButton);
  
  combinedButton = new Button("Color", 11*mainView.viewWidth/20, height-mainView.viewHeight/20, mainView.viewWidth/20, mainView.viewHeight/20);
  combinedButton.isStuck = true;
  updateCombinedButton();
  mainView.addChildView(combinedButton);
}

void updateCombinedButton() {
  // Preview color
  combinedButton.highlightedViewColor = color(redValue, greenValue, blueValue);
}

void setupCropButton() {
  cropButton = new Button("Crop", 0, mosaicButton.viewHeight*6, mainView.viewWidth/20, mainView.viewHeight/16);
  cropButton.responder = new MouseResponder() {
    public void isClicked() {
      if (brushEnabled) {
        brushButton.isStuck = !brushButton.isStuck;
        brushEnabled = brushButton.isStuck;
        cursor(ARROW);
      }
      if (squareEnabled) {
        squareButton.isStuck = !squareButton.isStuck;
        squareEnabled = squareButton.isStuck;
      }
      cropButton.isStuck = !cropButton.isStuck;
      cropEnabled = cropButton.isStuck;
      cropStarted = false;
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  mainView.addChildView(cropButton);
}
