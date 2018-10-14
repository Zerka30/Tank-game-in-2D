float tankX=330;
float tankY=208;
boolean haut=false;
boolean bas=false;
boolean gauche=false;
boolean droite=false;
boolean dhaut=false;
boolean dbas=false;
boolean dgauche=false;
boolean ddroite=false;
PImage bg;
boolean click=false;
ArrayList<Balle> balles =new ArrayList<Balle>();
int balle=0;
boolean menu=true;
boolean omenu=true;
PImage imenu;
PImage iomenu;
boolean textHasBeenClicked = false;
boolean textHasBeenClicked1 = false;
PFont mapolice;
int timerBalle=0;
boolean allowedBalle=true;
int timerFin=18000;
int timerFinMinutes=0;
int timerFinSecondes=0;
boolean fin=false;
int FPS;
int timerFPS;

void setup(){
  size(640,416);
  bg = loadImage("background.jpg");
  background(0);
  imenu = loadImage("menu.jpg");
  iomenu = loadImage("omenu.jpg");
  mapolice = loadFont("AngsanaUPC-Italic-48.vlw");
  textFont(mapolice, 70);
  noStroke();
  frameRate(60);
}
///////////////////////////////////////////////////////////////////////////////////DRAW///////////////////////////////////////////////////////////////////////////////////
void draw(){
  dessiner_tank();
  deplacer_tank();
  balle();
  menu();
  timerFin();
  timea();
/////////////////////////////////////////////////////////////////////////////////DRAW///////////////////////////////////////////////////////////////////////////////////////  
}
// tourne à gauche , droite , revenir en haut ou descendre
void dessiner_tank(){
  if(menu==false){
    background(bg);
    if(gauche==true){
      dgauche=true;
      ddroite=false;
      dhaut=false;
      dbas=false; 
    }
    if(droite==true){
      dgauche=false;
      ddroite=true;
      dhaut=false;
      dbas=false;
    }
    if(haut==true){
      dgauche=false;
      ddroite=false;
      dhaut=true;
      dbas=false;
    }
    if(bas==true){
      dgauche=false;
      ddroite=false;
      dhaut=false;
      dbas=true;
    }
    if(dhaut==true){
      fill(0,53,255);
      noStroke();
      rect(tankX,tankY,10,15);
      rect(tankX+4,tankY-8,2,9);
    }
    if(dbas==true){
      fill(0,53,255);
      noStroke();
      rect(tankX,tankY,10,15);
      rect(tankX+4,tankY+15,2,8);
    }
    if(dgauche==true){
      fill(0,53,255);
      noStroke();
      rect(tankX-3,tankY+4,15,10);
      rect(tankX-12,tankY+8,9,2);
    }
    if(ddroite==true){
      fill(0,53,255);
      noStroke();
      rect(tankX-3,tankY+4,15,10);
      rect(tankX+12,tankY+8,9,2);
    }
    timerFPS++;
    if(timerFPS>60){
      FPS=int(frameRate);
      timerFPS=0;
    }
    fill(255);
    textFont(mapolice,30);
    text("FPS: " + FPS, 10, 20);
  }
}
// Systeme de deplacement du tank
void deplacer_tank(){
  if(menu==false){
    if(droite==true){
      tankX=tankX+0.5;
    }
    if(gauche==true){
      tankX=tankX-0.5;
    }
    if(haut==true){
      tankY=tankY-0.5;
    }
    if(bas==true){
      tankY=tankY+0.5;
    }
  }
}  
// Deplacement lorsqu'on appuie sur la key 
void keyPressed() {
  if(menu==false){
    if ((keyCode == UP || keyCode == 'Z' || keyCode == 'z') && (gauche==false)&&(droite==false)) {
      haut=true;
    }
  
    if ((keyCode == DOWN || keyCode == 'S' || keyCode == 's') && (gauche==false)&&(droite==false)) {  
      bas=true;
    }
  
    if ((keyCode == LEFT || keyCode == 'Q' || keyCode == 'q') && (bas==false)&&(haut==false)) { 
      gauche=true;
    }
  
    if ((keyCode == RIGHT || keyCode == 'D' || keyCode == 'D') && (bas==false)&&(haut==false)) { 
      droite=true;
    }
  }
}
// Arrete d'avancer quand on reclique sur la key
void keyReleased() {
  if(menu==false){
    if (keyCode == UP || keyCode == 'Z' || keyCode == 'z') {
      haut=false;
    }
  
    if (keyCode == DOWN || keyCode == 'S' || keyCode == 's') {  
      bas=false;
    }
  
    if (keyCode == LEFT || keyCode == 'Q' || keyCode == 'q') { 
      gauche=false;
    }
  
    if (keyCode == RIGHT || keyCode == 'D' || keyCode == 'd') { 
      droite=false;
    }
  }
}

// Système d'appel de la balle
void balle() {
  if(menu==false) {
    if(allowedBalle==false){
      timerBalle++;
    }
    if(timerBalle>60){
      allowedBalle=true;
      timerBalle=0;
    }
    fill(255);
    noStroke();
    if (dbas == true && click==true && allowedBalle==true){ // Si tank Vers le bas
      balles.add(new Balle());
      balles.get(balle).info(tankX+3.75,tankY+25,0,5,2,5);
      balle++;
      click=false;
      allowedBalle=false;
    } 
    else if(dhaut == true && click==true && allowedBalle==true) { // Si tank vers le Haut
      balles.add(new Balle());
      balles.get(balle).info(tankX+3.75,tankY-25,0,-5,2,5);
      balle++;
      click=false;
      allowedBalle=false;
    } 
    else if(ddroite == true && click==true && allowedBalle==true) { // Si tank vers la Droite
      balles.add(new Balle());
      balles.get(balle).info(tankX+25,tankY+8.5,5,0,5,2);
      balle++;
      click=false;
      allowedBalle=false;
    } 
    else if(dgauche == true && click==true && allowedBalle==true) { // Si tank Vers la gauche
      balles.add(new Balle());
      balles.get(balle).info(tankX-25,tankY+8.5,-5,0,5,2);
      balle++;
      click=false;
      allowedBalle=false;
    }
    for (Balle tballes :balles){
      tballes.tirer();
    }
  }
}
void timerFin(){
  timerFin--;
  if (timerFin<0){
    fin=true;
    menu=true;
  }
}
void mouseReleased(){
  click=false;
}
void mousePressed(){
  click=true;
  balle();
}

// Menu qui change vers l'espace de jeu
void menu(){
  if(menu==true){
    timerFin=18000;
    textFont(mapolice, 70);
    background(imenu);
  if (textHasBeenClicked) {
        // display text 2
        
        // remplace le texte jouer par l'appel du fichier jeu.pde
        text("Jouer" , 100,150); 
    }
    else  {
        // display text 1
        text("Jouer" , 100,150); 
    }

  if (textHasBeenClicked1) {
        // display text 2
        text("Options" , 100,250); 
    }
    else  {
        // display text 1
        text("Options" , 100,250); 
    }
  }
}
// Si on Click alors change l'état booelan de menu
void mouseClicked() {
    // toggle
    if(menu==true){
      if((100 < mouseX+25)&&(100 > mouseX-75) && (150 < mouseY+50)&&(150 > mouseY-20)) {
         textHasBeenClicked = ! textHasBeenClicked;
         menu = false;
         // Effecer l'écriture Jouer & Options
      } 
      if((100 < mouseX+25)&&(100 > mouseX-75) && (250 < mouseY+50)&&(250 > mouseY-20)) {
         textHasBeenClicked1 = ! textHasBeenClicked1;
         menu = false;
      }
  }
}

void timea(){
  if(menu==false){
        fill(0);
        rect(290,0,50,30);
        timerFinMinutes=timerFin/3600;
        timerFinSecondes=timerFin-(timerFinMinutes*3600);
        fill(255);
        textFont(mapolice, 30);
        if(timerFinSecondes>600){
          text(timerFinMinutes +  ":" + timerFinSecondes/60, 297,22);
        }
        if(timerFinSecondes<600){
          text(timerFinMinutes +  ":0" + timerFinSecondes/60, 297,22);
        }
  }
}