import controlP5.*;

/*
   Desired resolution for this program is 1200 by 
   1000, and its scaling is based on some multiple
   of 1200 by 1000, so use other resolutions at
   your own risk! 
*/

/***** UI Variables *****/
ControlP5 cp5;
PShape UIrect;
DropdownList dropdown;
Slider maxStepsSldr, stepRateSldr, stepScaleSldr, stepSizeSldr;
Toggle constrainTgl, terrainTgl, strokeTgl, seedTgl;
Textfield seedTxtFld;
boolean start, boxy;

/***** ShapeWalk Variables *****/
ShapeWalk walker;
// Main variables that will be passed to ShapeWalk() object
int mainMaxSteps, mainStepRate, mainStepSize, mainSeedVal;
float mainStepScale;
boolean mainConstrain, mainTerrain, mainStroke, mainSeed;

void setup() {
  
  size(1200, 1000);      // <== Set Resolution Here!
  background(200);
  noStroke();
  fill(color(167, 100, 200));
  
/********** UI Setup **********/
  cp5 = new ControlP5(this);  
  boxy = true;
  
  /* UI Background Rectangle */
  UIrect = createShape(RECT, 0, 0, width/6, height);
  UIrect.setFill(100);
  UIrect.setStroke(true);
  
  /* Start Button */
  cp5.addButton("Start")
     .setPosition(width/120, height/100)   // (10, 10)
     .setSize(width/12, height/100 * 3)    // (10, 30)
     .setColorBackground(color(0, 150, 0))
     .getCaptionLabel()
     .setSize(height/100)
     ;
  
  /* Dropdown List */
  dropdown = cp5.addDropdownList("Squares")
                .setPosition(width/120, height/20)      // (10, 50)
                .setSize(width/30 * 4, height/100 * 12) // (160, 120)
                .setItemHeight(height/25)               // (40)       
                .setBarHeight(height/25)                // (40)
                ;
                
  dropdown.getCaptionLabel().setSize(height/100);
  dropdown.addItem("Squares", 0).getValueLabel().setSize(height/100);
  dropdown.addItem("Hexagons", 1).getValueLabel().setSize(height/100);

  /* Maximum Steps Slider */
  // Position: (10, 210) | Size: (180, 20)
  maxStepsSldr = cp5.addSlider("MaxSteps").setPosition(width/120, height/100 * 21).setSize(width/20 * 3, height/50);
  maxStepsSldr.getCaptionLabel().setVisible(false);
  maxStepsSldr.getValueLabel().setSize(height/100);
  maxStepsSldr.setRange(100, 50000);
  cp5.addTextlabel("Maximum Steps").setText("Maximum Steps").setPosition(width/120, height/100 * 20).getValueLabel().setSize(height/100);
  
  /* Step Rate Slider */
  // Position: (10, 250) | Size: (180, 20)
  stepRateSldr = cp5.addSlider("StepRate").setPosition(width/120, height/100 * 25).setSize(width/20 * 3, height/50);
  stepRateSldr.getCaptionLabel().setVisible(false);
  stepRateSldr.getValueLabel().setSize(height/100);
  stepRateSldr.setRange(1, 1000);
  cp5.addTextlabel("Step Rate").setText("Step Rate").setPosition(width/120, height/100 * 24).getValueLabel().setSize(height/100);
    
  /* Step Size Slider */
  // Position: (10, 320) | Size: (80, 20)
  stepSizeSldr = cp5.addSlider("StepSize").setPosition(width/120, height/100 * 32).setSize(width/15, height/50);
  stepSizeSldr.getCaptionLabel().setVisible(false);
  stepSizeSldr.getValueLabel().setSize(height/100);
  stepSizeSldr.setRange(10, 30);
  cp5.addTextlabel("Step Size").setText("Step Size").setPosition(width/120, height/100 * 31).getValueLabel().setSize(height/100);
  
  /* Step Scale Slider */
  // Position: (10, 360) | Size: (80, 20)
  stepScaleSldr = cp5.addSlider("StepScale").setPosition(width/120, height/100 * 36).setSize(width/15, height/50);
  stepScaleSldr.getCaptionLabel().setVisible(false);
  stepScaleSldr.getValueLabel().setSize(height/100);
  stepScaleSldr.setRange(1, 1.5);
  cp5.addTextlabel("Step Scale").setText("Step Scale").setPosition(width/120, height/100 * 35).getValueLabel().setSize(height/100);
  
  /* Constrain Steps Toggle */
  // Position: (10, 400) | Size: (20, 20)
  constrainTgl = cp5.addToggle("Constrain Steps").setPosition(width/120, height/100 * 40).setSize(width/120 * 2, height/100 * 2);
  constrainTgl.getCaptionLabel().setSize(height/100);
  mainConstrain = false;
  
  /* Simulate Terrain Toggle */
  // Position: (10, 440) | Size: (20, 20)
  terrainTgl = cp5.addToggle("Simulate Terrain").setPosition(width/120, height/100 * 44).setSize(width/120 * 2, height/100 * 2);
  terrainTgl.getCaptionLabel().setSize(height/100);
  mainTerrain = false;
  
  /* Use Stroke Toggle */
  // Position: (10, 480) | Size: (20, 20)
  strokeTgl = cp5.addToggle("Use Stroke").setPosition(width/120, height/100 * 48).setSize(width/120 * 2, height/100 * 2);
  strokeTgl.getCaptionLabel().setSize(height/100);
  mainStroke = false;
  
  /* Use Random Seed Toggle */
  // Position: (10, 520) | Size: (20, 20)
  seedTgl = cp5.addToggle("Use Random Seed").setPosition(width/120, height/100 * 52).setSize(width/120 * 2, height/100 * 2);
  seedTgl.getCaptionLabel().setSize(height/100);
  mainSeed = false;
  
  /* Seed Value Textfield */
  // Position: (80, 520) | Size: (40, 20)
  seedTxtFld = cp5.addTextfield("SeedValue").setPosition(width/120 * 12, height/100 * 52).setSize(width/120 * 5, height/100 * 2);
  seedTxtFld.getCaptionLabel().setSize(height/100);
  seedTxtFld.setInputFilter(ControlP5.INTEGER);
}

void draw() {
  shape(UIrect, 0, 0);
  if (walker != null) {
    walker.draw();
  }
}

/********** UI Setter Functions **********/
void MaxSteps(int input) { mainMaxSteps = input; }
void StepRate(int input) { mainStepRate = input; }
void StepSize(int input) { mainStepSize = input; }
void StepScale(float input) { mainStepScale = input; }
void SeedValue(String input) { mainSeedVal = Integer.parseInt(input); } // FIXME
void controlEvent(ControlEvent theEvent) {
  if (theEvent.isController()) {
    if (theEvent.getController().getName() == "Squares") {
      if (theEvent.getController().getValue() == 0) boxy = true;
      else boxy = false;
    }
  }
  if (theEvent.isFrom("Start")) {
    walker = null;
    start = true;
    if (boxy) {
      background(200);
      walker = new SquareWalk(mainMaxSteps, mainStepRate, mainStepSize, mainStepScale,
                              mainConstrain, mainTerrain, mainStroke, mainSeed, mainSeedVal);
    }
    else {
      background(50, 140, 210);
      walker = new HexWalk(mainMaxSteps, mainStepRate, mainStepSize, mainStepScale,
                           mainConstrain, mainTerrain, mainStroke, mainSeed, mainSeedVal);
    }
  }
  if (theEvent.isFrom("Constrain Steps")) {
    if (mainConstrain == false) mainConstrain = true;
    else mainConstrain = false;
  }
  if (theEvent.isFrom("Simulate Terrain")) {
    if (mainTerrain == false) mainTerrain = true;
    else mainTerrain = false;
  }
  if (theEvent.isFrom("Use Stroke")) {
    if (mainStroke == false) mainStroke = true;
    else mainStroke = false;
  }
  if (theEvent.isFrom("Use Random Seed")) {
    if (mainSeed == false) mainSeed = true;
    else mainSeed = false;
  }
}
