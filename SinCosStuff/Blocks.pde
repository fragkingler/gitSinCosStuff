class Blocks {
  int blockSize;
  int bY;
  int rY; 
  int randDirt = 0;
  color grass = color(100, 90, 110);
  color dirt = color(120, 70, 20);
  color stone = color(60, 180, 40);

  Blocks(int blockSize) {
    this.blockSize = blockSize;
  }

  void drawBlock() {
    bY = height/2;
    
    for (int c = 0; c < width; c += blockSize) {


      //grass

      noStroke();

      fill(stone);

      rect(c, bY, blockSize, blockSize);

      //just for count the y for the stone
      int n = 0;

      //for the dirt level, from 1 to 4 (randomly)
      randDirt = 1 + floor(random(3));

      for (int c2 = bY + blockSize; c2 < height; c2 += blockSize)
      {

        if (randDirt > 0)
        {
          fill(dirt);
        } else { 
          fill(grass);
        }

        rect(c, bY + n + blockSize, blockSize, blockSize);

        n += blockSize;

        randDirt -= 1;
      }

      rY = floor(random(3)-1)*blockSize;
      bY += rY;
    }
  }

  void calcNextHeight() {
  }
}
