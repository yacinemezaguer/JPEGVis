
public class JCompressor {
  
  //color mode constants
  private static final char BW_M = 0;  //black and white
  private static final char COLOR_M = 1;  //color
  private static final int DCTStandardSize = 8;
  private char colorMode;
  
  PImage original;
  PImage compressed;
  byte grayscale[][];
  byte red[][];
  byte green[][];
  byte blue[][];
  
  //compressed components
  byte compGrayscale[][];
  byte compRed[][];
  byte compGreen[][];
  byte compBlue[][];
  
  //modified width and height (to make it a multiple of the DCT block dimension)
  int sWidth;
  int sHeight;
  
  //DCT components
  int DCTtable[][]; //verify if int or float to use here
  byte grayDCT[][]; 
  byte redDCT[][];
  byte greenDCT[][];
  byte blueDCT[][];
  
  public JCompressor(PImage img) {
    /*
    *  Copy reference to image
    *  generate matrices: grayscale, red, green and blue
    *  generate matrices DCTtable and qMatrix
    *  calculate DCT for grayscale, red, green and blue
    *  generate compressed components
    */
  }
  
  public void setColorMode(char mode) {
  }
  
  private void generateDCTtable(int size) {
  }
  
  public byte[][] DCT(byte[][] original) {
      //returns DCT matrix of @original
  }
  
  public void calculateDCTs() {
  }
  
  public int[][] generateQMatrix(int dimension, int factor) {
    //generate a square quantization matrix of size @dimension and compression factor @factor
  }
  
  public void setFactor(int factor) {
  }
  
  public void quantize(int[][] qMatrix) {
    //divide the DCT matrix elements by the elements of the @qMmatrix and returns the new matrix
  }
}
