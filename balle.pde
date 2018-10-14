class Balle{
  private float orientationX1;
  private float orientationY1;
  private float directionX1;
  private float directionY1;
  private int tailleX1;
  private int tailleY1;
  
  public Balle(){
  }
  
  public void info(float orientationX,float orientationY, float directionX, float directionY,int tailleX, int tailleY){
    orientationX1=orientationX;
    orientationY1=orientationY;
    directionX1=directionX;
    directionY1=directionY;
    tailleX1=tailleX;
    tailleY1=tailleY;

  }
  public void tirer(){
    noStroke();
    fill(255);
    rect(orientationX1,orientationY1,tailleX1,tailleY1);
    orientationX1=orientationX1+directionX1;
    orientationY1=orientationY1+directionY1;
  }
}