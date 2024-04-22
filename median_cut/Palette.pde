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

      int quantizedColor = cq.quantizeColor(averageColor.r, averageColor.g, averageColor.b);
      Color deQuantizedColor = cq.deQuantizeColor(quantizedColor);

      palette.add(deQuantizedColor);
    }
    return palette;
  }

  // Find the index of a color in the palette
  public int index(Color c) {
    for (int i = 0; i < palette.size(); i++) {
      if (palette.get(i).equals(c)) {
        return i;
      }
    }
    return -1; // Return -1 if color is not found
  }

  public int[][] paletteIndices(PImage quantizedImage) {
    int[][] paletteIndices = new int[quantizedImage.width][quantizedImage.height];

    for (int x = 0; x < quantizedImage.width; x++) {
      for (int y = 0; y < quantizedImage.height; y++) {
        int index = x + y * quantizedImage.width;
        int pixelColor = quantizedImage.pixels[index];
        Color currentColor = new Color((pixelColor >> 16) & 0xFF, (pixelColor >> 8) & 0xFF, pixelColor & 0xFF, (pixelColor >> 24) & 0xFF);
        int paletteIndex = index(currentColor);
        paletteIndices[x][y] = paletteIndex;
      }
    }
    return paletteIndices;
  }



  PImage quantizeImage(PImage img, ArrayList<Color> palette) {
    img.loadPixels();
    for (int i = 0; i<img.pixels.length; i++) {

      int pixelColor = img.pixels[i];
      Color pColor = new Color(pixelColor);
      Color closestColor = findClosestColor(pColor, palette);
      img.pixels[i] = color(closestColor.r, closestColor.g, closestColor.b);
    }
    img.updatePixels();
    return img;
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

  void debugImage(String filename, PImage image, ArrayList<Color>palette) {
    image.loadPixels();
    for (int i = 0; i<image.pixels.length; i++) {

      int pixelColor = image.pixels[i];
      Color pColor = new Color(pixelColor);
      Color closestColor = findClosestColor(pColor, palette);
      image.pixels[i] = color(closestColor.r, closestColor.g, closestColor.b);
    }
    image.updatePixels();
    image.save(filename);
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
}
