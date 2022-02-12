int counter;
float wallEncounter;
boolean wallEncountered = false;

void drawTanks(){
  for(int t = 0; t < 2; t++){
    if(tankState[t] == 1 || tankState[t] == 3){
      tankAngle[t] = atan2(mouseY-tankY[t], mouseX-tankX[t]);
    }else if(tankState[t] == 2){
      tankX[t] = lerp(preTransitX, transitX, travel/tankTravelDistance);
      tankY[t] = lerp(preTransitY, transitY, travel/tankTravelDistance);
      travel+=3;
      if(travel >= tankTravelDistance){
        travel = 0;
        tankTravelDistance = 0;
        if(distanceRemaining == 0){
          tankState[t] = 3;
        }else{
        tankState[t] = 1;
        }
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
    pushMatrix();
    translate(tankX[t], tankY[t]);
    rotate(tankAngle[t]+PI/2);
    strokeWeight(2);
    rect(0, 0, 3*space/2, space*2);
    strokeWeight(space/3);
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
      if(distance <= distanceRemaining){
        moveX = mouseX;
        moveY = mouseY;
        dotSpacing = dist(tankX[t], tankY[t], moveX, moveY)/space;
        wallEncounter = dist(tankX[t], tankY[t], moveX, moveY)/(space/10);
      }else if(distance > distanceRemaining){
        moveX = lerp(tankX[t], mouseX, distanceRemaining/distance);
        moveY = lerp(tankY[t], mouseY, distanceRemaining/distance);
        dotSpacing = round(dist(tankX[t], tankY[t], moveX, moveY)/space)+0.01;
        wallEncounter = dist(tankX[t], tankY[t], moveX, moveY)/(space/10);
      }
      
      for(int d = 0; d <= wallEncounter; d++) {
        float x = lerp(tankX[t], moveX, d/wallEncounter);
        float y = lerp(tankY[t], moveY, d/wallEncounter);  
        for(int i = 0; i < hRes; i++){
          for(int j = 0; j < vRes; j++){
            if(board[i][j] > 0){
              if(dist(x, y, space/2+i*space, space/2+j*space) < 2*space && wallEncountered == false){
                moveX = x;
                moveY = y;
                dotSpacing = dist(tankX[t], tankY[t], moveX, moveY)/space;
                wallEncountered = true;
                if(i == 1-hRes && j == 1-vRes){
                  wallEncountered = false;
                }
              }
            }
          }
        }
      }
      
      for(int d = 0; d <= dotSpacing; d++) {
        float x = lerp(tankX[t], moveX, d/dotSpacing);
        float y = lerp(tankY[t], moveY, d/dotSpacing);
        stroke(0);
        strokeWeight(2);
        strokeCap(ROUND);
        point(x, y);
      }
      pushMatrix();
      translate(moveX, moveY);
      rotate(tankAngle[t]+PI/2);
      strokeWeight(2);
      noFill();
      rect(0, 0, 3*space/2, space*2);
      popMatrix();
    }
  }
  
  for(int t = 0; t < 2; t++){
    if(tankState[t] == 3){
      distance = dist(tankX[t], tankY[t], mouseX, mouseY);
      if(distance <= 10*space){
        slope = (mouseY-tankY[t])/( mouseX-tankX[t]);
        if(mouseX-tankX[t] >= 0){
          moveX = tankX[t]+(10*space*sqrt(1+slope*slope)/(1+slope*slope));
          moveY = tankY[t]+((10*space*sqrt(1+slope*slope)/(1+slope*slope))*slope);
        }else{
          moveX = tankX[t]-(10*space*sqrt(1+slope*slope)/(1+slope*slope));
          moveY = tankY[t]-((10*space*sqrt(1+slope*slope)/(1+slope*slope))*slope);
        }
        dotSpacing = round(dist(tankX[t], tankY[t], moveX, moveY)/space)+0.01;
        for(int d = 0; d <= dotSpacing; d++) {
          float x = lerp(tankX[t], moveX, d/dotSpacing);
          float y = lerp(tankY[t], moveY, d/dotSpacing);
          stroke(0);
          strokeWeight(2);
          strokeCap(ROUND);
          point(x, y);
        }
      }else{
        
        //mouse out of range
        if(counter < 60){
          noFill();
          strokeWeight(1);
          stroke(255, 0, 0);
          ellipse(tankX[t], tankY[t], 20*space, 20*space);
        }
      }
    }
  }
}
