/* 
 RECT/RECT COLLISION FUNCTION
 
 Takes 8 arguments:
 + x,y position of object 1
 + width and height of object 1
 + x,y position of object 2
 + width and height of object 2
 
 */
boolean rectRect(float x1, float y1, float w1, float h1, float x2, float y2, float w2, float h2) {

  // test for collision
  if (x1+w1/2 >= x2-w2/2 && x1-w1/2 <= x2+w2/2 && y1+h1/2 >= y2-h2/2 && y1-h1/2 <= y2+h2/2) {
    return true;
  } else {
    return false;
  }
}

/* 
 RECT/BALL COLLISION FUNCTION
 
 Takes 7 arguments:
 + x,y position of the first ball - in this case "you"
 + width and height of rect
 + x,y position of the second ball
 + diameter of second ball
 
 */
 
// Calculates the overlap of two objects in 1 dimension
// Provide the (x or y) coordinates of object0 (x0) and object1 (x1) and
// dimensions d0 and d1 (width or height) 
// returns 0 if no overlap 
float calculate1DOverlap(float p0, float p1, float d0, float d1) {
  float dl = p0+d0-p1, dr = p1+d1-p0;  
  return (dr<0 || dl<0) ? 0 : (dr >= dl) ? -dl : dr;
}

boolean rectBall(float rx, float ry, float rw, float rh, float bx, float by, float d) {

  // test edges (necessary when the rectangle is larger than the ball)

  // if ball's entire width position is between rect L/R sides
  if (bx+d/2 >= rx-rw/2 && bx-d/2 <= rx+rw/2 && abs(ry-by) <= d/2) {
    return true;
  }
  // if not, check if ball's height is between top/bottom of the rect
  else if (by+d/2 >= ry-rh/2 && by-d/2 <= ry+rh/2 && abs(rx-bx) <= d/2) {
    return true;
  }

  // if that doesn't return a hit, find closest corner (a point)
 
  // upper-left
  float xDist = (rx-rw/2) - bx;  // same as ball/ball, but first value defines point, not center
  float yDist = (ry-rh/2) - by;
  float shortestDist = sqrt((xDist*xDist) + (yDist * yDist));

  // upper-right
  xDist = (rx+rw/2) - bx;
  yDist = (ry-rh/2) - by;
  float distanceUR = sqrt((xDist*xDist) + (yDist * yDist));
  if (distanceUR < shortestDist) {  // if this new distance is shorter...
    shortestDist = distanceUR;      // ... update
  }

  // lower-right
  xDist = (rx+rw/2) - bx;
  yDist = (ry+rh/2) - by;
  float distanceLR = sqrt((xDist*xDist) + (yDist * yDist));
  if (distanceLR < shortestDist) {
    shortestDist = distanceLR;
  }

  // lower-left
  xDist = (rx-rw/2) - bx;
  yDist = (ry+rh/2) - by;
  float distanceLL = sqrt((xDist*xDist) + (yDist * yDist));
  if (distanceLL < shortestDist) {
    shortestDist = distanceLL;
  }

  // test collision
  if (shortestDist < d/2) {  // if less than radius
    return true;             // return true
  } else {                     // otherwise, return false
    return false;
  }
}

