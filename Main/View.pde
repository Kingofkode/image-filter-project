class View {
  // View that contains this view
  View parentView;
  // Views that this view contains
  ArrayList<View> childViews = new ArrayList<View>();
  // Coordinates
  float xPos, yPos, viewWidth, viewHeight;
  float cornerRadius = 0;
  float borderWidth = 0;
  color borderColor = 0;
  // Default color is white
  color viewColor = color(255);
  // For mouse interactions
  MouseDelegate delegate;
  
  // For labels
  View(float startXPos, float startYPos) {
    xPos = startXPos;
    yPos = startYPos;
  }
  // For general purpose views
  View(float startXPos, float startYPos, float startViewWidth, float startViewHeight) {
    xPos = startXPos;
    yPos = startYPos;
    viewWidth = startViewWidth;
    viewHeight = startViewHeight;
  }
  
  void render() {
    strokeWeight(borderWidth);
    if (borderWidth > 0) {
      stroke(borderColor);
    }else{
      noStroke();
    }
    fill(viewColor);
    rect(getSuperXPos(), getSuperYPos(), viewWidth, viewHeight, cornerRadius);
    renderChildViews();
  }
  
  void addChildView(View view) {
    view.parentView = this;
    childViews.add(view);
  }
  
  void removeFromParentView() {
    if (parentView != null)
      for (int i = 0; i < parentView.childViews.size(); i++) {
        View view = parentView.childViews.get(i);
        if (view == this) {
          parentView.childViews.remove(i);
          parentView = null;
          break;
        }
      }
  }
    
  void renderChildViews() {
      for (int i = 0; i < childViews.size(); i++) {
      childViews.get(i).render();
    }
  }
  // Converts local x-position to global x-position
  float getSuperXPos() {
    float currentXPos = xPos;
    View currentView = parentView;
    
    while (currentView != null) {
      currentXPos += currentView.xPos;
      currentView = currentView.parentView;
    }
    
    return currentXPos;
  }
  // Converts local y-position to global y-position
  float getSuperYPos() {
    float currentYPos = yPos;
    View currentView = parentView;
    
    while (currentView != null) {
      currentYPos += currentView.yPos;
      currentView = currentView.parentView;
    }
    
    return currentYPos;
  }
  
  boolean containsMouse() {
    if (mouseX>getSuperXPos() && mouseX<(getSuperXPos()+viewWidth) && mouseY>getSuperYPos() && mouseY<(getSuperYPos()+viewHeight)) {
      return true;
    }
    return false;
  }
  
  View getTopChildViewThatContainsMouse() {
    // The first view to contain the mouse is returned
    for (int i = childViews.size()-1; i >= 0; i--) {
      View view = childViews.get(i);
      if (view.containsMouse()) {
          return view;
        }
      }
      return null;
  }

  // These methods can be overriden to perform UI related tasks such as highlighting when the mouse is hovering
  void click() {
    delegate.isClicked();
  }
  
  void hover() {
    delegate.isHovering();
  }
  
  void leftButtonDown() {
    delegate.buttonDown(Mouse.LeftButton);
  }
  
  void rightButtonDown() {
    delegate.buttonDown(Mouse.RightButton);
  }
  
}
