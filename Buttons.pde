void drawButtons(){
  textAlign(CENTER, CENTER);
  stroke(0);
  strokeWeight(2);
  fill(255);
  rect(width-buttonX, height-buttonY, buttonWidth, buttonHeight);
  rect(width-buttonX, buttonY, buttonWidth, buttonHeight);
  rect(buttonX, height-buttonY, buttonWidth, buttonHeight);
  rect(buttonX, buttonY, buttonWidth, buttonHeight);
  fill(0);
  
  //EXIT BUTTON
  textSize(16*space/5);
  text("EXIT", width-buttonX, buttonY-space/2);
    
  if(turnState == 0){
    
    //START GAME BUTTON
    textSize(14*space/5);
    text("START", buttonX, height-buttonY-space/2);
    
    //RANDOM MAP BUTTON
    textSize(2*space);
    text("RANDOM", buttonX, buttonY-space);
    text("MAP", buttonX, buttonY+space/2);
    
    //DRAW MODE BUTTON
    line(width-buttonX-15*space/4, height-buttonY-7*space/4, width-buttonX-space, height-buttonY-7*space/4);
    line(width-buttonX-15*space/4, height-buttonY-7*space/4, width-buttonX-15*space/4, height-buttonY-space/2);
    if(drawMode == 1){
      line(width-buttonX-15*space/4, height-buttonY+7*space/4, width-buttonX-space, height-buttonY+7*space/4);
      line(width-buttonX-15*space/4, height-buttonY+7*space/4, width-buttonX-15*space/4, height-buttonY+space/2);
    }else if(drawMode == 2){
      line(width-buttonX+15*space/4, height-buttonY-7*space/4, width-buttonX+space, height-buttonY-7*space/4);
      line(width-buttonX+15*space/4, height-buttonY-7*space/4, width-buttonX+15*space/4, height-buttonY-space/2);
    }else if(drawMode == 3){
      line(width-buttonX+15*space/4, height-buttonY+7*space/4, width-buttonX+space, height-buttonY+7*space/4);
      line(width-buttonX+15*space/4, height-buttonY+7*space/4, width-buttonX+15*space/4, height-buttonY+space/2);
    }
    textSize(2*space);
    text("DRAW", width-buttonX, height-buttonY-9*space/8);
    text("MODE", width-buttonX, height-buttonY+3*space/8);
    
  }else{
  
    textSize(16*space/5);
    text("PASS", buttonX, height-buttonY-space/2);
    
    //Select tank indicator
    if(turnState == 1 || turnState == 4){
      textSize(2*space);
      text("SELECT", buttonX, buttonY-space);
      text("TANK", buttonX, buttonY+space/2);
      
      //Remaining travel distance
    }else if(turnState == 2 || turnState == 5){
      textSize(8*space/5);
      text(int(distanceRemaining/space), buttonX, buttonY-space);
      text("REMAINING", buttonX, buttonY+space/2);
      
      //Aim out of Range
    }else if(turnState == 3 || turnState == 6){
      if(distance <= 10*space){
        textSize(12*space/5);
        text("SHOOT", buttonX, buttonY-space/2);
      }else{
        textSize(10*space/5);
        text("OUT OF", buttonX, buttonY-space);
        text("RANGE", buttonX, buttonY+space/2);
      }
    }
    
    //Turn indicator
    if(turnState > 3){
      turn = "P2";
    }else{
      turn = "P1";
    }
    textSize(16*space/5);
    text(turn, width-buttonX, height-buttonY-space/2);
  }
}
