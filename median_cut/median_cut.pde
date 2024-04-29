import java.util.*;

Palette pal;
PaletteWriter pw;

TileSet ts;

GBAScreen gbaScreen;
PaletteView palView;

PVector mousePos;


String imageFn = "c4d_seq_test/c4d_seq_test0000.png";
PImage image;

void setup() {
  size(384, 384);


  
  image = loadImage(imageFn);

  int numberOfColors = 256;
  int bitsPerChannel = 5;
  int tileSize = 8;

  String imageTitle = imageFn.substring(0, imageFn.lastIndexOf('.'));
  String imageFn = generateFileName("images", imageTitle, "image", numberOfColors, bitsPerChannel, ".png");

  String palFn = generateFileName("palette-png", imageTitle, "palette", numberOfColors, bitsPerChannel, ".png");
  String cPaletteFn = generateFileName("palette-c", imageTitle, "pal", numberOfColors, bitsPerChannel, ".c");

  pal = new Palette(image, numberOfColors, bitsPerChannel);
  ts = new TileSet(image, numberOfColors, tileSize, bitsPerChannel);

  ts.pal.debugPaletteImage(ts.colors, palFn );
  ts.pal.debugImage(imageFn, image, pal.colors);

  pw = new PaletteWriter(cPaletteFn, imageTitle, pal.colors, bitsPerChannel);
  pw.dump();

  Sprite s = new Sprite(16, 192, SpriteSize.SIZE_8x16, 0);
  s.tiles = ts.getSpriteTiles(s.s, s.tileIndex);
  s.draw();


  gbaScreen = new GBAScreen();
  gbaScreen.setup();

  palView = new PaletteView(pal,tileSize,1);




  /*for(SpriteSize size : SpriteSize.values()) {
   println(size.toString());
   }*/

  //noLoop();
}

void draw() {
  gbaScreen.update();
  background(64);
  ts.draw(16, 16);

  palView.draw(176,16);
  gbaScreen.draw(16,192);
}

String generateFileName(String directory, String baseName, String descriptor, int numColors, int bits, String fileExtension) {
  return "output/" + directory + "/" + baseName + "_" + descriptor + "_" + numColors + "_" + bits + fileExtension;
}


void mousePressed() {
  println("mousePressed");
}

void mouseDragged() {
  println("mouseDragged");
}

void mouseReleased() {
  println("mouseReleased");
}

PVector localToGlobal(PVector local, PVector origin) {
  return new PVector(local.x+origin.x, local.y+origin.y);
}

PVector globalToLocal(PVector global, PVector origin) {
  return new PVector(global.x - origin.x, global.y - origin.y);
}
