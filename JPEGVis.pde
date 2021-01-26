import controlP5.*;
//#add zoom mode and color mode toggle buttons

ControlP5 cp5;

PImage original = null;
PImage compressed = null;
JCompressor jc = null;
ControlFont font = null;
Slider2D zoomMap = null;
int w, h;
boolean zoomMode = false;

float displayRatio = 0.5;
void setup() {
  size(300, 300);
  surface.setResizable(true);
  surface.setSize((int) (displayWidth * 0.8), (int) (displayHeight * 0.8));
  surface.setLocation(50, 50);
  registerMethod("pre", this);

  w = width;
  h = height;

  cp5 = new ControlP5(this);

  font = new ControlFont(createFont("Calibri",20));

  //Import button
  cp5.addButton("importButton")
     .setPosition(15,15)
     .setSize(100,30)
     .setCaptionLabel("import")
     .setColor(new CColor(color(120), color(80), color(160), color(210), color(210))) //foreground, background, active, captionLabel, valueLabel
     .getCaptionLabel().setFont(font)
     ;
   
  //Factor slider
  cp5.addSlider("factorSlider", 0, 100, 8, 200, 15, 130, 30)
     .setColor(new CColor(color(120), color(80), color(160), color(210), color(210)))
     .setCaptionLabel("Factor")
     .getCaptionLabel().setFont(new ControlFont(createFont("Calibri",20)));
  cp5.getController("factorSlider").getCaptionLabel().align(ControlP5.LEFT, ControlP5.LEFT_OUTSIDE).setPaddingX(-70);
  cp5.getController("factorSlider").getValueLabel().setFont(new ControlFont(createFont("Calibri",20)));
  
  //Factor text field
  cp5.addTextfield("factorTextField")
     .setPosition(350,15)
     .setSize(60,30)
     .setFont(font)
     .setCaptionLabel("")
     .setColor(new CColor(color(120), color(80), color(160), color(210), color(210)))
     .setText("8")
     .setFocus(true)
     .setInputFilter(ControlP5.INTEGER);
     ;

  //Set factor button
  cp5.addButton("setFactorButton")
     .setPosition(440,15)
     .setSize(110,30)
     .setCaptionLabel("Set Factor")
     .setColor(new CColor(color(120), color(80), color(160), color(210), color(210))) //foreground, background, active, captionLabel, valueLabel
     .getCaptionLabel().setFont(font)
     ;

  //Zoom button
  cp5.addButton("zoomButton")
     .setPosition(220, 185 + height * displayRatio)
     .setSize(100,30)
     .setCaptionLabel("Zoom")
     .setColor(new CColor(color(120), color(80), color(160), color(210), color(210))) //foreground, background, active, captionLabel, valueLabel
     .getCaptionLabel().setFont(font)
     ;

  //2D Slider (zoom map)
  zoomMap = cp5.addSlider2D("zoomMap")
         .setPosition(10, 100 + height * displayRatio)
         .setSize(200,200)
         .setMinMax(0,0,100,100)
         .setValue(50,50)
         .setColor(new CColor(color(120), color(80), color(160), color(210), color(210)))
         ;
  
  original = loadImage("img.png");
  jc = new JCompressor(original);
  compressed = jc.getCompressed();
}

void pre() {
  if(w != width || h != height) {
    println("changed");
    w = width;
    h = height;

    zoomMap.setPosition(10, 100 + height * displayRatio);
  }
}

void draw() {
  background(30);
  if(original != null) {
    if(zoomMode) {
      image(original.get((int) (zoomMap.getArrayValue()[0] * original.width / 100), (int) (zoomMap.getArrayValue()[1] * original.height / 100), 
        original.width/10, original.height/10), 10, 80, width * displayRatio, height * displayRatio);
    }else image(original, 10, 80, width * displayRatio, height * displayRatio);
  }

  if(compressed != null) {
    if(zoomMode) {
      image(compressed.get((int) (zoomMap.getArrayValue()[0] * original.width / 100), (int) (zoomMap.getArrayValue()[1] * original.height / 100), 
        original.width/10, original.height/10), 20 + width * displayRatio, 80, width * displayRatio, height * displayRatio);
    }else image(compressed, 20 + width * displayRatio, 80, width * displayRatio, height * displayRatio);
  }
}

void keyPressed()
{    
  switch(key)
  {
  }
}

void mouseClicked() {
}

public void importButton() {
  selectInput("importer une image", "importImage");
}

public void setFactorButton() {
  if(jc != null) {
    int fact = 0;
    String txt = cp5.get(Textfield.class,"factorTextField").getText();
    println(txt);

    if(txt != "") {
      fact = Integer.parseInt(txt);
    } else {
      fact = (int) cp5.getController("factorSlider").getValue();
    }
    
    jc.setFactor(fact);
    compressed = jc.getCompressed();
  }
}

public void zoomButton() {
  zoomMode = !zoomMode;
}

public void factorSlider(int theValue) {
  Textfield txt = ((Textfield)cp5.getController("factorTextField"));
  txt.setValue(""+theValue);
}

void importImage(File selection) {
  if(selection != null) {
    println(selection.getAbsolutePath());
    original = loadImage(selection.getAbsolutePath());
    jc = new JCompressor(original);
    compressed = jc.getCompressed();
  }
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
