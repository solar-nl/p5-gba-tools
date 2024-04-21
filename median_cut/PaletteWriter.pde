class PaletteWriter {

  private PrintWriter w;
  private ArrayList<Color> p;
  private ColorQuantizer cq;

  private int bitsPerChannel;

  String name;

  public PaletteWriter(String fn, String paletteName, ArrayList<Color> palette, int bitsPerChannel) {
    w = createWriter(fn);
    p = palette;
    name = paletteName;

    this.bitsPerChannel = bitsPerChannel;
    this.cq = new ColorQuantizer(this.bitsPerChannel);
  }

  public void dump() {
    // Include statements and array definitions
    w.println("#include \"memory.h\"");
    w.println("unsigned short EWRAM_DATA generated_palette[256];");

    // Start of array
    w.println("const unsigned short "+name+"["+p.size()+"] = {");

    for (int i = 0; i < p.size(); i++) {

      Color c = p.get(i);

      int quantizedColor = cq.quantizeColor(c.b, c.g, c.r); // blue and red are reversed because the GBA likes it that way.

      w.print(String.format("0x%04X", quantizedColor)); // Format as hexadecimal

      // Handle commas and line breaks
      if (i < p.size() - 1) w.print(", ");
      if ((i + 1) % 16 == 0) w.println();
    }

    // End of array
    w.println("};");
    w.flush(); // Make sure to flush the writer to ensure all data is written
    w.close(); // Close the writer to free resources
  }
}
