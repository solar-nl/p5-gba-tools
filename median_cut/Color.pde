class Color {

  public int r;
  public int g;
  public int b;
  public int a;

  public  Color(int c) {
    this.a = (c >> 24) & 0xFF;
    this.r = (c >> 16) & 0xFF;
    this.g = (c >> 8) & 0xFF;
    this.b = c & 0xFF;
  }

  public Color (int r, int g, int b, int a) {
    this.a = a;
    this.r = r;
    this.g = g;
    this.b = b;
  }
  public Color(int r, int g, int b) {
    this(r, g, b, 255);
  }

  public Color (int[] rgb) {
    this(rgb[0], rgb[1], rgb[2], 255);
  }

  public Color subtract(Color c) {
    int r = this.r - c.r;
    int g = this.g - c.g;
    int b = this.b - c.b;
    int a = this.a - c.a;

    return new Color(r, g, b, a);
  }

  public int squaredDistance(Color b) {

    int dr = b.r - this.r;
    int dg = b.g - this.g;
    int db = b.b - this.b;

    return (dr*dr)+(dg*dg)+(db*db);
  }
  boolean equals(Color other) {
    return this.r == other.r && this.g == other.g && this.b == other.b && this.a == other.a;
  }

  public String toString() {
    return "Color: [R: "+this.r+", G: "+this.g+", B:"+ this.b+", A:"+this.a+"]";
  }
}
