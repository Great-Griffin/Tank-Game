int counter;
boolean wallEncountered = false;

void drawTanks(){
  for(int t = 0; t < 2; t++){
    
    if(tankState[t] == 1){
      tankAngle[t] = atan2(mouseY-tankY[t], mouseX-tankX[t]);
    }else if(tankState[t] == 2){
      tankX[t] = lerp(preTransitX, transitX, travel/tankTravelDistance);
      tankY[t] = lerp(preTransitY, transitY, travel/tankTravelDistance);
      travel+=3;
      if(travel >= tankTravelDistance){
        travel = 0;
        tankTravelDistance = 0;
        tankState[t] = 1;
      }
    }
    
    if(turnState == 1 && t == 0){
      if(counter < 60){
        stroke(255, 0, 0);
        fill(255, 0, 0);
      }else if(count >= 60){
        stroke(0);
        fill(0);
      }
    }else if(turnState == 4 && t == 1){
      if(counter < 60){
        stroke(255, 0, 0);
        fill(255, 0, 0);
      }else if(count >= 60){
        stroke(0);
        fill(0);
      }
    
    }else{
      stroke(0);
      fill(0);
    }
    
    if(counter < 120){
      counter++;
    }else{
      counter = 0;
    }
    
    //stroke(0);
    pushMatrix();
    translate(tankX[t], tankY[t]);
    rotate(tankAngle[t]+PI/2);
    strokeWeight(2);
    rect(0, 0, 3*space/2, space*2);
    strokeWeight(5);
    strokeCap(SQUARE);
    line(0, 0, 0, -23*space/10);
    popMatrix();
  }
}

void drawTrajectory(){
  wallEncountered = false;
  for(int t = 0; t < 2; t++){
    if(tankState[t] == 1){
      distance = dist(tankX[t], tankY[t], mouseX, mouseY);
      
      //draw 
      if(distance <= distanceRemaining){
        moveX = mouseX;
        moveY = mouseY;
      }else if(distance > distanceRemaining){
        moveX = lerp(tankX[t], mouseX, distanceRemaining/distance);
        moveY = lerp(tankY[t], mouseY, distanceRemaining/distance);
      }
      
      dotSpacing = dist(tankX[t], tankY[t], moveX, moveY)/10*space;
      for(int i = 0; i < hRes; i++){
        for(int j = 0; j < vRes; j++){
          if(board[i][j] > 0){
            for (int d = 0; d <= dotSpacing; d++) {
              float x = lerp(tankX[t], moveX, d/dotSpacing);
              float y = lerp(tankY[t], moveY, d/dotSpacing);
              if(dist(x, y, space/2+i*space, space/2+j*space) < 2*space && wallEncountered == false){
                
                //moveX = x;
                //moveY = Y;
                
                
                noFill();
                stroke(255, 0, 0);
                strokeWeight(1);
                ellipse(x, y, 2*space, 2*space);
                
                wallEncountered = true;
                if(i == 1-hRes && j == 1-vRes){
                  wallEncountered = false;
                }
              }
            }
          }
        }
      }
      
      //draw dotted line
      dotSpacing = dist(tankX[t], tankY[t], moveX, moveY)/space;
      for (int d = 0; d <= dotSpacing; d++) {
        float x = lerp(tankX[t], moveX, d/dotSpacing);
        float y = lerp(tankY[t], moveY, d/dotSpacing);
        stroke(0);
        strokeWeight(2);
        strokeCap(ROUND);
        point(x, y);
      }
      //draw tank preview
      pushMatrix();
      translate(moveX, moveY);
      rotate(tankAngle[t]+PI/2);
      strokeWeight(2);
      noFill();
      rect(0, 0, 3*space/2, space*2);
      popMatrix();
    }
  }
}

//dotted line
/*

      if(dist(tankX[t], tankY[t], mouseX, mouseY) < travelRemaining){
        
        tankX[t] = mouseX;
        tankY[t] = mouseY;
        
        //dotted line
        Travel = dist(tankX[t], tankY[t], mouseX, mouseY);
        dotSpacing = dist(tankX[t], tankY[t], mouseX, mouseY)/(space);
        for (int i = 0; i <= dotSpacing; i++) {
          float x = lerp(tankX[t], mouseX, i/dotSpacing);
          float y = lerp(tankY[t], mouseY, i/dotSpacing);
          stroke(0);
          strokeWeight(2);
          strokeCap(ROUND);
          point(x, y);
        }
      }else{
        //dotted line
        overTravel = dist(tankX[t], tankY[t], mouseX, mouseY);
        maxX = lerp(tankX[t], mouseX, travelRemaining/overTravel);
        maxY = lerp(tankY[t], mouseY, travelRemaining/overTravel);
        dotSpacing = dist(tankX[t], tankY[t], maxX, maxY)/(space);
        for (int i = 0; i <= dotSpacing; i++) {
          float x = lerp(tankX[t], maxX, i/dotSpacing);
          float y = lerp(tankY[t], maxY, i/dotSpacing);
          stroke(0);
          strokeWeight(2);
          strokeCap(ROUND);
          point(x, y);
        }
        
        tankX[t] = int(maxX);
        tankY[t] = int(maxY);
        
      }

*/
