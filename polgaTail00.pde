int[] windowSize = {1600,900};

//> variables for objects of type 'Polga'
PImage polgaImg;
float x = random(366/2,width-366/2);    //polga.png (366x490)
float y = random(490/2,height-490/2);
float speedX = random(-6,7);    //speed of the bouncing polga
float speedY = random(-6,7);
float scale = .965;    //decremental variable for minimizing polga objects within the 'tail'-array (should stay within .9 and 1, but changing it to 1 or very close to, also makes for a fun result (also makes the program run more smoothly))
float trans = 128;    //alpha value for the tail

Polga[] tail = new Polga[20];
Polga big,small;

color bgCol = color(random(0,256),random(0,256),random(0,256));    //background color)
float dist;    //distance between the 2 objects

//> variables for displaying framerate
int fontSize;
String fps;
color col = color(0,255,0);
PFont font;

void settings() {
  size(windowSize[0],windowSize[1]);
}

void setup() {
  //> polga.png is loaded
  imageMode(CENTER);
  polgaImg = loadImage("polga.png");
  
  //> tail array is filled with objects of type polga
  for(int i = 0; i < tail.length; i++) {
    tail[i] = new Polga(false,true,polgaImg,mouseX,mouseY,float(polgaImg.width),float(polgaImg.height),trans);
  }
  
  //> big and small polga are made
  big = new Polga(true,false,polgaImg,mouseX,mouseY,float(polgaImg.width),float(polgaImg.height),trans);    //follows the cursor
  small = new Polga(false,polgaImg,x,y,(polgaImg.width)/2,(polgaImg.height)/2,speedX,speedY);    //bounce around within the window
  
  //> font is made
  font = loadFont("CourierNewPS-BoldMT-24.vlw");
  textFont(font);
  fontSize = 24;
}

void draw() {
  small.update();    //small polga is updated first
  
  //> polga tail is displayed and not set to follow, since it should lack behind the cursor/big polga
  for(int i = tail.length-1; i > 0; i--) {
    tail[i].x = tail[i-1].x;
    tail[i].y = tail[i-1].y;
    tail[i].sizeX = tail[i-1].sizeX*pow(scale,i);
    tail[i].sizeY = tail[i-1].sizeY*pow(scale,i);
  }
  tail[0].x = mouseX;
  tail[0].y = mouseY;
  for(int i = 0; i < tail.length; i++) {
    tail[i].display();
  }
  
  big.update();    //big polga is updated
  
  //> if the 2 polgas overlap, a message is displayed over the big polga
  dist = dist(big.x,big.y,small.x,small.y);
  if(dist <= big.sizeX/2 || dist <= big.sizeY/2) {
    fill(0);
    textAlign(CENTER);
    text("Keep up the good work Olga!\nWe love your lectures :)",mouseX,mouseY-big.sizeY/2-25);
  }
  
  //> framerate is displayed in top right corner
  fps = nf(frameRate,0,-1);
  fill(col);
  textAlign(LEFT);
  text(fps,width-fontSize*1.5,fontSize);
}
