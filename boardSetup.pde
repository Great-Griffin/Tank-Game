float lineDraw, mirrorX, mirrorY, rX, rY;
float preDragX, preDragY;
boolean cut;
int door, cutCount;

//draw current board state
void drawBoard(){
  for(int i = 0; i < hRes; i++){
    for(int j = 0; j < vRes; j++){
      
      //erase walls too close to tank spawn
      if(turnState == 0){
        if(i >= hRes/2-2 && i <= hRes/2+1 && j >= vRes-4 && j <= vRes){
          board[i][j] = 0;
        }else if(i >= hRes/2-2 && i <= hRes/2+1 && j >= 0 && j < 4){
          board[i][j] = 0;
        }
      }
      
      //Black walls
      if(board[i][j] == 1 || board[i][j] == 3){
        stroke(0);
        fill(0);
        strokeWeight(1);
        rect(space/2+i*space, space/2+j*space, space, space);
        
        //temporary red walls
      }else if(board[i][j] == 2){
        stroke(255, 0, 0);
        fill(255, 0, 0);
        strokeWeight(1);
        rect(space/2+i*space, space/2+j*space, space, space);
      }
    }
  }
}

void drag(){
  if(drag){
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
    preDragX = dragX;
    preDragY = dragY;
    
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
    for(int z = 0; z < 4; z++){
      
      if(drawMode == 4 && z == 0){
        z++;
      }
      
      if(drawMode == 1 || z == 1){
        mirrorX = drawX;
        mirrorY = height-drawY;
        dragX = preDragX;
        dragY = height-dragY;
        if(drawMode == 1){
          z = 4;
        }
      }else if(drawMode == 2 || z == 2){
        mirrorX = width-drawX;
        mirrorY = drawY;
        dragX = width-dragX;
        dragY = preDragY;
        if(drawMode == 2){
          z = 4;
        }
      }else if(drawMode == 3 || z == 3){
        mirrorX = width-drawX;
        mirrorY = height-drawY;
        dragX = width-preDragX;
        dragY = height-preDragY;
        if(drawMode == 3){
          z = 4;
        }
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
  
  //top left
  rX = random(space*(8+1), 2*width/5);
  rY = random(space*(4+1), height/4);
  for(int n = 0; n < 4; n++){
    for(int b = 0; b < 2; b++){
      if(n%2 == 0){
        drawX = rX;
        drawY = rY;
        dragX = drawX;
        dragY = random(space*(4+1), height/4);
        if(dist(dragX, dragY, drawX, drawY) > 5*space){
          b = 2;
          rX = dragX;
          rY = dragY;
        }else{
          b = 0;
        }
      }else{
        dragX = rX;
        dragY = rY;
        drawX = random(space*(8+1), 2*width/5);
        drawY = dragY;
        if(dist(dragX, dragY, drawX, drawY) > 5*space){
          b = 2;
          rX = drawX;
          rY = drawY;
        }else{
          b = 0;
        }
      }
    }
    drawRandomMap();
  }
  
  //top right
  rX = random(width*3/5, width-space*(8+1));
  rY = random(space*(4+1), height/4);
  for(int n = 0; n < 4; n++){
    for(int b = 0; b < 2; b++){
      if(n%2 == 0){
        drawX = rX;
        drawY = rY;
        dragX = drawX;
        dragY = random(space*(4+1), height/4);
        if(dist(dragX, dragY, drawX, drawY) > 5*space){
          b = 2;
          rX = dragX;
          rY = dragY;
        }else{
          b = 0;
        }
      }else{
        dragX = rX;
        dragY = rY;
        drawX = random(width*3/5, width-space*(8+1));
        drawY = dragY;
        if(dist(dragX, dragY, drawX, drawY) > 5*space){
          b = 2;
          rX = drawX;
          rY = drawY;
        }else{
          b = 0;
        }
      }
    }
    drawRandomMap();
  }
  
  //bottom left
  rX = random(space*(8+1), width*2/5);
  rY = random(height*3/4, height-space*(4+1));
  for(int n = 0; n < 4; n++){
    for(int b = 0; b < 2; b++){
      if(n%2 == 0){
        drawX = rX;
        drawY = rY;
        dragX = drawX;
        dragY = random(height*3/4, height-space*(4+1));
        if(dist(dragX, dragY, drawX, drawY) > 5*space){
          b = 2;
          rX = dragX;
          rY = dragY;
        }else{
          b = 0;
        }
      }else{
        dragX = rX;
        dragY = rY;
        drawX = random(space*(8+1), width*2/5);
        drawY = dragY;
        if(dist(dragX, dragY, drawX, drawY) > 5*space){
          b = 2;
          rX = drawX;
          rY = drawY;
        }else{
          b = 0;
        }
      }
    }
    drawRandomMap();
  }
  
  //bottom right
  rX = random(width*3/5, width-space*(8+1));
  rY = random(height*3/4, height-space*(4+1));
  for(int n = 0; n < 4; n++){
    for(int b = 0; b < 2; b++){
      if(n%2 == 0){
        drawX = rX;
        drawY = rY;
        dragX = drawX;
        dragY = random(height*3/4, height-space*(4+1));
        if(dist(dragX, dragY, drawX, drawY) > 5*space){
          b = 2;
          rX = dragX;
          rY = dragY;
        }else{
          b = 0;
        }
      }else{
        dragX = rX;
        dragY = rY;
        drawX = random(width*3/5, width-space*(8+1));
        drawY = dragY;
        if(dist(dragX, dragY, drawX, drawY) > 5*space){
          b = 2;
          rX = drawX;
          rY = drawY;
        }else{
          b = 0;
        }
      }
    }
    drawRandomMap();
  }
  
  //center
  rX = random(width*1/5, width*4/5);
  rY = random(height/4, height*3/4);
  for(int n = 0; n < 5; n++){
    for(int b = 0; b < 2; b++){
      if(n%2 == 0){
        drawX = rX;
        drawY = rY;
        dragX = drawX;
        dragY = random(height/4, height*3/4);
        if(dist(dragX, dragY, drawX, drawY) > 5*space){
          b = 2;
          rX = dragX;
          rY = dragY;
        }else{
          b = 0;
        }
      }else{
        dragX = rX;
        dragY = rY;
        drawX = random(width*1/5, width*4/5);
        drawY = dragY;
        if(dist(dragX, dragY, drawX, drawY) > 5*space){
          b = 2;
          rX = drawX;
          rY = drawY;
        }else{
          b = 0;
        }
      }
    }
    drawRandomMap();
  }
  
  //all
  for(int s = 0; s < 3; s++){
    rX = random(space*(8+1), width-space*(8+1));
    rY = random(space*(4+1), height-space*(4+1));
    for(int n = 0; n < 3; n++){
      for(int b = 0; b < 2; b++){
        if(n%2 == 0){
          drawX = rX;
          drawY = rY;
          dragX = drawX;
          dragY = random(space*(4+1), height-space*(4+1));
          if(dist(dragX, dragY, drawX, drawY) > 5*space){
          b = 2;
          rX = dragX;
          rY = dragY;
        }else{
          b = 0;
        }
        }else{
          dragX = rX;
          dragY = rY;
          drawX = random(space*(8+1), width-space*(8+1));
          drawY = dragY;
          if(dist(dragX, dragY, drawX, drawY) > 5*space){
          b = 2;
          rX = drawX;
          rY = drawY;
        }else{
          b = 0;
        }
        }
      }
      drawRandomMap();
    }
  }
}

void drawRandomMap(){
  
  for(int i = 0; i < hRes; i++){
    for(int j = 0; j < vRes; j++){
      if(drawX >= space/2+i*space-space/2 && drawX < space/2+i*space+space/2 && drawY >= space/2+j*space-space/2 && drawY < space/2+j*space+space/2){
        drawX = space/2+i*space;
        drawY = space/2+j*space;
      }
      if(dragX >= space/2+i*space-space/2 && dragX < space/2+i*space+space/2 && dragY >= space/2+j*space-space/2 && dragY < space/2+j*space+space/2){
        dragX = space/2+i*space;
        dragY = space/2+j*space;
      }
    }
  }
  dotSpacing = dist(drawX, drawY, dragX, dragY)/(space)+0.01;
  if(dotSpacing > 30){
    cutCount = 0;
    cut = true;
    door = int(random(int(dotSpacing)/3, 2*int(dotSpacing)/3));
  }
  for (int d = 0; d <= dotSpacing; d++) {
    float x = lerp(drawX, dragX, d/dotSpacing);
    float y = lerp(drawY, dragY, d/dotSpacing);
    for(int i = 0; i < hRes; i++){
      for(int j = 0; j < vRes; j++){
        if(board[i][j] == 0){
          if(x > i*space && x < i*space+space && y > j*space && y < j*space+space){
            if(cut){
              if(cutCount >= door && cutCount < door+6){
                board[i][j] = 0;
              }else{
                board[i][j] = 3;
              }
              cutCount++;
            }else{
              board[i][j] = 3;
            }
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
    }else if(drawMode == 4){
      text("Mirror All", width/2, height/2);
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

void reset(){
  for(int i = 0; i < hRes; i++){
    for(int j = 0; j < vRes; j++){
      if(board[i][j] > 0){
        board[i][j] = 0;
      }
    }
  }
  setup();
}
