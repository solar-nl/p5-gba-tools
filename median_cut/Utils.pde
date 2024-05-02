class Rect {
  
  public int x;
  public int y;

  public int width;
  public int height;


  public Rect(int x, int y, int width, int height) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
  }
/*
  public boolean intersectsPoint(PVector p) {
    int x1 = this.x;
    int y1 = this.y;   
    int x2 = this.x+this.width;
    int y2 = this.y+this.height;

    return (x1 <= (int) p.x <= x2 && y1 <= (int) p.y <= y2); 
    
  }*/

}


PVector localToGlobal(PVector local, PVector origin) {
  return new PVector(local.x+origin.x, local.y+origin.y);
}

PVector globalToLocal(PVector global, PVector origin) {
  return new PVector(global.x - origin.x, global.y - origin.y);
}

 /* void debugImage(String filename, PImage image, ArrayList<Color>colors) {
    image.loadPixels();
    for (int i = 0; i<image.pixels.length; i++) {

      int pixelColor = image.pixels[i];
      Color pColor = new Color(pixelColor);
      Color closestColor = this.findClosestColor(pColor, colors);
      image.pixels[i] = color(closestColor.r, closestColor.g, closestColor.b);
    }
    image.updatePixels();
    image.save(filename);
  }


  void debugPaletteImage(ArrayList<Color> colors, String filename) {
    PImage debug = createImage(256, 256, RGB);
    debug.loadPixels();
    int index = 0;
    for (int y = 0; y < 16; y++) {
      for (int x = 0; x < 16; x++) {
        Color c;

        if (index < colors.size()) {
          c = colors.get(index);
        } else {
          c = new Color(0, 0, 0, 255);
        }
        color cc = color(c.r, c.g, c.b, c.a);

        for (int dy = 0; dy < 16; dy++) { // Fill a 16x16 pixel block
          for (int dx = 0; dx < 16; dx++) {
            int px = x * 16 + dx;
            int py = y * 16 + dy;
            debug.pixels[py * 256 + px] = cc;
          }
        }
        index++;
      }
    }

    debug.updatePixels();
    debug.save(filename);
  }*/

class Mouse {

  boolean dragging;
  
  PVector pos;
  PVector startDrag;
  PVector endDrag;

  public Mouse() {

  }

}
