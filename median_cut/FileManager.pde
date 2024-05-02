import java.io.File;
import java.io.FilenameFilter;


class FileManager {

  public FileManager() {
  }

  public ArrayList<String> listFolders(String directoryPath) {
    
    ArrayList<String> folders = new ArrayList<String>();
    
    File dir = new File(directoryPath);
    // Filter to identify only directories
    File[] subdirs = dir.listFiles(new FilenameFilter() {
      public boolean accept(File current, String name) {
        return new File(current, name).isDirectory();
      }
    }
    );

    if (subdirs != null) {
      for (File folder : subdirs) {
        println("Folder: " + folder.getName());
        folders.add(folder.getName());
        
      }
    } else {
      println("No folders found or the directory does not exist.");
    }
    
    return folders;
  }

  String generateFileName(String directory, String baseName, String descriptor, int numColors, int bits, String fileExtension) {
    return "output/" + directory + "/" + baseName + "_" + descriptor + "_" + numColors + "_" + bits + fileExtension;
  }
}
