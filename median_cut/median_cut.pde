import java.util.*;

Palette p;
PaletteWriter pw;

String image_fn = "input_image_3.png";
PImage image;

void setup() {
  size(256, 256);

  image = loadImage(image_fn);

  int numberOfColors = 256;
  int bitsPerChannel = 5;

  String palFn = "output/palette-png/"+image_fn+"_"+"debug_palette_"+str(numberOfColors)+"_"+str(bitsPerChannel)+".png";
  String imageFn = "output/images/"+image_fn+"_"+"debug_image_"+str(numberOfColors)+"_"+str(bitsPerChannel)+".png";

  p = new Palette(image, numberOfColors, bitsPerChannel);
  ArrayList<Color> palette = p.generatePalette();


  TileSet ts = new TileSet(image,numberOfColors,8,bitsPerChannel);
  ts.draw();

   ts.pal.debugPaletteImage(ts.colors, palFn );
   ts.pal.debugImage(imageFn, image,palette);
   
   String[] fn_parts = split(image_fn, ".");
   pw = new PaletteWriter("output/pallette-c/pal_"+fn_parts[0]+".c",fn_parts[0],palette,bitsPerChannel);
   pw.dump();


  noLoop();
}
