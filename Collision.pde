/* 
RECT/RECT COLLISION FUNCTION

Takes 8 arguments:
    + x,y position of object 1
    + width and height of object 1
    + x,y position of object 2
    + width and height of object 2
    
*/
boolean rectRect(int x1, int y1, int w1, int h1, int x2, int y2, int w2, int h2) {
    
    // test for collision
    if (x1+w1/2 >= x2-w2/2 && x1-w1/2 <= x2+w2/2 && y1+h1/2 >= y2-h2/2 && y1-h1/2 <= y2+h2/2) {
        return true;
    }
    else {
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

boolean rectBall(int rx, int ry, int rw, int rh, int bx, int by, int d) {

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
    }
    else {                     // otherwise, return false
        return false;
    }
}