# View Attributes
## Configuring a View's geometry
`float xPos;`

The view's x-position within its parent's coordinate system.

`float yPos;`

The view's y-position within its parent's coordinate system.

`float viewWidth;`

The view's width.

`float viewHeight`

The view's height.

## Configuring a View’s Visual Appearance
`color viewColor = color(255);`

The view’s background color.

`color borderColor = 0;`

The view’s border color.

`float borderWidth = 0;`

The view’s border thickness.

`float cornderRadius = 0;`

How rounded the view's corners are. Defaults to 0 (no rounding).
## Managing the View Hierarchy
`void addChildView(View)`

Adds a view to the end of the parent’s list of child views.

`void removeFromParentView()`

Removes the view from its parent view.
