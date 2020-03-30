import controlP5.*;

ControlP5 cp5;

PImage original = null;
PImage compressed = null;
void setup() {
  size(300, 300);
  surface.setResizable(true);
  surface.setSize((int) (displayWidth * 0.8), (int) (displayHeight * 0.8));
  surface.setLocation(50, 50);

  cp5 = new ControlP5(this);

  cp5.addButton("importButton")
     .setPosition(15,15)
     .setSize(100,30)
     .setCaptionLabel("import")
     .setColor(new CColor(color(120), color(80), color(160), color(210), color(210))) //foreground, background, active, captionLabel, valueLabel
     .getCaptionLabel().setFont(new ControlFont(createFont("Calibri",20)))
     ;
  original = loadImage("img.png");
  compressed = original;
  /*
  img = loadImage("img.png");
  JCompressor jc = new JCompressor(img, 0, JCompressor.CLR_M);
  comp = jc.getCompressed();
  */
}

void draw() {
  background(30);
  if(original != null) {
    image(original, 10, 80);
  }

  if(compressed != null) {
    image(compressed, 40 + original.width, 80);
  }
  //image(img, 0, 0);
  /*
  *  draw Graphical interface
  *  draw original image and compressed    
  */
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

void importButton() {
  println("pressed Import button");
  selectInput("importer une image", "importImage");
}

void importImage(File selection) {
  println(selection.getAbsolutePath());
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
