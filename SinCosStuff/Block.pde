class Block {
  ArrayList<Block> blocks;
  int calcedHeight;
  int blockSize;
  int posX, posY;
  color stone = color(100, 90, 110);
  color dirt = color(120, 70, 20);
  color grass = color(60, 180, 40);

  Block(int blockSize, int x, int y) {
    noStroke();
    this.blockSize = blockSize;
    this.posX = x;
    this.posY = y;
    if (y == 0) {
      posY = int(height/1.3);
    }
  }

  void drawBlock() {
    fill(stone);
    rect(posX, posY, blockSize, blockSize);
  }

  int calcHeight(ArrayList blocks) {
    this.blocks = new ArrayList<Block>(blocks);
    posY = (this.blocks.get(this.blocks.size()-1).posY + floor(random(-1.3, 2.3))*blockSize);
    if (posY < height/4) {
      println("preadjust: " + posY);
      fill(grass);
      rect(posX+blockSize, posY, blockSize, 2);
      posY = height/4;
      println("adjusted: " + posY);
    } else if (posY >= height-blockSize) {
      fill(grass);
      rect(posX+blockSize, posY-blockSize, blockSize, 2);
      posY = height-blockSize;
    }
    stroke(250, 50, 50);
    calcedHeight = posY;
    return calcedHeight;
  }
}
