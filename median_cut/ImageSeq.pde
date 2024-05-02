import java.io.File;

class ImageSequence {

  ArrayList<PImage> images;

  ImageSequence() {
    this.images = new ArrayList<PImage>();
    PImage   img = createImage(240, 160, RGB);

    this.images.add(img);
  }

  // Method to load all PNG images from a folder
  void loadImages(String folderPath) {

    this.images = new ArrayList<PImage>();

    File dir = new File(folderPath);
    File[] files = dir.listFiles(); // Get all files in the directory
    if (files == null) {
      println("No files found in the directory.");
      return;
    }

    // Sort the array of files (which affects their load order)
    Arrays.sort(files, new Comparator<File>() {
      public int compare(File f1, File f2) {
        return f1.getName().compareToIgnoreCase(f2.getName());
      }
    }
    );

    for (File f : files) {
      if (f.getName().toLowerCase().endsWith(".png")) {
        PImage img = loadImage(f.getAbsolutePath());
        if (img != null) {
          images.add(img);
        }
        //println(f.getName());
      }
    }
  }

  // Method to get a single image from the sequence
  PImage getImage(int index) {
    if (index >= 0 && index < images.size()) {
      return images.get(index);
    } else {
      return null;
    }
  }
}

class ImageSequenceView {

  PGraphics g;

  ImageSequence imSeq;

  int currentImage = 0;

  PImage img;

  boolean playing;

  int direction;

  int FORWARD = 0;
  int REVERSE = 1;

  public ImageSequenceView(int width, int height) {
    this.g = createGraphics(240, 160);

    imSeq = new ImageSequence();

    //playing = true;
  }

  public void draw() {
    img = imSeq.images.get(currentImage);
    g.beginDraw();
    g.background(0);
    g.image(img, 0, 0);
    g.endDraw();

    image(g, 0, 0);

    if (playing) {
      if (direction == FORWARD) {
        next();
      }
      if (direction == REVERSE) {
        prev();
      }
    }
  }

  public void next() {
    currentImage = wrapClamp(currentImage+1, 0, imSeq.images.size()-1);
  }

  public void prev() {
    currentImage = wrapClamp(currentImage-1, 0, imSeq.images.size()-1);
  }

  public void play() {
    if (direction == REVERSE) {
      direction = FORWARD;
    }
    pause();
  }

  public void pause() {
    if (playing) {
      playing = false;
    } else {
      playing = true;
    }
  }

  public void rev() {
    if (direction == FORWARD) {
      direction = REVERSE;
    }
    if (direction == REVERSE) {
      direction = FORWARD;
    }
  }



  int wrapClamp(int value, int minVal, int maxVal) {
    int range = maxVal - minVal;
    if (range <= 0) {
      return minVal;  // Prevent division by zero if range is invalid
    }
    while (value < minVal) {
      value += range;
    }
    while (value > maxVal) {
      value -= range;
    }
    return value;
  }
}
