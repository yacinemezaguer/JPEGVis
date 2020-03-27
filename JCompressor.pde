
public class JCompressor {
  //#test if should try byte, int or float for matrices
  //#next to write: reverseDCT

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
  //verify if int or float to use here
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
    //#not finished
    original = img;
    mWidth = original.width + (blockSize - original.width % blockSize);
    mHeight = original.height + (blockSize - original.height % blockSize);

    grayscale = toIntMatrix('l');
    red = toIntMatrix('r');
    green = toIntMatrix('g');
    blue = toIntMatrix('b');

    calculateDCTs();
    quantizationMatrix = generateQMatrix(blockSize, qualityFactor);
    quantizeDCTs();
  
    /*
    *  Copy reference to image
    *  generate matrices: grayscale, red, green and blue
    *  generate qMatrix
    *  calculate DCT for grayscale, red, green and blue
    *  generate compressed components
    */
  }
  
  public void setColorMode(char mode) {
    //#not written
    colorMode = mode;
  }

  private int[][] toIntMatrix(char colorSpace) {
    //Returns a matrix of the image in the right color space (mWidth * mHeight compatible with blockSize)
    original.loadPixels();
    int[][] result = new int[mHeight][mWidth];
    
    switch (colorSpace) {
    case 'L': //luminance (gray)
    case 'l':
      for(int i = 0; i < original.height; i++) {
        for(int j = 0; j < original.width; j++) {
          result[i][j] = (int) brightness(original.pixels[i*original.width + j]);
        }
      }
      break;

    case 'R': //red
    case 'r':
      for(int i = 0; i < original.height; i++) {
        for(int j = 0; j < original.width; j++) {
          result[i][j] = (int) red(original.pixels[i*original.width + j]);
        }
      }
      break;

    case 'G': //green
    case 'g':
      for(int i = 0; i < original.height; i++) {
        for(int j = 0; j < original.width; j++) {
          result[i][j] = (int) green(original.pixels[i*original.width + j]);
        }
      }
      break;

    case 'B': //blue
    case 'b':
      for(int i = 0; i < original.height; i++) {
        for(int j = 0; j < original.width; j++) {
          result[i][j] = (int) blue(original.pixels[i*original.width + j]);
        }
      }
      break;

    default:
      return null;
    }

    //Filling missing columns (if width not multiple of blockSize)
    for(int i = 0; i < original.height; i++) {
      for(int j = original.width; j < mWidth ; j++) {
        result[i][j] = color(128);
      }
    }

    //Filling missing rows (if height not multiple of blockSize)
    for(int i = original.height; i < mHeight; i++) {
      for(int j = 0; j < mWidth ; j++) {
        result[i][j] = color(128);
      }
    }

    return result;
  }

  public int[][] reverseDCT(int[][] DCT, float[][] DCTCosTable) {
    //returns the resulting image of @DCT matrix
    int[][] result = new int[DCT.length][DCT[0].length];
    float[][] alpha = new float[DCTCosTable.length][DCTCosTable.length];

    int dim = DCTCosTable.length;

    //left part of the formula (inside the double sum) #formula to be checked
    for(int u = 0; u < dim; u++) {
      for(int v = 0; v < dim; v++) {
        alpha[u][v] = (u == 0 ? 1.0/sqrt(2) : 1.0) * (v == 0 ? 1.0/sqrt(2) : 1.0);
      }
    }

    //loop through image blocks (dim * dim) bi = block row, bj = block column
    for(int bi = 0, rows = DCT.length; bi < rows; bi += dim) {
      for(int bj = 0, cols = DCT[0].length; bj < cols; bj += dim) {

        //loop through elements of one block (dim * dim)
        for(int x = 0; x < dim; x++) {
          for(int y = 0; y < dim; y++) {
            
            float sum = 0;
            for(int u = 0; u < dim; u++) {
              for(int v = 0; v < dim; v++) {
                sum += alpha[u][v] * DCT[bi + u][bj + v] * DCTCosTable[x][u] * DCTCosTable[y][v];
              }
            }

            result[bi + x][bj + y] = (int) (sum / sqrt(2*dim));
          }
        }

      }
    }

    return result;
  }

  public int[][] DCT(int[][] original, float[][] DCTCosTable) {
    //returns DCT matrix of @original
    int[][] result = new int[original.length][original[0].length];
    float[][] alpha = new float[DCTCosTable.length][DCTCosTable.length];

    int dim = DCTCosTable.length;
    //left part of the formula (before the double sum) #formula to be checked
    for(int u = 0; u < dim; u++) {
      for(int v = 0; v < dim; v++) {
        alpha[u][v] = ( 2 * (u == 0 ? 1.0/sqrt(2) : 1.0) * (v == 0 ? 1.0/sqrt(2) : 1.0) ) / dim;
      }
    }

    //loop through image blocks (dim * dim) bi = block row, bj = block column
    for(int bi = 0, rows = original.length; bi < rows; bi += dim) {
      for(int bj = 0, cols = original[0].length; bj < cols; bj += dim) {

        //loop through elements of one block (dim * dim)
        for(int u = 0; u < dim; u++) {
          for(int v = 0; v < dim; v++) {
            
            float sum = 0;
            for(int x = 0; x < dim; x++) {
              for(int y = 0; y < dim; y++) {
                sum += original[bi + x][bj + y] * DCTCosTable[x][u] * DCTCosTable[y][v];
              }
            }

            result[bi + u][bj + v] = (int) (alpha[u][v] * sum);
          }
        }

      }
    }

    return result;
  }
  
  public void calculateDCTs() {
    //Calculates the DCT table of all color spaces (gray, red, green and blue DCT)
    float[][] DCTCosTable = generateDCTtable(blockSize);
    grayDCT = DCT(grayscale, DCTCosTable);
    redDCT = DCT(red, DCTCosTable);
    greenDCT = DCT(green, DCTCosTable);
    blueDCT = DCT(blue, DCTCosTable);
  }

  public void setFactor(int factor) {
    qualityFactor = factor;

    quantizationMatrix = generateQMatrix(blockSize, qualityFactor);
    calculateDCTs();
    quantizeDCTs();

    /*
    *re-generate quantization table [Done]
    *re-calculate DCT tables [Done]
    *re-quantize DCT tables [Done]
    *re-generate compressed matrices #
    */
  }

  private void quantizeDCTs() {
    //quantizes all the DCT matrices
    qGrayDCT = quantize(grayDCT, quantizationMatrix);
    qRedDCT = quantize(redDCT, quantizationMatrix);
    qGreenDCT = quantize(greenDCT, quantizationMatrix);
    qBlueDCT = quantize(blueDCT, quantizationMatrix);
  }
}

public static float[][] generateDCTtable(int size) {
  //precalculates the cosine part of the DCT formula and returns the matrix (cos[x][u])
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
    /*divides and re-multiplies the @DCTMatrix elements by the elements of the @qMatrix and returns the new resulting matrix
      so that high frequency coeffs are set to 0
    */

    /*
    if(DCTMatrix.length % qMatrix.length != 0 || DCTMatrix[0].length % qMatrix[0].length != 0) {
      throw new Exception("DCT Matrix does not match quantization matrix");
    }
    */

    int[][] result = new int[DCTMatrix.length][DCTMatrix[0].length];
    int dim = qMatrix.length;

    for(int i = 0, rows = result.length; i < rows; i++) {
      for(int j = 0, cols = result[0].length; j < cols; j++) {
        result[i][j] = (DCTMatrix[i][j] / qMatrix[i % dim][j % dim]) * qMatrix[i % dim][j % dim];
      }
    }

    return result;
  }
