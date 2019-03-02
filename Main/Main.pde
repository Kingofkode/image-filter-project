//Model
ArrayList<PImage> images = new ArrayList<PImage>();
int currentImageIndex = 0;
// UI Components
final View mainView = new View(0,0,0,0);
final View canvas = new View(0,0,0,0);
ImageView imageView;
final Button importButton = new Button("Import", 0, 0, 100, 50);
// Filter Buttons
Button mosaicButton, edgesButton, noiseButton;
// Undo Redo Buttons
Button undoButton, redoButton;
void setup () {
  fullScreen();
  setupMainView();
  setupCanvas();
  setupImportButton();
  setupFilterButtons();
  setupUndoRedoButtons();
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

void setupImportButton() {
  // Adjust dimensions to accommodate all resolutions
  importButton.viewWidth = canvas.viewWidth/16;
  importButton.viewHeight = canvas.viewHeight/16;
  
  importButton.xPos = canvas.viewWidth/2-importButton.viewWidth/2;
  importButton.yPos = canvas.viewHeight/2-importButton.viewHeight/2;
  
 
  importButton.responder = new MouseResponder() {
    public void isClicked() {
      selectInput("Choose Image", "imageSelected");
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  canvas.addChildView(importButton);
}

void imageSelected(File input) {
  if (input == null) {
    print("Error loading image.");
    // Display error message
  } else {
    PImage image = loadImage(input.getAbsolutePath());
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
    importButton.removeFromParentView();
  }
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
  undoButton = new Button("Undo", width-mainView.viewWidth/20, 0, mainView.viewWidth/20, mainView.viewHeight/16);
  undoButton.responder = new MouseResponder() {
    public void isClicked() {
      if (currentImageIndex > 0) {
        imageView.photo = images.get(currentImageIndex-1);
        currentImageIndex--;
      }
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  mainView.addChildView(undoButton);
}
