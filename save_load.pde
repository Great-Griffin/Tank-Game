int[][] preview = new int[int(hRes)][int(vRes)];

String[] lines = new String[int(vRes)];
String[] line = new String[int(vRes)];
String[] splits = new String[int(hRes)];
String[] load/* = new String[10]*/;
String[] saveDirectory;
boolean saveMapPrompt, loadMapPrompt;
int select = 0;

//typing
String lastInput = new String();
String currentInput = new String();
String save = "";
String text = "";

void saveMap(){
  for(int j = 0; j < vRes; j++){
    for(int i = 0; i < hRes; i++){
      lines[j] += board[i][j] + ",";
    }
  }
  saveDirectory = new String[load.length+1];
  for(int c = 0; c < load.length; c++){
    saveDirectory[c] = load[c];
    println(load[c]);
  }
  saveDirectory[load.length] = text;
  saveStrings(text+".txt", lines);
  saveStrings("loadDirectory.txt", saveDirectory);
}

void loadMap(){
  line = loadStrings(load[select]+".txt");
  for(int j = 0; j < vRes; j++){
    splits = split(line[j], ',');
    for(int i = 0; i < hRes; i++){
      board[i][j] = int(splits[i]);
    }
  }
}

void mapPreview(){
  if(loadMapPrompt && select < load.length){
    line = loadStrings(load[select]+".txt");
    for(int j = 0; j < vRes; j++){
      splits = split(line[j], ',');
      for(int i = 0; i < hRes; i++){
        preview[i][j] = int(splits[i]);
      }
    }
    pushMatrix();
    translate(width/2-previewSpace*hRes/2, height/4);
    fill(255);
    stroke(0);
    strokeWeight(1);
    rect(previewSpace*hRes/2, previewSpace*vRes/2, previewSpace*hRes, previewSpace*vRes);
    for(int i = 0; i < hRes; i++){
      for(int j = 0; j < vRes; j++){
        if(preview[i][j] == 3){
          stroke(0);
          fill(0);
          strokeWeight(1);
          rect(previewSpace/2+i*previewSpace, previewSpace/2+j*previewSpace, previewSpace, previewSpace);
        }
      }
    }
    popMatrix();
  }
}
