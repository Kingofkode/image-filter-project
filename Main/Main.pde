// Model

//
final View mainView = new View(0,0,0,0);
final View canvas = new View(0,0,0,0);
ImageView imageView;
final Button importButton = new Button("Import", 0, 0, 100, 50);

void setup () {
  fullScreen();
  setupMainView();
  setupCanvas();
  setupImportButton();
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
  // Adjust font to accommodate all resolutions
  importButton.titleLabel.fontSize = importButton.titleLabel.fontSize * width/1000;
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
