# Image Filter Project

## Installation
1. Download the master branch
2. Ensure downloaded folder is named "Main"
3. Open Main.pde
## Getting started with the UI Library
### Views
Views are the fundamental building blocks the user interface.
Because view objects are the main way the application interacts with the user, they have a number of responsibilities. Here are just a few:
- Views draw content in their rectangular area

- Layout and child view management

- Views may contain zero or more child views.

- Views can adjust the size and position of their child views.

Views can be nested inside other views to create view hierarchies, which offer a convenient way to organize related content. Nesting a view creates a parent-child relationship between the child view being nested and the parent. A parent view may contain any number of child views but each child view has only one parent view. When a child view’s visible area extends outside of the bounds of its parent view, no clipping of the child view's content occurs. The geometry of each view is defined by its `xPos`, `yPos`, `viewWidth`, and `viewHeight` properties. 

#### Creating a view
The following example creates a 200 x 200 blue view and places its top-left corner at the point (10, 10) in the parent view's coordinate system (once it is added to that parent view). The color was changed to blue in this example. The full list of a View's customizable properties can be found [here](View.md)
```
// Initializes new view object
final View blueView = new View(10, 10, 200, 200);

// Sets background color to blue
blueView.viewColor = color(133, 205, 246);

// Adds blueView to mainView so it is rendered
mainView.addChildView(blueView);

```
![](https://raw.githubusercontent.com/Kingofkode/image-filter-project/master/Screenshots/Screen%20Shot%202019-03-01%20at%208.49.43%20PM.png)
### Mouse event handling
The following example modifies the view width when the view is clicked on.
```
 blueView.responder = new MouseResponder() {
    public void isClicked() {
    // Increases view width to 400 when it is clicked on
      blueView.viewWidth = 400;
    }
    
    // All 3 methods must be present even if they are not used
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
```
![](https://raw.githubusercontent.com/Kingofkode/image-filter-project/master/Screenshots/Click.gif)






