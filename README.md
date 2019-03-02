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
The following example creates a 600 x 400 view and places its top-left corner at the point (0, 0) in the parent view's coordinate system (once it is added to that parent view).
```
View mainView = new View(0,0,600,400);

```
To add a child view to another view, call the `addChildView(_:)` method on the parent view. Each call to the `addChildView(_:)` method places the new view on top of all other siblings.

See the full list of customizable properties [here](View.md)







