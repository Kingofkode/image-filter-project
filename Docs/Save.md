``` 
void setupSaveButton() {
  saveButton = new Button("Save", width-mainView.viewWidth/20, undoButton.viewHeight*2, mainView.viewWidth/20, mainView.viewHeight/16);
  saveButton.responder = new MouseResponder() {
    public void isClicked() {
      if (imageView.photo != null) {
        selectOutput("Save Image", "saveFile");
      }
    }
    public void isHovering() {}
    public void buttonDown(Mouse button) {}
  };
  mainView.addChildView(saveButton);
}
```
The above code sets up the save button. The second line utilizes the button’s class structure and takes the appropriate parameters. Of the said parameters, all are the same as those for undo and redo buttons except for the name (of course) and the distance below the top of the screen. The save button is located below the redo button thus making its distance below the top of the screen `undoButton.viewHeight*2`. 

At this point, the responder is utilized in order to manage the user’s actions with the mouse. If the button is clicked (and an image is currently loaded), a new page will be opened displaying the locations on the computer to which said image may be saved. At this point, the user may then select their intended location in order to save the image there.  

