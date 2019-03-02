//Model
ArrayList<PImage> images = new ArrayList<PImage>();
int currentImageIndex = 0;
boolean brushEnabled = false;
// UI Components
final View mainView = new View(0,0,0,0);
final View canvas = new View(0,0,0,0);
ImageView imageView;
final Button openButton = new Button("Open", 0, 0, 100, 50);
// Filter Buttons
Button mosaicButton, edgesButton, noiseButton;
// Undo Redo Buttons
Button undoButton, redoButton;
// Save button
Button saveButton;
// Brush button
Button brushButton;

void setup () {
  fullScreen();
  setupMainView();
  setupCanvas();
  setupOpenButton();
  setupFilterButtons();
  setupUndoRedoButtons();
  setupSaveButton();
  setupBrushButton();
}

void setupMainView() {
  mainView.viewWidth = width;
  mainView.viewHeight = height;
}

void setupCanvas() {
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
    // Display error message
  } else {
    PImage image = loadImage(input.getAbsolutePath());
    if (imageView != null) {
      imageView.removeFromParentView();
    }
    imageView = new ImageView(input.getAbsolutePath(), 0, 0, 0, 0);
    
    // Resize if necessary
    float shrinkRatio;
    if (image.width > canvas.viewWidth) {
      shrinkRatio = canvas.viewWidth/image.width;
      image.resize((int)(shrinkRatio * image.width), (int)(shrinkRatio * image.height));
    }
    if (image.height > canvas.viewHeight) {
      shrinkRatio = canvas.viewHeight/image.height;
      image.resize((int)(shrinkRatio * image.width), (int)(shrinkRatio * image.height));
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
  }
}

void setupFilterButtons() {
  // Mosaic Button
  mosaicButton = new Button("Mosaic", 0, 0, mainView.viewWidth/20, mainView.viewHeight/16);
  mosaicButton.responder = new MouseResponder() {
    public void isClicked() {
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
        selectOutput("Save file", "saveFile");
      }
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  mainView.addChildView(saveButton);
}

void saveFile(File output) {
  if (output != null) {
    imageView.photo.save(output.getAbsolutePath());
  }
}

void setupBrushButton() {
  brushButton = new Button("Brush", 0, mosaicButton.viewHeight*4, mainView.viewWidth/20, mainView.viewHeight/16);
  brushButton.responder = new MouseResponder() {
    public void isClicked() {
      brushButton.isStuck = !brushButton.isStuck;
      brushEnabled = brushButton.isStuck;
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  mainView.addChildView(brushButton);
}
