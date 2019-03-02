public enum Mouse {
  Click, Hover, LeftButton, RightButton,
}

interface MouseDelegate {
    public void isClicked();
    public void isHovering();
    public void buttonDown(Mouse button);
}
