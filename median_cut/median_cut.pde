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

UIManager uiManager;
FileManager fn;


Palette pal;
PaletteWriter pw;

TileSet ts;

GBAScreen gbaScreen;
PaletteView paletteView;
TileSetView tileSetView;

PVector mousePos;


String imageFn = "input_image_2.png";
PImage image;

ImageSequence imseq;
ImageSequenceView imSeqView;

DropdownList d1;

void setup() {
  size(384, 384);


  fn = new FileManager();
  imseq = new ImageSequence();
  imSeqView = new ImageSequenceView(240, 160);

  ArrayList<String> folderNames = fn.listFolders(sketchPath()+"/data/seq");

  cp5 = new ControlP5(this);

  // create a DropdownList
  d1 = cp5.addDropdownList("imgSeq").setPosition(0, 160).setId(1);

  for (String folderName : folderNames) {
    d1.addItem(folderName, folderName);
  }

  d1.close();

  cp5.addButton("Next", 10, 245, 0, 50, 20).setId(2);
  cp5.addButton("Prev", 10, 245, 20, 50, 20).setId(3);
  cp5.addButton("Reverse", 10, 245, 60, 50, 20).setId(4);
  cp5.addButton("Pause", 10, 245, 80, 50, 20).setId(5);
  cp5.addButton("Play", 10, 245, 100, 50, 20).setId(6);

  Textlabel paletteViewLabel = cp5.addTextlabel("currentFrame").setText("currentFrame").setPosition(100, 160);



  /*  initComponents();
   
   
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

  //noLoop();*.
}

void button(float theValue) {
  println("a button event. "+theValue);
}

void controlEvent(ControlEvent theEvent) {


  if (theEvent.isGroup()) {
    // check if the Event was triggered from a ControlGroup
    println("event from group : "+theEvent.getGroup().getValue()+" from "+theEvent.getGroup());
  } else if (theEvent.isController()) {
    println("event from controller : "+theEvent.getController().getValue()+" from "+theEvent.getController());


    int controllerID = theEvent.getController().getId();

    switch(controllerID) {
    case 0:
      println("Zero");  // Does not execute
      break;
    case 1:
      int index = (int) theEvent.getController().getValue();

      String folder = fn.listFolders(sketchPath()+"/data/seq").get(index);
      String seqPath = sketchPath()+"/data/seq/"+folder;

      imseq.loadImages(seqPath);
      imSeqView.currentImage = 0;
      imSeqView.imSeq = imseq;
      break;
    case 2:
      imSeqView.next();
      break;
    case 3:
      imSeqView.prev();
      break;
    case 4:
      imSeqView.rev();
      break;
    case 5:
      imSeqView.play();
      break;
    case 6:
      imSeqView.play();
      break;
    }
  }
}

void initComponents() {

  // create an image manager?

  // image sequence loader

  // palette sequence loader

  // create an empty pallete

  // create an empty tileset


  // create an empty sprite

  // create an empty gbaView
}

void setupViews() {
  gbaScreen.setup();
  paletteView.setup();

  gbaScreen.title = "GBA Screen";
  paletteView.title = "TileSet Pallete";
}

void setupUI() {
}

void draw() {

  background(64);

  //image(imseq.images.get(0), 0, 0);

  imSeqView.draw();

  /* gbaScreen.update();
   background(64);
   ts.draw(16, 16);
   
   paletteView.draw();
   gbaScreen.draw();*/
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



void setupControlP5() {
  cp5 = new ControlP5(this);



  Textlabel gbaViewLabel = cp5.addTextlabel(gbaScreen.title).setText(gbaScreen.title).setPosition(gbaScreen.x, gbaScreen.y-12);
  Textlabel paletteViewLabel = cp5.addTextlabel(paletteView.title).setText(paletteView.title).setPosition(paletteView.x, paletteView.y-12);
  //Textlabel tileSetViewLabel = cp5.addTextlabel(tsView.title).setText(tsView.title).setPosition(tsView.x,tsView.y);
  //myTextlabelB = cp5.addTextlabel(finalMaskLabel).setText(finalMaskLabel).setPosition(finalMaskOrigin.x, finalMaskOrigin.y-12);
  //myTextlabelC = cp5.addTextlabel(inputImageLabel).setText(inputImageLabel).setPosition(inputImageOrigin.x, inputImageOrigin.y-12);
  //myTextlabelD = cp5.addTextlabel(inputMaskLabel).setText(inputMaskLabel).setPosition(inputMaskOrigin.x, inputMaskOrigin.y-12);
}
