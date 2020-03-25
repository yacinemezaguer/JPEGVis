public static float[][] generateDCTtable(int size) {
    //precalculates the cosine part of the DCT formula and returns the matrix
    float[][] table = new float[size][size];
    for(int x = 0; x < size; x++) {
      for(int u = 0; u < size; u++) {
        table[x][u] = cos((2*x + 1) * u * PI / (2*size));
      }
    }

    return table;
  }

public static int[][] generateQMatrix(int dimension, int factor) {
    //generate a square quantization matrix of size @dimension and compression factor of @factor
    int qMatrix[][] = new int[dimension][dimension];

    for(int i = 0; i < dimension; i++) {
      for(int j = 0; j < dimension; j++) {
        qMatrix[i][j] = 1 + (1 + i + j) * factor; 
      }
    }

    return qMatrix;
  }


public static int[][] quantize(int[][] DCTMatrix, int[][] qMatrix) {
    //divide the @DCTMatrix elements by the elements of the @qMatrix and returns the new resulting matrix

    /*
    if(DCTMatrix.length % qMatrix.length != 0 || DCTMatrix[0].length % qMatrix[0].length != 0) {
      throw new Exception("DCT Matrix does not match quantization matrix");
    }
    */

    int[][] result = new int[DCTMatrix.length][DCTMatrix[0].length];
    int dim = qMatrix.length;

    for(int i = 0, rows = result.length; i < rows; i++) {
      for(int j = 0, cols = result[0].length; j < cols; j++) {
        result[i][j] = DCTMatrix[i][j] / qMatrix[i % dim][j % dim];
      }
    }

    return result;
  }

public class JCompressor {
  //#test if should try byte, int or float for matrices

  //Constants
  private static final char BW_M = 0;  //black and white
  private static final char COLOR_M = 1;  //color
  private static final int DCTStandardSize = 8;

  /*Attributes*/

  private char colorMode = BW_M;
  private int blockSize = DCTStandardSize;
  private int qualityFactor = 5;
  private int quantizationMatrix[][];
  
  private PImage original;
  private PImage compressed;
  private int grayscale[][];
  private int red[][];
  private int green[][];
  private int blue[][];
  
  //compressed components
  private int compGrayscale[][];
  private int compRed[][];
  private int compGreen[][];
  private int compBlue[][];
  
  //modified width and height (to make it a multiple of the DCT block dimension)
  private int mWidth;
  private int mHeight;
  
  //DCT components
  private int DCTtable[][]; //verify if int or float to use here
  private int grayDCT[][]; 
  private int redDCT[][];
  private int greenDCT[][];
  private int blueDCT[][];

  //Quantized DCT components
  private int qGrayDCT[][]; 
  private int qRedDCT[][];
  private int qGreenDCT[][];
  private int qBlueDCT[][];
  
  public JCompressor(PImage img) {
    //#not written
    /*
    *  Copy reference to image
    *  generate matrices: grayscale, red, green and blue
    *  generate matrices DCTtable and qMatrix
    *  calculate DCT for grayscale, red, green and blue
    *  generate compressed components
    */
  }
  
  public void setColorMode(char mode) {
    //#not written
    colorMode = mode;
  }

  public int[][] DCT(int[][] original, float[][] DCTtable) {
    //#not written
    //returns DCT matrix of @original
    float[][] alpha = new float[DCTtable.length][DCTtable.length];

    //#formula to be checked
    for(int u = 0, dim = DCTtable.length; u < dim; u++) {
      for(int v = 0; v < dim; v++) {
        alpha[u][v] = ( 2 * (u == 0 ? 1/sqrt(2) : 1) * (v == 0 ? 1/sqrt(2) : 1) ) / dim;
      }
    }

    int[][] result = new int[original.length][original[0].length];

    for(int u = 0, rows = original.length; u < rows; i++) {
      for(int v = 0, cols = original[0].length; v < cols; v++) {
      }
    }
  }
  
  
  public void calculateDCT() {
    //#not written
  }

  public void setFactor(int factor) {
    //#not written
    qualityFactor = factor;
  }

  private void quantizeDCTs() {
    //quantizes all the DCT matrices
    qGrayDCT = quantize(grayDCT, quantizationMatrix);
    qRedDCT = quantize(redDCT, quantizationMatrix);
    qGreenDCT = quantize(greenDCT, quantizationMatrix);
    qBlueDCT = quantize(blueDCT, quantizationMatrix);
  }
}
