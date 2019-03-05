# Filters
Call `applyFilter(:_)` on `ImageView` and pass in one of these constants.

| Filter          | Result           |
| ------------- |:-------------:|
| `MOSAIC`      | ![](https://raw.githubusercontent.com/Kingofkode/image-filter-project/master/Screenshots/Mosaic%20table.png)|
| `EDGES`       | ![](https://raw.githubusercontent.com/Kingofkode/image-filter-project/master/Screenshots/Edges%20Table.png)|
| `NOISE`       | ![](https://raw.githubusercontent.com/Kingofkode/image-filter-project/master/Screenshots/Noise%20Table.png)|

## Functionality
The code for the filters is as follows:

`MOSAIC`
When the Mosaic filter is called, an input for the resolution is provided. This resolution sets the width and height of each square in the mosaic. The image is then resized so the boxes will align with the image; in other words, there will be no incomplete boxes along the edges. The following code is then run: 
```
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
```
This does the following things.
1. The average RGB color value is determined for each box by adding each RGB value to `redTotal`, `blueTotal`, and `greenTotal`, then dividing by the number of pixels in the array.
2. This color is assigned to every pixel in a temporary array.
3. The temporary array is used to recolor the box.

This process is repeated until the entire image has been converted to these boxes.

`EDGES`
When the Edges filter is called, the following code is run for every pixel that is not in the last row:
```
if (i < img.pixels.length - img.width) {
  int pixelBelow = i + img.width;
  compareRed = abs(red(img.pixels[i]) - red(img.pixels[pixelBelow]));
  compareGreen = abs(green(img.pixels[i]) - green(img.pixels[pixelBelow]));
  compareBlue = abs(blue(img.pixels[i]) - blue(img.pixels[pixelBelow]));

  if (compareRed + compareGreen + compareBlue > sensitivity) {
    temp[i] = color(0, 0, 0);
  }
}
```
This determines which pixel is directly beneath the current pixel and compares the RGB values for the two pixels. (This is why the last row is not considered; there are no pixels underneath.) If the total variation between the red, green, and blue values is greater than the sensitivity (set by default to 30), an "edge" is detected due to the change in color, and the pixel is set to black in a temporary array.
The process is repeated using the pixel to the right of the current pixel, ignoring the last column:
```
if (i % img.width != img.width - 1) {
  int pixelRight = i + 1;
  compareRed = abs(red(img.pixels[i]) - red(img.pixels[pixelRight]));
  compareGreen = abs(green(img.pixels[i]) - green(img.pixels[pixelRight]));
  compareBlue = abs(blue(img.pixels[i]) - blue(img.pixels[pixelRight]));
      
  if (compareRed + compareGreen + compareBlue > sensitivity) {
    temp[i] = color(0, 0, 0);
  }
}
```
Finally, if the pixel is not changed by either of these two processes, it is set to white to distinguish it:
```
if (temp[i] != color(0, 0, 0)) {
  temp[i] = color(255, 255, 255);
}
```
At the end, `temp` is used to modify the image's pixels.
