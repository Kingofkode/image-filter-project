# Image Filter Project

## Table of Contents
Click to jump to the corresponding section.
1. [Installation](#installation)
2. [Getting Started with the UI Library](#getting-started-with-the-ui-library)
   1. [Views](#views)
      1. [Creating a View](#creating-a-view)

## Installation
1. Download the master branch
2. Open image-filter-project-master/Main/Main.pde
## Getting Started with the UI Library
### Views
Views are the fundamental building blocks the user interface.
Because view objects are the main way the application interacts with the user, they have a number of responsibilities. Here are just a few:
- Views draw content in their rectangular area

- Layout and child view management

- Views may contain zero or more child views.

- Views can adjust the size and position of their child views.

Views can be nested inside other views to create view hierarchies, which offer a convenient way to organize related content. Nesting a view creates a parent-child relationship between the child view being nested and the parent. A parent view may contain any number of child views but each child view has only one parent view. When a child view’s visible area extends outside of the bounds of its parent view, no clipping of the child view's content occurs. The geometry of each view is defined by its `xPos`, `yPos`, `viewWidth`, and `viewHeight` properties. 

#### Creating a view
The following example creates a 200 x 200 blue view and places its top-left corner at the point (10, 10) in the parent view's coordinate system (once it is added to that parent view). The color was changed to blue in this example. The full list of View's customizable properties can be found [here](Docs/View.md).
```
// Initializes new View object
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
### Button
A button inherits all of the properties of a view with some added functionality. For example, when you hover over it, the button highlights. The following example creates a 100 x 50 button with the title "Import" and places its top-left corner at the point (10, 10) in the parent view's coordinate system. The `highlightedViewColor` was changed to blue in this example. A full list of Button's customizable attributes can be found [here](Docs/Button.md).
```
// Initializes new Button object
final Button myButton = new Button("Import", 10, 10, 100, 50);

// Changes the highlight color to blue
myButton.highlightedViewColor = color(35, 130, 242);

// Adds it to mainView so it is rendered
mainView.addChildView(myButton);
```
![](https://raw.githubusercontent.com/Kingofkode/image-filter-project/master/Screenshots/Button%20Highlight%20v2.gif)
### ImageView
Image views let you efficiently draw any image that can be specified using a `ImageView` object. For example, you can use the `ImageView` class to display the contents of many standard image files, such as JPEG and PNG files. The following example displays a 421 x 258 image of San Francisco loaded from the web and places its top-left corner at the point (10, 10) in the parent view's coordinate system.
```
// Initializes new ImageView object
final ImageView myImageView = new ImageView("https://upload.wikimedia.org/wikipedia/commons/5/5c/San_Francisco%2C_California._June_2017_cropped.jpg", 10, 10, 421, 258);

// Adds it to mainView so it is rendered
mainView.addChildView(myImageView);
```
![](https://raw.githubusercontent.com/Kingofkode/image-filter-project/master/Screenshots/Screen%20Shot%202019-03-02%20at%207.41.14%20AM.png)
The picture presented in the `ImageView` can be changed by accessing its `photoPath` property. The `photoPath` property is a string that represents either an online URL to an image or the name of a locally stored image.
#### Applying filters to ImageView
The following example applies a mosaic filter to the aforementioned ImageView. A full list of available filters can be found [here](Docs/Filters.md).

`myImageView.applyFilter(MOSAIC);`

![](https://raw.githubusercontent.com/Kingofkode/image-filter-project/master/Screenshots/Mosaic.png)

### Undo and Redo Buttons 

### Save Button

### Open Button 

### Brush Toggle

