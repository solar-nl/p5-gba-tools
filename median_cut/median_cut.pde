import java.util.*;

Palette p;

String image_fn = "input_image.png";
PImage image;

void setup() {
  size(400, 200);

  image = loadImage(image_fn);

  int numberOfColors = 128;
  int bitsPerChannel = 5;
  
  String palFn = "output/palette-png/"+image_fn+"_"+"debug_palette_"+str(numberOfColors)+"_"+str(bitsPerChannel)+".png";
  String imageFn = "output/images/"+image_fn+"_"+"debug_image_"+str(numberOfColors)+"_"+str(bitsPerChannel)+".png";

  p = new Palette(image, numberOfColors, bitsPerChannel);
  ArrayList<Color> palette = p.generatePalette();

  debugPaletteImage(palette, palFn );
  debugImage(imageFn, image,palette);


  noLoop();
}

void debugImage(String filename, PImage image, ArrayList<Color>palette) {
  image.loadPixels();
  for (int i = 0; i<image.pixels.length; i++) {

    int pixelColor = image.pixels[i];
    Color pColor = new Color(pixelColor);
    Color closestColor = findClosestColor(pColor, palette);
    image.pixels[i] = color(closestColor.r,closestColor.g,closestColor.b);
  }
  image.updatePixels();
  image.save(filename);
}


Color findClosestColor(Color c, ArrayList<Color> palette) {
  int minDistance = Integer.MAX_VALUE;
  Color closestColor = new Color (0, 0, 0);

  for (Color palColor : palette) {
    int dist = c.squaredDistance(palColor);
    if (dist < minDistance) {
      minDistance = dist;
      closestColor = palColor;
    }
  }

  return closestColor;
}

void debugPaletteImage(ArrayList<Color> palette, String filename) {
  PImage debug = createImage(256, 256, RGB);
  debug.loadPixels();
  int index = 0;
  for (int y = 0; y < 16; y++) {
    for (int x = 0; x < 16; x++) {
      Color c;

      if (index < palette.size()) {
        c = palette.get(index);
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
}
