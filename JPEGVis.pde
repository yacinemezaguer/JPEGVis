
void setup() {
  size(300, 300);
  float[][] matrice = generateDCTtable(8);
  printMatrix(matrice);
  //#continue writting DCT method
}

void draw() {
  /*
  *  draw Graphical interface
  *  draw original image and compressed    
  */
  background(0);
  fill(255);
}

void keyPressed()
{    
  switch(key)
  {
  }
}

void mouseClicked() {
}

void printMatrix(int[][] matrix) {
  for (int[] row : matrix) {
    for (int elem : row) {
      print(elem + "\t");
    }
    println();
  }
}

void printMatrix(float[][] matrix) {
  for (float[] row : matrix) {
    for (float elem : row) {
      print(elem + "\t");
    }
    println();
  }
}
