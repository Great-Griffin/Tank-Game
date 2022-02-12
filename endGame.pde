String win, player;
int opp;
boolean endGame = false;
int xp, explosion;

void endGame(){
  if(endGame == false){
    for(int t = 0; t < 2; t++){
      if(t == 0){
        opp = 1;
        player = "P1";
      }else if(t == 1){
        opp = 0;
        player = "P2";
      }
      if(tankState[t] == 4 && dist(tankX[t]+bulletX, tankY[t]+bulletY, tankX[opp], tankY[opp]) < 2*space){
        explosion = opp;
        win();
      }else if(tankState[t] == 4 && bounce && dist(bounceX+bulletX, bounceY+bulletY, tankX[opp], tankY[opp]) < 2*space){
        explosion = opp;
        win();
      }else if(tankState[opp] == 4 && bounce && dist(bounceX+bulletX, bounceY+bulletY, tankX[opp], tankY[opp]) < 2*space){
        explosion = opp;
        win();
      }
    }
  }
  
  //explosion
  if(xp > 0){
    stroke(255, 60, 60);
    pushMatrix();
    translate(tankX[explosion], tankY[explosion]);
    ellipse(0, 0, xp, xp);
    popMatrix();
    
    xp++;
    if(xp == 240){
      xp = 0;
      endGame = true;
    }
  }
  
  //display end game screen
  if(endGame){
    stroke(0);
    fill(255);
    rect(width/2, height/2, width/4, height/4);
    textSize(10*space);
    fill(0);
    text(win, width/2, height/2-11*space/2);
    text("WINS", width/2, height/2+3*space);
  }
}

void win(){
  win = player;
  bulletTransit = false;
  turnState = 0;
  tankState[0] = 0;
  tankState[1] = 0;
  xp = 1;
}
