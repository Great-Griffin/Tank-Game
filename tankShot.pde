float tankShotX, tankShotY, bulletX, bulletY, bulletTravel, slope, bounceX, bounceY, X, Y, preX, preY;
boolean posSlope, preSlope, bounce, bulletTransit;

void drawBullet(){
  for(int t = 0; t < 2; t++){
    if(tankState[t] == 4 && bulletTransit){
       for(int i = 0; i < hRes; i++){
        for(int j = 0; j < vRes; j++){
          if(bounce == false){
            X = tankX[t]+bulletX;
            Y = tankY[t]+bulletY;
            if(X >= i*space && X < i*space+space && Y >= j*space && Y < j*space+space){
              if(board[i][j] == 0){
                bulletX = bulletTravel*sqrt(1+slope*slope)/(1+slope*slope);
                bulletY = bulletX*slope;
              }else if(board[i][j] > 0){
                bounce = true;
                bulletTravel = 0;
                bulletX = 0;
                bulletY = 0;
                posSlope = preSlope;
                slope = -slope;
              }
              
              //out of bounds
              //left edge
            }else if(X < 0){
              bounce = true;
              bulletTravel = 0;
              bulletX = 0;
              bulletY = 0;
              posSlope = true;
              slope = -slope;
              
              //right edge
            }else if(X > width){
              bounce = true;
              bulletTravel = 0;
              bulletX = 0;
              bulletY = 0;
              posSlope = false;
              slope = -slope;
              
              // top edge
            }else if(Y < 0){
              bounce = true;
              bulletTravel = 0;
              bulletX = 0;
              bulletY = 0;
              slope = -slope;
              
              // bottom edge
            }else if(Y > height){
              bounce = true;
              bulletTravel = 0;
              bulletX = 0;
              bulletY = 0;
              slope = -slope;
            }
          }else if(bounce){
            X = bounceX+bulletX;
            Y = bounceY+bulletY;
            if(X >= i*space && X < i*space+space && Y >= j*space && Y < j*space+space){
              if(board[i][j] == 0){
                bulletX = bulletTravel*sqrt(1+slope*slope)/(1+slope*slope);
                bulletY = bulletX*slope;
              }else if(board[i][j] > 0){
                bulletTransit = false;
                bounce = false;
                distanceRemaining = maxTravel;
                tankState[t] = 0;
                turnState++;
              }
              
              //out of bounds
            }else if(X < 0 || X > width || Y < 0 || Y > height){
              bounce = false;
              bulletTransit = false;
              distanceRemaining = maxTravel;
              tankState[t] = 0;
              turnState++;
            }
          }
        }
      }
      if(bulletTransit){
        strokeWeight(5);
        stroke(0);
        strokeCap(ROUND);
        point(X, Y);
      }
      if(posSlope){
        bulletTravel+=space/2;
      }else{
        bulletTravel-=space/2;
      }
    }
  }
}

void ricochet(){
  for(int t = 0; t < 2; t++){
    if(tankState[t] == 4){
      for(float d = 0; d < 20000; d+=0.1) {
        X = tankX[t]+bulletX;
        Y = tankY[t]+bulletY;
        if(X < 0 || X > width || Y < 0 || Y > height){
          bounceX = preX;
          bounceY = preY;
          bulletX = 0;
          bulletY = 0;
          return;
        }
        
        for(int i = 0; i < hRes; i++){
          for(int j = 0; j < vRes; j++){
            if(board[i][j] > 0){
              if(X >= i*space && X < i*space+space && Y >= j*space && Y < j*space+space){
                bounceX = preX;
                bounceY = preY;
                bulletX = 0;
                bulletY = 0;
                
                //left edge
                if(preX >= i*space+space && preX <= i*space+2*space && preY >= j*space && preY <= j*space+space){
                  if(posSlope){
                    preSlope = false;
                  }else{
                    preSlope = true;
                  }
                  return;
                  
                  //right edge
                }else if(preX >= i*space-space && preX <= i*space && preY >= j*space && preY <= j*space+space){
                  if(posSlope){
                    preSlope = false;
                  }else{
                    preSlope = true;
                  }
                  return;
                  
                  //top or bottom edge
                }else{
                  if(posSlope){
                    preSlope = true;
                  }else{
                    preSlope = false;
                  }
                  return;
                }
              }
            }
          }
        }
        
        preX = X;
        preY = Y;
        debugX = preX;
        debugY = preY;
        if(posSlope){
          bulletX = d*sqrt(1+slope*slope)/(1+slope*slope);
          bulletY = bulletX*slope;
        }else{
          bulletX = -d*sqrt(1+slope*slope)/(1+slope*slope);
          bulletY = bulletX*slope;
        }
      }
    }
  }
}
