class Sprite {
  private int attribute0;
  private int attribute1;
  private int attribute2;
  private int attribute3;

  // attribute 0 fields
  int shape; // 0: 8 , 1: 16 , 2: 32, 3: 64.
  int colorMode; // 0: 16 colors, 1:256 colors
  int mosaic;
  int effect; // 2 bits, alpha and mask
  int affine; // 2 bits
  int y; // 8 bits (max 255?)

  // attribute 1 fields
  int size; // 0: 8 , 1: 16 , 2: 32, 3: 64.
  int vFlip; // 1 bit
  int hFlip; // 1 bit
  int x; // 9 bits

  // attribute 2 fields
  int paletteBank;
  int priority;
  int tileIndex;


  SpriteSize s;
  

  int width;
  int height;

  public Sprite(int x, int y, SpriteSize size) {
    this.x = x;
    this.y = y;
    this.s = size;

    println("w: "+size.getWidth()+" h:"+size.getHeight());
  }

  public int getAttribute(int attribute) {

    return attribute;
  }
}

enum SpriteSize {

    SIZE_8x8(8, 8), SIZE_8x16(8, 16), SIZE_8x32(8, 32), SIZE_8x64(8, 64),
    SIZE_16x8(16, 8), SIZE_16x16(16, 16), SIZE_16x32(16, 32), SIZE_16x64(16, 64),
    SIZE_32x8(32, 8), SIZE_32x16(32, 16), SIZE_32x32(32, 32), SIZE_32x64(32, 64),
    SIZE_64x8(64, 8), SIZE_64x16(64, 16), SIZE_64x32(64, 32), SIZE_64x64(64, 64);

  private final int width;
  private final int height;

  SpriteSize(int width, int height) {
    this.width = width;
    this.height = height;
  }

  public int getWidth() {
    return width;
  }

  public int getHeight() {
    return height;
  }
  int convertSize(int n) {
  return (int) (Math.log(n) / Math.log(2)) - 3;
}
}
