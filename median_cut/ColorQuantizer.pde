class ColorQuantizer {

  private final int bitsPerChannel;

  public ColorQuantizer(int bitsPerChannel) {
    this.bitsPerChannel = bitsPerChannel;
  }

  public int quantizeColor(int r, int g, int b) {
    int rQuant = quantizeComponent(r);
    int gQuant = quantizeComponent(g);
    int bQuant = quantizeComponent(b);

    return (rQuant << (2 * bitsPerChannel)) | (gQuant << bitsPerChannel) | bQuant;
  }

  public Color deQuantizeColor(int quantizedColor) {
    int r = dequantizeComponent((quantizedColor >> (2 * bitsPerChannel)) & ((1 << bitsPerChannel) - 1));
    int g = dequantizeComponent((quantizedColor >> bitsPerChannel) & ((1 << bitsPerChannel) - 1));
    int b = dequantizeComponent(quantizedColor & ((1 << bitsPerChannel) - 1));

    return new Color(r,g,b);//int[]{r, g, b};
  }
  private int quantizeComponent(int c) {
    int maxVal = (1 << bitsPerChannel) - 1;
    return Math.round(c * maxVal / 255.0f);
  }

  private int dequantizeComponent(int c) {
    int maxVal = (1 << bitsPerChannel) - 1;
    return Math.round(c * 255.0f / maxVal);
  }
}
