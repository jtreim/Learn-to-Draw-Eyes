final int OPACITY_MAX = 200;
class Eraser
{
  private final int HEIGHT = 1054;
  private final int WIDTH = 844;
  
  private float stroke_width;
  private float eraser_x;
  private float eraser_y;
  private int erase_count;
  private float erase_width;
  private float erase_height;
  private float opacity;
  
  private boolean working;
  
  public Eraser()
  {
    stroke_width = 20;
    erase_width = random(WIDTH*.25, WIDTH*.6);
    erase_height = random(HEIGHT*.02, HEIGHT*.15);
    erase_count = 0;
    eraser_x = (WIDTH - erase_width)/2;
    eraser_y = (HEIGHT - erase_height)/2 - 105;
    working = false;
    opacity = OPACITY_MAX;
  }
  
  public boolean eraseAll(float count) //<>//
  {
    if(erase_count == count) //<>//
    {
      erase_width = random(WIDTH*.15, WIDTH*.6);
      erase_height = random(HEIGHT*.01, HEIGHT*.15);
      erase_count = 0;
      eraser_x = (WIDTH - erase_width)/2 - 15;
      eraser_y = (HEIGHT - erase_height)/2 - 105;
      opacity = OPACITY_MAX;
      return false;
    }
    float erase_percentage = (float)erase_count/(float)count;
    if(erase_percentage >= .5){
      opacity = OPACITY_MAX - OPACITY_MAX*erase_percentage;
    }
    else
    {
      opacity = OPACITY_MAX*erase_percentage;
    }
    float x;
    float y = (HEIGHT - erase_height)/2 + erase_height*erase_percentage - 105;
    if(erase_count%2 == 0)
    {
      x = WIDTH - (WIDTH - erase_width)/2;
    }
    else
    {
      x = (WIDTH - erase_width)/2;
    }
    x -= 15;
    eraseLine(x, y);
    return true;
  }
  
  public void eraseLine(float x_end, float y_end)
  {
    float x_dist = x_end - eraser_x;
    float y_dist = y_end - eraser_y;
    float difference = pow(x_dist, 2) + pow(y_dist, 2);                             
    difference = sqrt(difference);
    if(difference <= 10)                                                           // Checks to see if the line is done.
    {
      erase_count++;
    }
    else                                                                            // Otherwise, must be int the middle of making the line.
    {
      float slope_fraction = difference / 6;
      eraser_x += x_dist/slope_fraction;
      eraser_y += y_dist/slope_fraction;
    }
  }
  
  public float getOpacity(){ return opacity; }
  public float getEraserX(){ return eraser_x; }
  public float getEraserY(){ return eraser_y; }
  public float getStrokeWidth(){ return stroke_width; }
}