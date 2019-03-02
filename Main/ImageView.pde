class ImageView extends View {
  String photoPath;
  PImage photo;
  
  ImageView(String startPhotoPath, float startXPos, float startYPos, float startViewWidth, float startViewHeight) {
    super(startXPos, startYPos, startViewWidth, startViewHeight);
    photoPath = startPhotoPath;
    photo = loadImage(photoPath);
  }
  
  void render() {
    image(photo, getSuperXPos(), getSuperYPos(), viewWidth, viewHeight);
  }
  
  void applyFilter(int filter) {
    if (filter == MOSAIC) {
      photo = applyMosaicFilter(photo);
    }
    if (filter == EDGES) {
      photo = applyEdgesFilter(photo);
    }
    if (filter == NOISE) {
      photo = applyNoiseFilter(photo);
    }
  }
  
}
