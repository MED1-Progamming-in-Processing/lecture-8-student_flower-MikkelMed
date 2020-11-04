class Polga {
  float x,y,sizeX,sizeY,speedX,speedY,trans;
  boolean switcher,isTail;    //booleans to be used for calling methods relevant to each individual object
  PImage img;
  
  //> big polga constructor
  Polga(boolean switcher, boolean isTail, PImage img, float x, float y, float sizeX, float sizeY, float trans) {
    this.switcher = switcher;
    this.isTail = isTail;
    this.img = img;
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.trans = trans;
  }
  
  //> small polga constructor
  Polga(boolean switcher, PImage img, float x, float y, float sizeX, float sizeY, float speedX, float speedY) {
    this.switcher = switcher;
    this.img = img;
    this.x = x;
    this.y = y;
    this.sizeX = sizeX;
    this.sizeY = sizeY;
    this.speedX = speedX;
    this.speedY = speedY;
  }
  
  //> update method calls methods to be run continuously 
  void update() {
    if(switcher) {    //if switcher true, we are dealing with the constructor for the big polga
      follow();
    }
    else {    //else, 
      background(bgCol);    //if placed outside this else statement, the background will be drawn on top of the small polga, since it would be run through the 'update'-method of the big polga, which is called after that of the small polga
      display();
      move();
      bounce();
    }
  }
  
  //> only for big polga on top, not the tail
  void follow() {
    x = mouseX;
    y = mouseY;
    tint(255,255);
    image(img,x,y,sizeX,sizeY);
  }
  
  //> both for the small bouncing polga, and the tail 
  void display() {
    if(isTail)
      tint(255,128);
    else
      tint(255,255);
    image(img,x,y,sizeX,sizeY);
  }
  
  //> method for changing the position of the small polga
  void move() {
    x+=speedX;
    y+=speedY;
  }
  
  //> method for changing the direction of the small polga, whenever it hits the edge of the window 
  void bounce() {
    if(x <= sizeX/2 || x >= width-sizeX/2) {
      speedX*=-1;
      bgCol = color(random(0,256),random(0,256),random(0,256));    //the background color is changed
    }
    if(y <= sizeY/2 || y >= height-sizeY/2) {
      speedY*=-1;
      bgCol = color(random(0,256),random(0,256),random(0,256));
    }
  }
}
