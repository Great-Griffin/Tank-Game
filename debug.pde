int count, click;
float debugX, debugY;

void debug(){
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
  for(int j = 0; j < vRes; j++){
    for(int i = 0; i < hRes; i++){
      print(board[i][j]);
    }
    println();
  }
  println();
  println();
  println();
  println();
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
  
  //println("X ",drawX," | ",dragX," | ",mirrorX," Y ",drawY," | ",dragY," | ",mirrorY);
  //println("X ",abs(dragX-drawX)," Y ",abs(dragY-drawY));
  //println("X ",abs(dragX-mirrorX)," Y ",abs(dragY-mirrorY));
  
  //print(tankState[0]);
  //println(travel);
  //println(tankX[0]+bulletX,", ",tankY[0]+bulletY);
  
  fill(255, 0, 255);
  strokeWeight(2);
  textSize(16*space/5);
  text(slope, width/2, height/2);
  if(posSlope == true){
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
  
  println("------------------------------------------------------------------");
  println(preTransitX, ", ", transitX, ", ", travel/tankTravelDistance);
  println("tankShot", tankShotX, ", ", tankShotY);
  println("preTransitX: ", preTransitX, ", transitX: ", transitX, ", travel: ", travel, ", tankTravelDistance: " ,tankTravelDistance);
  println("turnState: ", turnState,", ");
  println("tank 0: state: ", tankState[0], " ", tankX[0], ", ", tankY[0]);
  println("tank 1: state: ", tankState[1], " ", tankX[1], ", ", tankY[1]);
  println("bullet: ", bulletX, ", ", bulletY);
  
  /*
  stroke(255, 0, 0);
  strokeWeight(1);
  noFill();
  ellipse(debugX, debugY, space, space);
  */
  
  //println();
  //println(degrees(atan2(mouseY-height/2, mouseX-width/2)));
}
