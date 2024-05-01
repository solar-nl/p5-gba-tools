import controlP5.*;

import java.util.*;

ControlP5 cp5;

ArrayList<Textlabel> labels;
ArrayList<Rect> viewBounds;

String inputImageLabel = "Input Image";
String inputMaskLabel = "Input Mask";
String finalImageLabel = "Final Image";
String finalMaskLabel = "Final Mask";

PVector finalImageOrigin;
PVector finalMaskOrigin;
PVector inputImageOrigin;
PVector inputMaskOrigin;


Palette pal;
PaletteWriter pw;

TileSet ts;

GBAScreen gbaScreen;
PaletteView paletteView;
TileSetView tileSetView;

PVector mousePos;


String imageFn = "input_image_2.png";
PImage image;

void setup() {
  size(384, 384);
  finalImageOrigin = new PVector(160, 160);
  inputImageOrigin = new PVector(160, 16);
  inputMaskOrigin = new PVector(16, 16);
  finalMaskOrigin = new PVector(16, 160);



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

  gbaScreen = new GBAScreen(16, 192);
  paletteView = new PaletteView(176,16,pal, tileSize, 1);
//  tileSetView = new TileSetView(ts);
  setupViews();


  // interface setup
  setupControlP5();

  /*for(SpriteSize size : SpriteSize.values()) {
   println(size.toString());
   }*/

  //noLoop();
}

void setupViews() {
  gbaScreen.setup();
  paletteView.setup();
  
  gbaScreen.title = "GBA Screen";
  paletteView.title = "TileSet Pallete";
  
}

void draw() {
  gbaScreen.update();
  background(64);
  ts.draw(16, 16);

  paletteView.draw();
  gbaScreen.draw();
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

void setupControlP5() {
  cp5 = new ControlP5(this);



  Textlabel gbaViewLabel = cp5.addTextlabel(gbaScreen.title).setText(gbaScreen.title).setPosition(gbaScreen.x, gbaScreen.y-12);
  Textlabel paletteViewLabel = cp5.addTextlabel(paletteView.title).setText(paletteView.title).setPosition(paletteView.x,paletteView.y-12);
  //Textlabel tileSetViewLabel = cp5.addTextlabel(tsView.title).setText(tsView.title).setPosition(tsView.x,tsView.y);
  //myTextlabelB = cp5.addTextlabel(finalMaskLabel).setText(finalMaskLabel).setPosition(finalMaskOrigin.x, finalMaskOrigin.y-12);
  //myTextlabelC = cp5.addTextlabel(inputImageLabel).setText(inputImageLabel).setPosition(inputImageOrigin.x, inputImageOrigin.y-12);
  //myTextlabelD = cp5.addTextlabel(inputMaskLabel).setText(inputMaskLabel).setPosition(inputMaskOrigin.x, inputMaskOrigin.y-12);
}
