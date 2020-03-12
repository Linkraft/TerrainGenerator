class HexWalk extends ShapeWalk {
  float radius;
  float hexStep;
  HexWalk(int maxSteps, int stepRate, int stepSize, float stepScale, boolean constrain, 
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
    radius = (stepSize * width/120)/10;
    hexStep = radius * stepScale;
  }
  void draw() {
    if (steps < maxSteps) {
      if (steps == 0) drawHex(first = new PVector(xPos, yPos), radius);
      for (int i = 0; i < stepRate; i++) {
        if (steps < maxSteps) {
          randStep = int(random(0, 6));
          if (constrain) { // If the next step is not out of bounds, draw it.
            // The distances between the center of the hexagon and the edge of
            // the next possible hexagon to be drawn, which differs based on 
            // whether or not the hexagon is to be drawn in a vertical direction
            // or in a horizontal direction relative to the current hexagon.
            xScale = hexStep * 2.5;
            yScale = hexStep * sqrt(3) * 1.5;
            
            // These booleans check if the next step should be drawn
            // in a particular cardinal direction.
            northBoundCheck = (yPos - yScale) > 0;
            southBoundCheck = (yPos + yScale) < height;
            eastBoundCheck = (xPos + xScale) < width;
            westBoundCheck = (xPos - xScale) > width/6;
            switch(randStep) {
              case 0: // Go South-East
                if (southBoundCheck && eastBoundCheck)
                  drawHexNeighbor(c = new PVector(xPos, yPos), radius, 30);
                break;
              case 1: // Go South
                if (southBoundCheck)
                  drawHexNeighbor(c = new PVector(xPos, yPos), radius, 90);
                break;
              case 2: // Go South-West
                if (southBoundCheck && westBoundCheck)
                  drawHexNeighbor(c = new PVector(xPos, yPos), radius, 150);
                break;
              case 3: // Go North-West
                if (northBoundCheck && westBoundCheck)
                  drawHexNeighbor(c = new PVector(xPos, yPos), radius, 210);
                break;
              case 4: // Go North
                if (northBoundCheck)
                  drawHexNeighbor(c = new PVector(xPos, yPos), radius, 270);
                break;
              case 5: // Go North-East
                if (northBoundCheck && eastBoundCheck)
                  drawHexNeighbor(c = new PVector(xPos, yPos), radius, 330);
                break;
            }
          }
          else {
            switch(randStep) {
              case 0: // Go South-East
                  drawHexNeighbor(c = new PVector(xPos, yPos), radius, 30);
                break;
              case 1: // Go South
                  drawHexNeighbor(c = new PVector(xPos, yPos), radius, 90);
                break;
              case 2: // Go South-West
                  drawHexNeighbor(c = new PVector(xPos, yPos), radius, 150);
                break;
              case 3: // Go North-West
                  drawHexNeighbor(c = new PVector(xPos, yPos), radius, 210);
                break;
              case 4: // Go North
                  drawHexNeighbor(c = new PVector(xPos, yPos), radius, 270);
                break;
              case 5: // Go North-East
                  drawHexNeighbor(c = new PVector(xPos, yPos), radius, 330);
                break;
            }
          }
        }
      }
    }
  }
  void drawHex(PVector c, float r) {
    beginShape();
    for (int i = 0; i < 6; i++) { // Draws vertices around the center point
      float hexX = c.x + cos(radians(60 * i)) * r;
      float hexY = c.y + sin(radians(60 * i)) * r;
      vertex(hexX, hexY);
    }
    endShape(CLOSE);
    shapeColor(c);
    steps++;
  }
  void drawHexNeighbor(PVector c, float r, int theta) {
    float angle = radians(theta);
    float d = sqrt(3) * r * stepScale;
    PVector newC;
    float newX = c.x + cos(angle) * d;
    float newY = c.y + sin(angle) * d;
    newC = new PVector(newX, newY);
    drawHex(newC, r);
    xPos = newX;
    yPos = newY;
  }
}
