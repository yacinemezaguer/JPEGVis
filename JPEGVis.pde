
PImage img;
PImage comp;
void setup() {
  size(300, 300);
  surface.setResizable(true);
  img = loadImage("img.png");
  JCompressor jc = new JCompressor(img, 0, JCompressor.CLR_M);
  comp = jc.getCompressed();
  surface.setSize(img.width, img.height);
}

void draw() {
  //image(img, 0, 0);
  image(comp, 0, 0);
  /*
  *  draw Graphical interface
  *  draw original image and compressed    
  */
  //background(0);
  //fill(255);
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
