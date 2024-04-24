import java.util.*;

Palette p;
PaletteWriter pw;

String imageFn = "input_image_4.png";
PImage image;

void setup() {

  image = loadImage(imageFn);

  int numberOfColors = 256;
  int bitsPerChannel = 5;
  int tileSize = 8;

  String imageTitle = imageFn.substring(0, imageFn.lastIndexOf('.'));
  String imageFn = generateFileName("images", imageTitle, "image", numberOfColors, bitsPerChannel, ".png");

  String palFn = generateFileName("pallete-png", imageTitle, "palette", numberOfColors, bitsPerChannel, ".png");
  String cPaletteFn = generateFileName("palette-c", imageTitle, "pal", numberOfColors, bitsPerChannel, ".c");

  p = new Palette(image, numberOfColors, bitsPerChannel);
  ArrayList<Color> palette = p.generatePalette();

  TileSet ts = new TileSet(image, numberOfColors, tileSize, bitsPerChannel);
  ts.draw();

  ts.pal.debugPaletteImage(ts.colors, palFn );
  ts.pal.debugImage(imageFn, image, palette);

  pw = new PaletteWriter(cPaletteFn, imageTitle, palette, bitsPerChannel);
  pw.dump();

  Sprite s = new Sprite(192,32,SpriteSize.SIZE_32x32,0);
  s.tiles = ts.getSpriteTiles(s.s,s.tileIndex);

  s.draw();

  noLoop();

}

String generateFileName(String directory, String baseName, String descriptor, int numColors, int bits, String fileExtension) {
  return "output/" + directory + "/" + baseName + "_" + descriptor + "_" + numColors + "_" + bits + fileExtension;
}
