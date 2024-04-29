import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

class RGBCube {
  public ArrayList<Color> colors;

  public Color min; // min RGBA
  public Color max; // max RGBA

  private final int RED = 0;
  private final int GREEN = 1;
  private final int BLUE = 2;

  public RGBCube () {
    this.colors = new ArrayList<Color>();

    this.max = new Color(0, 0, 0);
    this.min = new Color(255, 255, 255);
  }

  public RGBCube(ArrayList<Color> colors) {
    this.colors = colors;

    this.max = new Color(0, 0, 0);
    this.min = new Color(255, 255, 255);
  }

  public Color calculateDimensionRanges() {
    for (Color c : colors) {
      if (c.r > max.r) {
        max.r = c.r;
      }
      if (c.r < min.r) {
        min.r = c.r;
      }
      if (c.g > max.g) {
        max.g = c.g;
      }
      if (c.g < min.g) {
        min.g = c.g;
      }
      if (c.b > max.b) {
        max.b = c.b;
      }
      if (c.b < min.b  ) {
        min.b = c.b;
      }
    }

    return max.subtract(min);
  }

  public int findLongestDimension(Color ranges) {
    int maxRange = ranges.r;
    int longestDim = RED;

    if (ranges.g > maxRange) {
      maxRange = ranges.g;
      longestDim = GREEN;
    }
    if (ranges.b > maxRange) {
      maxRange = ranges.b;
      longestDim = BLUE;
    }

    return longestDim;
  }

  public ArrayList<Color> sortByChannel(int channel) {

    ArrayList<Color> sortedColors = new ArrayList<Color>();

    for (Color c : this.colors) {
      sortedColors.add(c);
    }

    Collections.sort(sortedColors, new Comparator<Color>() {
      public int compare(Color c1, Color c2) {
        switch (channel) {
        case RED:
          return c1.r - c2.r;
        case GREEN:
          return c1.g - c2.g;
        case BLUE:
          return c1.b - c2.b;
        default:
          throw new IllegalArgumentException("Invalid channel: " + channel);
        }
      }
    }
    );
    return sortedColors;
  }
  
  /**
  *
  * Split a list of Color objects into two lists based on the median of the input Color list.
  *
  */

  public ArrayList splitColorList(ArrayList<Color> colors) {
    ArrayList<ArrayList> splitColors = new ArrayList<ArrayList>();

    ArrayList<Color> firstHalf = new ArrayList<Color>();
    ArrayList<Color> secondHalf = new ArrayList<Color>();

    int medianIndex = colors.size() / 2;

    for (int i = 0; i<colors.size(); i++) {
      if (i < medianIndex) {
        firstHalf.add(colors.get(i));
      } else {
        secondHalf.add(colors.get(i));
      }
    }

    splitColors.add(firstHalf);
    splitColors.add(secondHalf);

    return splitColors;
  }

  /**
  *
  * Calculate the average RGB color for the colors present in this RGBCube
  *
  */

  public Color averageColor() {

    int sumRed = 0, sumGreen = 0, sumBlue = 0;
    for (Color c : this.colors) {
      sumRed += c.r;
      sumGreen += c.g;
      sumBlue += c.b;
    }

    int count = this.colors.size();
    int ar = sumRed / count;
    int ag = sumGreen / count;
    int ab = sumBlue / count;

    return new Color(ar, ag, ab);
  }
}
