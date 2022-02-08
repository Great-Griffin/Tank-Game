/*
void p1Tank(){
if(tankInHand == true){
    if(distanceRemaining > 0){
      travelRemaining = distanceRemaining;
    }else{
      travelRemaining = maxTravel;
    }
    if(dist(p1X, p1Y, mouseX, mouseY) < travelRemaining){
      
      tankX = mouseX;
      tankY = mouseY;
      
      overPlaced = false;
      //dotted line
      Travel = dist(p1X, p1Y, mouseX, mouseY);
      dotSpacing = dist(p1X, p1Y, mouseX, mouseY)/(space);
      for (int i = 0; i <= dotSpacing; i++) {
        float x = lerp(p1X, mouseX, i/dotSpacing);
        float y = lerp(p1Y, mouseY, i/dotSpacing);
        stroke(0);
        strokeWeight(2);
        strokeCap(ROUND);
        point(x, y);
      }
    }else{
      //dotted line
      overTravel = dist(p1X, p1Y, mouseX, mouseY);
      maxX = lerp(p1X, mouseX, travelRemaining/overTravel);
      maxY = lerp(p1Y, mouseY, travelRemaining/overTravel);
      dotSpacing = dist(p1X, p1Y, maxX, maxY)/(space);
      for (int i = 0; i <= dotSpacing; i++) {
        float x = lerp(p1X, maxX, i/dotSpacing);
        float y = lerp(p1Y, maxY, i/dotSpacing);
        stroke(0);
        strokeWeight(2);
        strokeCap(ROUND);
        point(x, y);
      }
      
      tankX = int(maxX);
      tankY = int(maxY);
      
      overPlaced = true;
    }
  }else{
    //display player1's tank at its current position
    tankX = p1X;
    tankY = p1Y;
  }
}
*/

/*
void p1GrabTank(){
  if(mouseX < p1X+space && mouseX > p1X-space && mouseY < p1Y+3/2*space && mouseY > p1Y-3/2*space){
    tankInHand = true;
  }else if(tankInHand == true){
    if(overPlaced == false){
      distanceRemaining = travelRemaining-dist(p1X, p1Y, mouseX, mouseY);
      
      p1X = mouseX;
      p1Y = mouseY;
      
    }else if(overPlaced == true){
      distanceRemaining = 0;
      
      p1X = int(maxX);
      p1Y = int(maxY);
      
      
      tankInHand = false;
      tankShoot = true;
    }
  }else if(tankShoot == true){
    tankShotX = mouseX;
    tankShotY = mouseY;
    travelDistance = dist(mouseX, mouseY, p1X, p1Y);
    tankShoot = false;
    tankShot = true;
    distanceRemaining = maxTravel;
  }
}
*/
