abstract class ShapeWalk {
/* Constructor Data */
  int maxSteps;
  int stepRate;
  int stepSize;
  float stepScale;
  boolean constrain;
  boolean terrain;
  boolean stroke;
  boolean seed;
  
/* Other Data */
  int steps = 0;
  int randStep;
  float xPos = (width + width/6)/2;
  float yPos = height/2;
  float xScale, yScale;
  boolean northBoundCheck, eastBoundCheck, southBoundCheck, westBoundCheck;
  PVector first;
  PVector c;
  HashMap<PVector, Integer> visits;
  
  abstract void draw();
  
  // Colors a shape at the given coordinates
  void shapeColor(PVector currCoords) {
    /** Terrain **/
    // Normalize the coords to ints to reduce floating point errors
    // if the shape isn't a square.
    PVector correctCoords;
    if (!boxy) correctCoords = new PVector(int(currCoords.x), int(currCoords.y));
    else correctCoords = currCoords;
    if (terrain) { 
      Integer count = visits.get(correctCoords);
       if (count == null) visits.put(correctCoords, 1);
      else visits.put(correctCoords, count + 1);
      fill(terrainColor(correctCoords, visits));
    }
    else fill(color(167, 100, 200));
    
    /** Stroke **/
    if (stroke) stroke(0);
    else noStroke();
  }
  color terrainColor(PVector currCoords, HashMap<PVector, Integer> visits) {
    color terrainColor;
    if (visits.get(currCoords) < 4) terrainColor = color(160, 126, 84);
    else if (visits.get(currCoords) < 7) terrainColor = color(143, 170, 64);
    else if (visits.get(currCoords) < 10) terrainColor = color(134, 134, 134);
    else {
      Integer scale = visits.get(currCoords) * 20;
      if (scale > 255) scale = 255;
      terrainColor = color(scale);
    }
    return terrainColor;
  }
}
