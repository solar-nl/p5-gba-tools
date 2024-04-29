class GBAScreen {

  PGraphics g;

  PVector pos;

  PVector pointA, pointB;

  float angle = 0;
  float diameter = 64;
  float radius = diameter / 2;
  
  GBAScreen() {
    this.g = createGraphics(240,160);
  }

  public void setup() {
    pointA = new PVector();
    pointB = new PVector();
  }

  public void update() {
    pointA.x = g.width / 2 + radius * cos(angle);
    pointA.y = g.height / 2 + radius * sin(angle);

    pointB.x = g.width / 2 + radius * cos(angle+PI);
    pointB.y = g.height / 2 + radius * sin(angle+PI);

    angle+= 0.05;
  }

  public void draw(int x, int y) {
    g.beginDraw();
    g.background(0);
    g.stroke(255);
    g.noFill();
    g.ellipse(pointA.x, pointA.y, 10, 10);
    g.ellipse(pointB.x, pointB.y, 10, 10);
    g.line(0, 0, 240, 160);
    g.endDraw();

    image(g, x, y);
  }
}
