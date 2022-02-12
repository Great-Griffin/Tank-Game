void drawButtons(){
  stroke(0);
  strokeWeight(2);
  
  //EXIT BUTTON
  textSize(16*space/5);
  fill(255);
  rect(width-buttonX, buttonY, buttonWidth, buttonHeight);
  textAlign(CENTER, CENTER);
  fill(0);
  text("EXIT", width-buttonX, buttonY-space/2);
    
  if(turnState == 0){
    
    //START GAME BUTTON
    textSize(14*space/5);
    fill(255);
    rect(buttonX, height-buttonY, buttonWidth, buttonHeight);
    textAlign(CENTER, CENTER);
    fill(0);
    text("START", buttonX, height-buttonY-space/2);
    
    //RANDOM MAP BUTTON
    textSize(2*space);
    fill(255);
    rect(buttonX, buttonY, buttonWidth, buttonHeight);
    textAlign(CENTER, CENTER);
    fill(0);
    text("RANDOM", buttonX, buttonY-space);
    text("MAP", buttonX, buttonY+space/2);
    
    //DRAW MODE BUTTON
    fill(255);
    rect(width-buttonX, height-buttonY, buttonWidth, buttonHeight);
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
    textAlign(CENTER, CENTER);
    fill(0);
    text("DRAW", width-buttonX, height-buttonY-9*space/8);
    text("MODE", width-buttonX, height-buttonY+3*space/8);
    
  }else{
  
    //PASS TURN BUTTON
    textSize(16*space/5);
    fill(255);
    rect(buttonX, height-buttonY, buttonWidth, buttonHeight);
    textAlign(CENTER, CENTER);
    fill(0);
    text("PASS", buttonX, height-buttonY-space/2);
    
    //Remaining travel distance
    textSize(8*space/5);
    fill(255);
    rect(buttonX, buttonY, buttonWidth, buttonHeight);
    textAlign(CENTER, CENTER);
    fill(0);
    text(int(distanceRemaining/space), buttonX, buttonY-space);
    text("REMAINING", buttonX, buttonY+space/2);
    
    //Turn indicator
    if(turnState > 3){
      turn = "P2";
    }else{
      turn = "P1";
    }
    textSize(16*space/5);
    fill(255);
    rect(width-buttonX, height-buttonY, buttonWidth, buttonHeight);
    textAlign(CENTER, CENTER);
    fill(0);
    text(turn, width-buttonX, height-buttonY-space/2);
  }
}
