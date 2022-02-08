float lineDraw, mirrorX, mirrorY;

//draw current board state
void drawBoard(){
  for(int i = 0; i < hRes; i++){
    for(int j = 0; j < vRes; j++){
      
      //Black walls
      if(board[i][j] == 1 || board[i][j] == 3){
        rectMode(CENTER);
        stroke(0);
        fill(0);
        strokeWeight(1);
        rect(space/2+i*space, space/2+j*space, space, space);
        //rect(XY1, XY1, space, space);
        
        //temporary red walls
      }else if(board[i][j] == 2){
        rectMode(CENTER);
        stroke(255, 0, 0);
        fill(255, 0, 0);
        strokeWeight(1);
        rect(space/2+i*space, space/2+j*space, space, space);
      }else if(board[i][j] == 4){
        //debug
        rectMode(CENTER);
        stroke(255, 0, 0);
        noFill();
        strokeWeight(1);
        rect(space/2+i*space, space/2+j*space, space, space);
      }
    }
  }
}

void drag(){
  if(drag == true){
    
    for(int i = 0; i < hRes; i++){
      for(int j = 0; j < vRes; j++){
        //reset all temp lines from last frame
        if(board[i][j] == 2){
          board[i][j] = 0;
        }
        
        //set current mouse location to center of square
        if(mouseX >= i*space && mouseX < i*space+space && mouseY >= j*space && mouseY < j*space+space){
          dragX = space/2+i*space;
          dragY = space/2+j*space;
        }
      }
    }
    
    //choose if line will be vertical or horizontal
    if(abs(dragX-drawX) >= abs(dragY-drawY)){
      dragY = drawY;
    }else if(abs(dragX-drawX) < abs(dragY-drawY)){
      dragX = drawX;
    }
    
    //draw line between origin and mouse
    dotSpacing = dist(drawX, drawY, dragX, dragY)/(space);
    for (int d = 0; d <= dotSpacing; d++) {
      float x = lerp(drawX, dragX, d/dotSpacing);
      float y = lerp(drawY, dragY, d/dotSpacing);
      for(int i = 0; i < hRes; i++){
        for(int j = 0; j < vRes; j++){
          if(board[i][j] == 0){
            if(x > i*space && x < +i*space+space && y > j*space && y < j*space+space){
              board[i][j] = 2;
            }
          }
        }
      }
    }
    
    if(drawMode == 1){
      mirrorY = height-drawY;
      mirrorX = drawX;
      dragY = height-dragY;
    }else if(drawMode == 2){
      mirrorY = drawY;
      mirrorX = width-drawX;
      dragX = width-dragX;
    }else if(drawMode == 3){
      mirrorY = height-drawY;
      mirrorX = width-drawX;
      dragY = height-dragY;
      dragX = width-dragX;
    }
    
    //choose if line will be vertical or horizontal
    if(abs(dragX-mirrorX) >= abs(dragY-mirrorY)){
      dragY = mirrorY;
    }else if(abs(dragX-mirrorX) < abs(dragY-mirrorY)){
      dragX = mirrorX;
    }
    
    //draw mirrored line   
    if(drawMode > 0){
      //draw line between origin and mouse
      dotSpacing = dist(mirrorX, mirrorY, dragX, dragY)/(space);
      for (int d = 0; d <= dotSpacing; d++) {
        float x = lerp(mirrorX, dragX, d/dotSpacing);
        float y = lerp(mirrorY, dragY, d/dotSpacing);
        //point(x, y);
        for(int i = 0; i < hRes; i++){
          for(int j = 0; j < vRes; j++){
            if(board[i][j] == 0){
              if(x > i*space && x < +i*space+space && y > j*space && y < j*space+space){
                board[i][j] = 2;
              }
            }
          }  
        }  
      }  
    } 
  }
}

//START GAME
void startGame(){
  for(int i = 0; i < hRes; i++){
    for(int j = 0; j < vRes; j++){
      if(board[i][j] == 3){
        board[i][j] = 1;
      }else if(board[i][j] == 2){
        board[i][j] = 0;
      }
    }
  }
  turnState++;
}

void randomMap(){
  for(int i = 0; i < hRes; i++){
    for(int j = 0; j < vRes; j++){
      if(board[i][j] == 3){
        board[i][j] = 0;
      }
    }
  }
  for(int n = 0; n < 3; n++){
    //top left
    drawX = random(space*(8+1), width*2/5);
    dragX = random(space*(8+1), width*2/5);
    
    drawY = random(space*(4+1), height/4);
    dragY = random(space*(4+1), height/4);
    
    drawRandomMap();
  }
  for(int n = 0; n < 3; n++){
    //top right
    drawX = random(width*3/5, width-(space*(8+1)));
    dragX = random(width*3/5, width-(space*(8+1)));
    
    drawY = random(space*(4+1), height/4);
    dragY = random(space*(4+1), height/4);
    
    drawRandomMap();
  }
  for(int n = 0; n < 3; n++){
    //bottom left
    drawX = random(space*(8+1), width*2/5);
    dragX = random(space*(8+1), width*2/5);
    
    drawY = random(height*3/4, height-(space*(4+1)));
    dragY = random(height*3/4, height-(space*(4+1)));
    
    drawRandomMap();
  }
  for(int n = 0; n < 3; n++){
    //bottom right
    drawX = random(width*3/5, width-(space*(8+1)));
    dragX = random(width*3/5, width-(space*(8+1)));
    
    drawY = random(height*3/4, height-(space*(4+1)));
    dragY = random(height*3/4, height-(space*(4+1)));
    
    drawRandomMap();
  }
  for(int n = 0; n < 3; n++){
    //center
    drawX = random(width*1/5, width*4/5);
    dragX = random(width*1/5, width*4/5);
    
    drawY = random(height/4, height*3/4);
    dragY = random(height/4, height*3/4);
    
    drawRandomMap();
  }
  for(int n = 0; n < 3; n++){
    //all
    drawX = random(space*(8+1), width-(space*(8+1)));
    dragX = random(space*(8+1), width-(space*(8+1)));
    
    drawY = random(space*(4+1), height-(space*(4+1)));
    dragY = random(space*(4+1), height-(space*(4+1)));
    
    drawRandomMap();
  }
}

void drawRandomMap(){
  if(abs(dragX-drawX) >= abs(dragY-drawY)){
    dragY = drawY;
  }else if(abs(dragX-drawX) < abs(dragY-drawY)){
    dragX = drawX;
  }
  
  dotSpacing = dist(drawX, drawY, dragX, dragY)/(space);
  for (int d = 0; d <= dotSpacing; d++) {
    float x = lerp(drawX, dragX, d/dotSpacing);
    float y = lerp(drawY, dragY, d/dotSpacing);
    for(int i = 0; i < hRes; i++){
      for(int j = 0; j < vRes; j++){
        if(board[i][j] == 0){
          if(x > i*space && x < i*space+space && y > j*space && y < j*space+space){
            board[i][j] = 3;
          }
        }
      }
    }
  }
}

void drawHUD(){
  fill(0);
  strokeWeight(2);
  textSize(16*space/5);
  if(count > 0){
    if(drawMode == 1){
      text("Mirror Vertical", width/2, height/2);
    }else if(drawMode == 2){
      text("Mirror Horizontal", width/2, height/2);
    }else if(drawMode == 3){
      text("Mirror Diagonal", width/2, height/2);
    }else{
      text("Draw mode Normal", width/2, height/2);
    }
    count++;
    if(count == 60){
      count = 0;
    }
  }
}

void clearTemp(){
  for(int i = 0; i < hRes; i++){
    for(int j = 0; j < vRes; j++){
      if(board[i][j] == 2){
        board[i][j] = 0;
      }
    }
  }
}
