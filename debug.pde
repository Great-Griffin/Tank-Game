int count, click;
float debugX, debugY;
String debug = "N/A";
//int countSetup, countDraw, countDrawGrid, countMousePressed, countMouseReleased, countDrawButtons, countDrawBoard, countDrag, countStartGame, countRandomMap, countDrawRandomMap, countDrawHUD, countClearTemp, countDebug, countDrawTanks, countDrawTrajectory, coundEndGame, countWin, countDrawBullet, countRicochet;

void debug(){
  /*
  fill(0);
  text(select, width/2, height/2);
  */
  
  /*
  stroke(0);
  strokeWeight(2);
  textSize(16*space/5);
  if(abs(dragX-drawX) > abs(dragY-drawY)){
    text("X is larger", width/2, height/2);
  }else if(abs(dragX-drawX) < abs(dragY-drawY)){
    text("Y is larger", width/2, height/2);
  }else{
    
  }
  */
  
  /*
  println("--------------------------------------------------------------------------------------------------------------------------------");
  for(int j = 0; j < vRes; j++){
    for(int i = 0; i < hRes; i++){
      print(board[i][j]);
    }
    println();
  }
  */
  
  /*
  strokeWeight(1);
  stroke(0);
  rectMode(CORNERS);
  fill(255, 0, 0);
  rect(space*(8+1), space*(4+1), width-(space*(8+1)), height-(space*(4+1)));
  fill(0, 255, 0);
  rect(width*1/5, height/4, width*4/5, height*3/4);
  fill(0, 0, 255);
  rect(width*3/5, height*3/4, width-(space*(8+1)), height-(space*(4+1)));
  fill(255, 255, 0);
  rect(space*(8+1), height*3/4, width*2/5, height-(space*(4+1)));
  fill(255, 0, 255);
  rect(width*3/5, space*(4+1), width-(space*(8+1)), height/4);
  fill(0, 255, 255);
  rect(space*(8+1), space*(4+1), width*2/5, height/4);
  */
  
  /*
  fill(0);
  strokeWeight(2);
  textSize(16*space/5);
  text(distanceRemaining, width/2, height/2);
  */
  
  /*
  fill(0);
  strokeWeight(2);
  textSize(16*space/5);
  text(drawMode, width/2, height/2);
  */
  
  /*
  println("X ",drawX," | ",dragX," | ",mirrorX," Y ",drawY," | ",dragY," | ",mirrorY);
  println("X ",abs(dragX-drawX)," Y ",abs(dragY-drawY));
  println("X ",abs(dragX-mirrorX)," Y ",abs(dragY-mirrorY));
  */
  
  /*
  print(tankState[0]);
  println(travel);
  println(tankX[0]+bulletX,", ",tankY[0]+bulletY);
  */
  
  
  
  
  
  /*
  fill(255, 0, 255);
  strokeWeight(2);
  textSize(16*space/5);
  text(slope, width/2, height/2);
  if(posSlope){
    text("positive slope", width/2, height/2-50);
  }else if(posSlope == false){
    text("negative slope", width/2, height/2-50);
  }
  if(click > 0){
    text("click" ,width/2, height/2+50);
    click++;
    if(click == 20){
      click = 0;
    }
  }
  */
  
  /*
  println("------------------------------------------------------------------");
  println("turnState: ", turnState,", ");
  println("travel/tankTravelDistance:", travel, "/", tankTravelDistance, " = ", travel/tankTravelDistance);
  //println("preTransitX: ", preTransitX, ", transitX: ", transitX, ", travel: ", travel, ", tankTravelDistance: " ,tankTravelDistance);
  println("P1: ", tankState[0], " ", tankX[0], ", ", tankY[0]);
  println("P2: ", tankState[1], " ", tankX[1], ", ", tankY[1]);
  //println("tank 0 bullet: ", tankX[0]+bulletX, ", ", tankY[0]+bulletY);
  //println("tank 1 bullet: ", tankX[1]+bulletX, ", ", tankY[1]+bulletY);
  //println("bounce: ", bounceX, ", ", bounceY);
  //println(debug, debugX, debugY);
  */
  
  /*
  stroke(255, 0, 0);
  strokeWeight(1);
  noFill();
  ellipse(debugX, debugY, space, space);
  */
  
  //println();
  //println(degrees(atan2(mouseY-height/2, mouseX-width/2)));
}

//random walls
/*
  //top left
  for(int n = 0; n < 3; n++){
    drawX = random(space*(8+1), width*2/5);
    dragX = random(space*(8+1), width*2/5);
    drawY = random(space*(4+1), height/4);
    dragY = random(space*(4+1), height/4);
    drawRandomMap();
  }
  
    //top right
  for(int n = 0; n < 3; n++){
    drawX = random(width*3/5, width-space*(8+1));
    dragX = random(width*3/5, width-space*(8+1));
    drawY = random(space*(4+1), height/4);
    dragY = random(space*(4+1), height/4);
    drawRandomMap();
  }
  
  //bottom left
  for(int n = 0; n < 3; n++){
    drawX = random(space*(8+1), width*2/5);
    dragX = random(space*(8+1), width*2/5);
    drawY = random(height*3/4, height-space*(4+1));
    dragY = random(height*3/4, height-space*(4+1));
    drawRandomMap();
  }
  
  //bottom right
  for(int n = 0; n < 3; n++){
    drawX = random(width*3/5, width-space*(8+1));
    dragX = random(width*3/5, width-space*(8+1));
    drawY = random(height*3/4, height-space*(4+1));
    dragY = random(height*3/4, height-space*(4+1));
    drawRandomMap();
  }
  
  //center
  for(int n = 0; n < 3; n++){
    drawX = random(width*1/5, width*4/5);
    dragX = random(width*1/5, width*4/5);
    drawY = random(height/4, height*3/4);
    dragY = random(height/4, height*3/4);
    drawRandomMap();
  }
  
  //all
  for(int n = 0; n < 3; n++){
    drawX = random(space*(8+1), width-space*(8+1));
    dragX = random(space*(8+1), width-space*(8+1));
    drawY = random(space*(4+1), height-space*(4+1));
    dragY = random(space*(4+1), height-space*(4+1));
    drawRandomMap();
  }*/
  
  //draw random walls
  /*if(abs(dragX-drawX) >= abs(dragY-drawY)){
    dragY = drawY;
  }else if(abs(dragX-drawX) < abs(dragY-drawY)){
    dragX = drawX;
  }*/
  
  /*
  //top left
    dragX = random(space*(8+1), width*2/5);
    drawY = random(space*(4+1), height/4);
  
    //top right
    dragX = random(width*3/5, width-space*(8+1));
    drawY = random(space*(4+1), height/4);
  
  //bottom left
    dragX = random(space*(8+1), width*2/5);
    drawY = random(height*3/4, height-space*(4+1));
  
  //bottom right
    dragX = random(width*3/5, width-space*(8+1));
    drawY = random(height*3/4, height-space*(4+1));
  
  //center
    dragX = random(width*1/5, width*4/5);
    drawY = random(height/4, height*3/4);
  
  //all
    dragX = random(space*(8+1), width-space*(8+1));
    drawY = random(space*(4+1), height-space*(4+1));
*/
