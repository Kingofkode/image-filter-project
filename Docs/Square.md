The square tool essentially combines aspects of the crop and brush tools. The method used to set up the button and select a region is very similar to the code used for the crop tool. However, instead of changing what image to display after selecting a region, this tool does the following:
```
for (int index = 0; index < imageView.photo.pixels.length; index++) {
  if (index%imageView.photo.width >= xSmaller && index%imageView.photo.width <= xLarger) {
    if (index/imageView.photo.width >= ySmaller && index/imageView.photo.width <= yLarger) {
      imageView.photo.pixels[index] = color(combinedButton.highlightedViewColor);
    }
  }
}
```
This resets the value of every pixel within the rectangular region (determined by the boundaries `xSmaller`, `xLarger`, `ySmaller`, and `yLarger`) to the color `combinedButton.highlightedViewColor`. This color is the same color used by the brush tool.
