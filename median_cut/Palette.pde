class Palette {
  private ArrayList<RGBCube> rgbCubes;
  private ArrayList<Color> palette;

  int[] paletteMap;

  private int numColors;
  private int bitsPerChannel;
  
  private ColorQuantizer cq;

  public Palette(PImage img, int numColors, int bitsPerChannel) {

    this.rgbCubes = new ArrayList<RGBCube>();
    this.palette = new ArrayList<Color>();
    this.numColors = numColors;
    this.bitsPerChannel = bitsPerChannel;
    this.cq = new ColorQuantizer(this.bitsPerChannel);

    img.loadPixels();

    HashSet<Integer> uniqueColors = new HashSet<>(img.pixels.length);
    for (int p : img.pixels) {
      uniqueColors.add(p);
    }

    RGBCube rgbCube = new RGBCube();
    
    for (int p : uniqueColors) {
      rgbCube.colors.add(new Color(p));
    }
    rgbCubes.add(rgbCube);
  }

  public Palette(PImage img) {
    this(img, 256, 8);
  }

  public Palette(PImage img, int numColors) {
    this(img, numColors, 8);
  }

  public ArrayList<Color> generatePalette() {
    List<RGBCube> tempCubes = new ArrayList<>();
    while (rgbCubes.size() < this.numColors) {
      for (RGBCube rgbCube : rgbCubes) {
        Color ranges = rgbCube.calculateDimensionRanges();
        int longestRange = rgbCube.findLongestDimension(ranges);
        ArrayList<Color> sortedColors = rgbCube.sortByChannel(longestRange);
        ArrayList<ArrayList> splitColorsList = rgbCube.splitColorList(sortedColors);
        for (ArrayList<Color> cl : splitColorsList) {
          tempCubes.add(new RGBCube(cl));
        }
      }
      rgbCubes.clear();
      rgbCubes.addAll(tempCubes); 
      tempCubes.clear(); 
    }
    for (RGBCube rgbCube : rgbCubes) {
      Color averageColor = rgbCube.averageColor();

      int quantizedColor = cq.quantizeColor(averageColor.r,averageColor.g,averageColor.b);
      Color deQuantizedColor = cq.deQuantizeColor(quantizedColor);
      
      palette.add(deQuantizedColor);
    }
    return palette;
  }
  
  
}
