// 128px / 72px
float vRes = 72;
float hRes = vRes*16/9;
float space, previewSpace, dotSpacing;
int turnState = 0;
//state 0 = setup
//state 1 = P1 select tank
//state 2 = P1 turn to move
//state 3 = P1 turn to shoot
//state 4 = P2 select tank
//state 5 = P2 turn to move
//state 6 = P2 turn to shoot

int[][] board = new int[int(hRes)][int(vRes)];
//0 = blank
//1 = wall
//2 = temp wall
//3 = final wall before game starts

boolean boardSetup = true;
boolean drag = false;
float drawX, drawY, dragX, dragY;
int pressedX, pressedY;
boolean passTurn, ctrlPressed;

float tankTravelDistance, distanceRemaining, moveX, moveY, transitX, transitY, preTransitX, preTransitY;
float travel, distance;
float[] tankX = new float[2];
float[] tankY = new float[2];
float[] tankAngle = new float[2];
int[] tankState = new int[3];
//state 0 = static
//state 1 = dynamic
//state 2 = in transit
//state 3 = aiming
//state 4 = shooting

float maxTravel; //25 spaces, from void setup
float buttonWidth, buttonHeight, buttonX, buttonY;
int drawMode = 0;
String turn;

void setup(){
  
  //size(960, 540);
  
  fullScreen();
  width = displayWidth;
  height = displayHeight;
  
  frameRate(60);
  space = height/vRes;
  previewSpace = space/4;
  tankX[0] = width/2;
  tankY[0] = height-3*space/2;
  tankAngle[0] = -PI/2;
  tankX[1] = width/2;
  tankY[1] = 3*space/2;  
  tankAngle[1] = PI/2;
  
  //travel
  maxTravel = space*25;
  distanceRemaining = maxTravel;
  
  rectMode(CENTER);
  
  //button dimensions
  buttonWidth = 8*space;
  buttonHeight = 4*space;
  buttonX = buttonWidth*5/8;
  buttonY = buttonHeight*3/4;
  
  //wall off buttons
  for(int i = 0; i < hRes; i++){
    for(int j = 0; j < vRes; j++){
      //bottom left button
      if(i >= 1 && i <= 8 && j >= vRes-1-4 && j <= vRes-1-1){
        board[i][j] = 1;
        
        //top right
      }else if(i >= hRes-1-8 && i <= hRes-1-1 && j >= 1 && j <= 4){
        board[i][j] = 1;
        
        //top left
      }else if(i >= 1 && i <= 8 && j >= 1 && j <= 4){
        board[i][j] = 1;
        
        //bottom right
      }else if(i >= hRes-1-8 && i <= hRes-1-1 && j >= vRes-1-4 && j <= vRes-1-1){
        board[i][j] = 1;
      }
    }
  }
}

void draw(){ 
  background(255);
  drawGrid();
  drawBoard();
  drawTanks();
  drawTrajectory();
  drawButtons();
  drawBullet();
  drawHUD();
  drag();
  endGame();
  mapPreview();
  debug();
  if(turnState > 6){
    turnState = 1;
  }
}

void drawGrid(){
  stroke(220);
  strokeWeight(1);
  for(int i = 0;i < vRes+1; i++){
    line(0, 0+i*space, width, 0+i*space);
  }for(int i = 0;i < hRes+1; i++){
    line(0+i*space, 0, 0+i*space, height);
  }
}

void keyPressed(){
  if(turnState == 0){
    if(saveMapPrompt == false && loadMapPrompt == false){
      if(key == 's' || key == 'S'){
        saveMapPrompt = true;
        text = "";
        load = loadStrings("loadDirectory.txt");
      }else if(key == 'l' || key == 'L'){
        loadMapPrompt = true;
        load = loadStrings("loadDirectory.txt");
      }
    
  
    }else if(saveMapPrompt){
      if(key == BACKSPACE){
        text = text.substring(0, max(0,text.length()-1));
      }else if(key == ENTER){
        saveMap();
        saveMapPrompt = false;
      }else if(key == ESC){
        saveMapPrompt = false;
        key = 0;
      }else if(text.length() < 10){
        if(key >= 'a' && key <= 'z' || key >= 'A' && key <= 'Z' || key >= '0' && key <= '9'){
          text = text + key;
        }
      }
    }else if(loadMapPrompt){
      if(keyCode == UP){
        select--;
      }else if(keyCode == DOWN){
        select++;
      }else if(key == ENTER){
        loadMap();
        loadMapPrompt = false;
        select = 0;
      }else if(key == ESC){
        loadMapPrompt = false;
        select = 0;
        key = 0;
      }
      if(select >= load.length){
        select = 0;
      }else if(select < 0){
        select = load.length-1;
      }
    }
  }
}

void mousePressed(){
  if(turnState == 0){
    if(drag == false){
      
      //set origin for line draw in center
      for(int i = 0; i < hRes; i++){
        for(int j = 0; j < vRes; j++){
          if(mouseX >= space/2+i*space-space/2 && mouseX < space/2+i*space+space/2 && mouseY >= space/2+j*space-space/2 && mouseY < space/2+j*space+space/2){
            drawX = space/2+i*space;
            drawY = space/2+j*space;
          }
        }
      }
      drag = true;
    }
  }
  
  //save location of mouse click for buttons
  pressedX = mouseX;
  pressedY = mouseY;
}

void mouseReleased(){
  
  //saveLoad
  if(mouseX > width-buttonX-buttonWidth/2 && mouseX < width-buttonX+buttonWidth/2 && mouseY > buttonY-buttonHeight/2 && mouseY < buttonY+buttonHeight/2 &&
    pressedX > width-buttonX-buttonWidth/2 && pressedX < width-buttonX+buttonWidth/2 && pressedY > buttonY-buttonHeight/2 && pressedY < buttonY+buttonHeight/2){
     exit();
  }
  if(turnState == 0){
      
      //RANDOM MAP BUTTON
    if(mouseX > buttonX-buttonWidth/2 && mouseX < buttonX+buttonWidth/2 && mouseY > buttonY-buttonHeight/2 && mouseY < buttonY+buttonHeight/2 &&
      pressedX > buttonX-buttonWidth/2 && pressedX < buttonX+buttonWidth/2 && pressedY > buttonY-buttonHeight/2 && pressedY < buttonY+buttonHeight/2){
      clearTemp();
      randomMap();
    }
      
      //DRAW-MODE BUTTON
    if(mouseX > width-buttonX-buttonWidth/2 && mouseX < width-buttonX+buttonWidth/2 && mouseY > height-buttonY-buttonHeight/2 && mouseY < height-buttonY+buttonHeight/2 &&
      pressedX > width-buttonX-buttonWidth/2 && pressedX < width-buttonX+buttonWidth/2 && pressedY > height-buttonY-buttonHeight/2 && pressedY < height-buttonY+buttonHeight/2){
      if(drawMode < 4){
        drawMode++;
      }else{
        drawMode = 0;
      }
      clearTemp();
      count = 1;
    }
    
    if(drag){
      for(int i = 0; i < hRes; i++){
        for(int j = 0; j < vRes; j++){
          if(board[i][j] == 2){
            board[i][j] = 3;
          }
        }
      }
      drag = false;
    }
  }
  
  if(turnState > 0){
    
    //PASS TURN BUTTON
    if(mouseX > buttonX-buttonWidth/2 && mouseX < buttonX+buttonWidth/2 && mouseY > height-buttonY-buttonHeight/2 && mouseY < height-buttonY+buttonHeight/2 &&
      pressedX > buttonX-buttonWidth/2 && pressedX < buttonX+buttonWidth/2 && pressedY > height-buttonY-buttonHeight/2 && pressedY < height-buttonY+buttonHeight/2){
      passTurn = true;
      if(turnState == 1){
        tankState[0] = 3;
        distanceRemaining = 0;
        turnState+=2;
      }else if(turnState == 2){
        tankState[0] = 3;
        distanceRemaining = 0;
        turnState++;
      }else if(turnState == 3){
        tankState[0] = 0;
        bulletTransit = false;
        distanceRemaining = maxTravel;
        turnState++;
      }else if(turnState == 4){
        tankState[1] = 3;
        distanceRemaining = 0;
        turnState+=2;
      }else if(turnState == 5){
        tankState[1] = 3;
        distanceRemaining = 0;
        turnState++;
      }else if(turnState == 6){
        tankState[1] = 0;
        bulletTransit = false;
        distanceRemaining = maxTravel;
        turnState++;
      }
    }
  }
  
  //player 1 select tank
  if(turnState == 1 && mouseX < tankX[0]+space && mouseX > tankX[0]-space && mouseY < tankY[0]+3/2*space && mouseY > tankY[0]-3/2*space &&
    pressedX < tankX[0]+space && pressedX > tankX[0]-space && pressedY < tankY[0]+3/2*space && pressedY > tankY[0]-3/2*space){
    tankState[0] = 1;
    turnState++;
  }
  
  //player 1 move tank
  else if(passTurn == false && turnState == 2 && tankState[0] == 1){
    distance = dist(tankX[0], tankY[0], moveX, moveY);
    if(int(distance) < int(distanceRemaining)){
      distanceRemaining = distanceRemaining-distance;
    }else{
      turnState++;
      distanceRemaining = 0;
    }
    tankState[0] = 2;
    travel = 0;
    tankTravelDistance = dist(tankX[0], tankY[0], moveX, moveY);
    transitX = moveX; 
    transitY = moveY;
    preTransitX = tankX[0];
    preTransitY = tankY[0];
  }
  
  //player 1 shoot
  else if(passTurn == false && turnState == 3 && bulletTransit == false && distance <= 10*space){
    tankShotX = mouseX-tankX[0];
    tankShotY = mouseY-tankY[0];
    slope = tankShotY/tankShotX;
    if(tankShotX > 0){
      posSlope = true;
    }else{
      posSlope = false;
    }
    bulletX = 0;
    bulletY = 0;
    bulletTravel = 0;
    bounce = false;
    bulletTransit = true;
    tankState[0] = 4;
    ricochet();
  }
  
  //player 2 select tank
  if(turnState == 4 && mouseX < tankX[1]+space && mouseX > tankX[1]-space && mouseY < tankY[1]+3/2*space && mouseY > tankY[1]-3/2*space &&
    pressedX < tankX[1]+space && pressedX > tankX[1]-space && pressedY < tankY[1]+3/2*space && pressedY > tankY[1]-3/2*space){
    tankState[1] = 1;
    turnState++;
  }
  
  //player 2 move tank
  else if(passTurn == false && turnState == 5 && tankState[1] == 1){
    distance = dist(tankX[1], tankY[1], moveX, moveY);
    if(int(distance) < int(distanceRemaining)){
      distanceRemaining = distanceRemaining-distance;
    }else{
      turnState++;
      distanceRemaining = 0;
    }
    tankState[1] = 2;
    travel = 0;
    tankTravelDistance = dist(tankX[1], tankY[1], moveX, moveY);
    transitX = moveX; 
    transitY = moveY;
    preTransitX = tankX[1];
    preTransitY = tankY[1];
  }
  
  //player 2 shoot
  else if(passTurn == false && turnState == 6 && bulletTransit == false && distance <= 10*space){
    tankShotX = mouseX-tankX[1];
    tankShotY = mouseY-tankY[1];
    slope = tankShotY/tankShotX;
    if(tankShotX > 0){
      posSlope = true;
    }else{
      posSlope = false;
    }
    bulletX = 0;
    bulletY = 0;
    bulletTravel = 0;
    bounce = false;
    bulletTransit = true;
    tankState[1] = 4;
    ricochet();
  }
  
  //START GAME BUTTON
  if(turnState == 0 && mouseX > buttonX-buttonWidth/2 && mouseX < buttonX+buttonWidth/2 && mouseY > height-buttonY-buttonHeight/2 && mouseY < height-buttonY+buttonHeight/2 &&
    pressedX > buttonX-buttonWidth/2 && pressedX < buttonX+buttonWidth/2 && pressedY > height-buttonY-buttonHeight/2 && pressedY < height-buttonY+buttonHeight/2){
      if(endGame == false){
        mapHystory();
        startGame();
      }else{
        endGame = false;
        reset();
      }
  }
  passTurn = false;
}
