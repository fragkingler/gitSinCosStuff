int blockSize = 50;

//block Y
int bY;

//relative Y
int rY; 

//how many dirt above the stone
int randDirt = 0;


String[] text = {"N", "o", "c", "h", " ", "F", "r", "a", "g", "e", "n", "?"};

int textLength = text.length;
int startTextAt;
int getChar = 0;

void setup() {

  size(1900, 1000);
  startTextAt = width / blockSize;
  startTextAt = (int)random(0, startTextAt - textLength);

  //background

  for (int i=0; i<width; i++) {

    for (int j=0; j<height; j++) {

      stroke(100+j/height*120, 100+j/height*120, 255);

      point(i, j);
    }

    //variables

    bY = height/2;
  }

  //blocks

  for (int c = 0; c < width; c += blockSize) {

    getChar++;

    //grass

    noStroke();

    fill(60, 180, 40);

    rect(c, bY, blockSize, blockSize);




    //dirt & stone

    //just for count the y for the stone
    int n = 0;

    //for the dirt level, from 1 to 4 (randomly)
    randDirt = 1 + floor(random(3));

    for (int c2 = bY + blockSize; c2 < height; c2 += blockSize)
    {

      if (randDirt > 0)
      {
        fill(120, 70, 20);
      } else { 
        fill(100, 90, 110);
      }

      rect(c, bY + n + blockSize, blockSize, blockSize);

      n += blockSize;

      randDirt -= 1;
    }

    //set the new Y for grass
    rY = floor(random(3)-1)*blockSize;

    bY += rY;
    
    //if (getChar >= startTextAt && getChar < startTextAt + textLength) {
    //  println("HI");
    //  fill(0);
    //  textSize(64);
    //  textAlign(CENTER);
    //  if (getChar-startTextAt == 8) {
    //    text(text[getChar-startTextAt], getChar*blockSize+blockSize/2, bY-12);
    //  } else {
    //    text(text[getChar-startTextAt], getChar*blockSize+blockSize/2, bY);
    //  }
    //}
  }
}
