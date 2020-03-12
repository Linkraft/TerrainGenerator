class SquareWalk extends ShapeWalk {
  int xSide, ySide;
  float xStep, yStep;
  SquareWalk(int maxSteps, int stepRate, int stepSize, float stepScale, boolean constrain,
             boolean terrain, boolean stroke, boolean seed, int seedVal) {
    this.maxSteps = maxSteps;
    this.stepRate = stepRate;
    this.stepSize = stepSize;
    this.stepScale = stepScale;
    this.constrain = constrain;
    this.terrain = terrain;
    this.stroke = stroke;
    if (seed) randomSeed(seedVal);
    visits = new HashMap<PVector, Integer>();        
    xSide = (this.stepSize * width/120)/10;
    ySide = (this.stepSize * height/100)/10;
    xStep = xSide * this.stepScale;
    yStep = ySide * this.stepScale;
  }
  void draw() {
    rectMode(CENTER);
    if (steps < maxSteps) {
      if (steps == 0) shapeColor(first = new PVector(xPos, yPos));
      for (int i = 0; i < stepRate; i++) {
        if (steps < maxSteps) {
          println("Step: " + (steps + 1));
          randStep = int(random(0, 4));
          if (constrain) {
            xScale = xStep * 1.5;
            yScale = yStep * 1.5;
            // Bounds of the drawing space
            northBoundCheck = (yPos - yScale) > 0;
            eastBoundCheck = (xPos + xScale) < width;
            southBoundCheck = (yPos + yScale) < height;
            westBoundCheck = (xPos - xScale) > width/6;
            switch(randStep) { 
              case 0: // Go North
                if (northBoundCheck) {
                  yPos -= yStep;
                  steps++;
                  rect(xPos, yPos, xSide, ySide);
                }
                break;
              case 1: // Go East
                if (eastBoundCheck) {
                  xPos += xStep;
                  steps++;
                  rect(xPos, yPos, xSide, ySide);
                }
                break;
              case 2: // Go South
                if (southBoundCheck) {
                  yPos += yStep;
                  steps++;
                  rect(xPos, yPos, xSide, ySide);
                }
                break;
              case 3: // Go West
                if (westBoundCheck) {
                  xPos -= xStep;
                  steps++;
                  rect(xPos, yPos, xSide, ySide);
                }
                break;
            }
          }
          else {
            switch(randStep) {
              case 0: // Go North
                yPos -= yStep;
                break;
              case 1: // Go East
                xPos += xStep;
                break;
              case 2: // Go South
                yPos += yStep;
                break;
              case 3: // Go West
                xPos -= xStep;
                break;
            }
            steps++;
            rect(xPos, yPos, xSide, ySide);
          }
          c = new PVector(xPos, yPos);
          shapeColor(c);
        }
      }
    }
  }
}
