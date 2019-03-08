The brush button is a simple toggle button similar to the buttons seen elsewhere. However, the code to apply the effect is actually placed inside `imageView.responder` so that the image will change when it is clicked directly. The code is as follows:
```
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
```
While this may look intimidating, its operation is fairly straightforward. The first part - if `!cropStarted` is true - simply stores the coordinates of the mouse click at the first position. The second part is for the second click. First, the current image is added to `images[]` so the work can be undone if desired. After the pixels are then loaded, the series of if/else statements determines which of the two clicks produced the lower x-value and which produced the lower y-value. This allows the program to properly determine the boundaries of the rectangular region selected, and it converts these values to pixel locations in the image. After that, `temp` is used to obtain the pixels from the selected area. The final lines of code resize the image, much as is done when an image is first loaded, and the image is added to `imageView` so it can be displayed.
