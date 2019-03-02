int MOSAIC = 0;
int EDGES = 1;
int NOISE = 2;

// Mosaic Filter by Luke Estes
PImage applyMosaicFilter(PImage img) {
  int resolution = 10;
  color[] temp = new color[resolution*resolution];
  
  int xScale = img.width / resolution;
  int yScale = img.height / resolution;
  img.resize(xScale*resolution, yScale*resolution);
  
  img.loadPixels();
  
  for (int row = 0; row < img.height; row = row+resolution) {
    for (int column = 0; column < img.width; column = column+resolution) {
      float redTotal = 0;
      float greenTotal = 0;
      float blueTotal = 0;
      
      for (int rowWithinBox = 0; rowWithinBox < resolution; rowWithinBox++) {
        for (int columnWithinBox = 0; columnWithinBox < resolution; columnWithinBox++) {
          temp[rowWithinBox*resolution + columnWithinBox] = img.pixels[(row+rowWithinBox)*img.width + column + columnWithinBox];
          redTotal = redTotal + red(temp[rowWithinBox*resolution + columnWithinBox]);
          greenTotal = greenTotal + green(temp[rowWithinBox*resolution + columnWithinBox]);
          blueTotal = blueTotal + blue(temp[rowWithinBox*resolution + columnWithinBox]);
        }
      }
      
      color colorAverage = color(redTotal/(resolution*resolution), greenTotal/(resolution*resolution), blueTotal/(resolution*resolution));
      
      for (int tempValue = 0; tempValue < resolution*resolution; tempValue++) {
        temp[tempValue] = colorAverage;
      }
      
      for (int rowWithinBox = 0; rowWithinBox < resolution; rowWithinBox++) {
        for (int columnWithinBox = 0; columnWithinBox < resolution; columnWithinBox++) {
          img.pixels[(row+rowWithinBox)*img.width + column + columnWithinBox] = temp[rowWithinBox*resolution + columnWithinBox];
        }
      }
    }
  }
  
  img.updatePixels();
  return img;
}
// Edges filter by Luke Estes
PImage applyEdgesFilter(PImage img) {
  color[] temp = new color[img.pixels.length];
  img.loadPixels();
  int sensitivity = 30;
  float compareRed, compareGreen, compareBlue;
  
  for (int i = 0; i < img.pixels.length; i++) {
    if (i < img.pixels.length - img.width) {
      int pixelBelow = i + img.width;
      compareRed = abs(red(img.pixels[i]) - red(img.pixels[pixelBelow]));
      compareGreen = abs(green(img.pixels[i]) - green(img.pixels[pixelBelow]));
      compareBlue = abs(blue(img.pixels[i]) - blue(img.pixels[pixelBelow]));
      
      if (compareRed + compareGreen + compareBlue > sensitivity) {
        temp[i] = color(0, 0, 0);
      }
    }
    
    if (i % img.width != img.width - 1) {
      int pixelRight = i + 1;
      compareRed = abs(red(img.pixels[i]) - red(img.pixels[pixelRight]));
      compareGreen = abs(green(img.pixels[i]) - green(img.pixels[pixelRight]));
      compareBlue = abs(blue(img.pixels[i]) - blue(img.pixels[pixelRight]));
      
      if (compareRed + compareGreen + compareBlue > sensitivity) {
        temp[i] = color(0, 0, 0);
      }
    }
      
    if (temp[i] != color(0, 0, 0)) {
      temp[i] = color(255, 255, 255);
    }
    
  }
  
  for (int i = 0; i < img.pixels.length; i++) {
    img.pixels[i] = temp[i];
  }
  
  img.updatePixels();
  return img;
}

PImage applyNoiseFilter(PImage img) {
  return img;
}
