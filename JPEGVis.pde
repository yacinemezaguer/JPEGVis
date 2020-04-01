import controlP5.*;

ControlP5 cp5;

PImage original = null;
PImage compressed = null;
JCompressor jc = null;

float displayRatio = 0.5;
void setup() {
  size(300, 300);
  surface.setResizable(true);
  surface.setSize((int) (displayWidth * 0.8), (int) (displayHeight * 0.8));
  surface.setLocation(50, 50);

  cp5 = new ControlP5(this);

  //Import button
  cp5.addButton("importButton")
     .setPosition(15,15)
     .setSize(100,30)
     .setCaptionLabel("import")
     .setColor(new CColor(color(120), color(80), color(160), color(210), color(210))) //foreground, background, active, captionLabel, valueLabel
     .getCaptionLabel().setFont(new ControlFont(createFont("Calibri",20)))
     ;


  //Set factor button
  cp5.addButton("setFactorButton")
     .setPosition(300,15)
     .setSize(110,30)
     .setCaptionLabel("Set Factor")
     .setColor(new CColor(color(120), color(80), color(160), color(210), color(210))) //foreground, background, active, captionLabel, valueLabel
     .getCaptionLabel().setFont(new ControlFont(createFont("Calibri",20)))
     ;

  //Compress button
  cp5.addButton("compressButton")
     .setPosition(500,15)
     .setSize(100,30)
     .setCaptionLabel("Compress")
     .setColor(new CColor(color(120), color(80), color(160), color(210), color(210))) //foreground, background, active, captionLabel, valueLabel
     .getCaptionLabel().setFont(new ControlFont(createFont("Calibri",20)))
     ;

  //Factor slider
  cp5.addSlider("factorSlider", 0, 20, 8, 140, 15, 130, 30)
     .setColor(new CColor(color(120), color(80), color(160), color(210), color(210)))
     .setCaptionLabel("Factor")
     .getCaptionLabel().setFont(new ControlFont(createFont("Calibri",20)));
  cp5.getController("factorSlider").getCaptionLabel().align(ControlP5.LEFT, ControlP5.BOTTOM_OUTSIDE).setPaddingX(0);
  cp5.getController("factorSlider").getValueLabel().setFont(new ControlFont(createFont("Calibri",20)))
     ;

  original = loadImage("img.png");
  jc = new JCompressor(original);
  compressed = jc.getCompressed();
}

void draw() {
  background(30);
  if(original != null) {
    image(original, 10, 80, width * displayRatio, height * displayRatio);
  }

  if(compressed != null) {
    image(compressed, 20 + width * displayRatio, 80, width * displayRatio, height * displayRatio);
  }
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

void setFactorButton() {
  if(jc != null) {
    jc.setFactor((int) cp5.getController("factorSlider").getValue());
    compressed = jc.getCompressed();
  }
}

void importImage(File selection) {
  println(selection.getAbsolutePath());
  original = loadImage(selection.getAbsolutePath());
  jc = new JCompressor(original);
  compressed = jc.getCompressed();
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
