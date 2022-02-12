float tankShotX, tankShotY, bulletX, bulletY, bulletTravel, slope, bounceX, bounceY, X, Y;
boolean posSlope, bounce, bulletTransit;

void drawBullet(){
    
  for(int t = 0; t < 2; t++){
    if(tankState[t] == 3 && bulletTransit == true){
      
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
                
                //test for angle of impact
                
              }
              
              //out of bounds
              
              //left edge
            }else if(X < 0){
              bounce = true;
              bulletTravel = 0;
              bounceX = 0.01;
              bounceY = Y;
              bulletX = 0;
              bulletY = 0;
              posSlope = true;
              slope = -slope;
              
              //right edge
            }else if(X > width){
              bounce = true;
              bulletTravel = 0;
              bounceX = width-0.01;
              bounceY = Y;
              bulletX = 0;
              bulletY = 0;
              posSlope = false;
              slope = -slope;
              
              // top edge
            }else if(Y < 0){
              bounce = true;
              bulletTravel = 0;
              bounceX = X;
              bounceY = 0.01;
              bulletX = 0;
              bulletY = 0;
              slope = -slope;
              
              // bottom edge
            }else if(Y > height){
              bounce = true;
              bulletTravel = 0;
              bounceX = X;
              bounceY = height-0.01;
              bulletX = 0;
              bulletY = 0;
              slope = -slope;
            }
            
          }else{
            X = bounceX+bulletX;
            Y = bounceY+bulletY;
            
            if(X >= i*space && X < i*space+space && Y >= j*space && Y < j*space+space){
              
              if(board[i][j] == 0){
                bulletX = bulletTravel*sqrt(1+slope*slope)/(1+slope*slope);
                bulletY = bulletX*slope;
              }else if(board[i][j] > 0){
                bulletTransit = false;
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
      
      if(bulletTransit == true){
        strokeWeight(5);
        stroke(0);
        strokeCap(ROUND);
        point(X, Y);
      }
      
      if(posSlope == true){
        bulletTravel+=space/2;
      }else{
        bulletTravel-=space/2;
      }
      
    }
  }
}
