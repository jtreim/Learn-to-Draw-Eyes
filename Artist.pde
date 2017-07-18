class Artist //<>//
{
  private final int HEIGHT = 1054;
  private final int WIDTH = 844;
  
  private int fill;
  private float stroke_width;
  private float pencil_x;
  private float pencil_y;
  private float eyeline_height;
  private float eyeline_width;
  private float eye_width;
  private float eye_height;
  
  private StringBuilder finished;
  private StringBuilder working_on;
  private boolean working;
  
    Artist()
  {
    fill = 0;
    stroke_width = .5; //<>//
    working_on = new StringBuilder("draw: ");
    finished = new StringBuilder("finished:");
    eyeline_height = (float)random(HEIGHT*.37, HEIGHT*.42);
    eyeline_width = (float)random(WIDTH*.2, WIDTH*.4);
    
    eye_width = eyeline_width/(random(2,6));
    float multiplier = random(1,4);
    multiplier = 1/multiplier;
    multiplier = abs(2 - multiplier);
    eye_height = eye_width / multiplier;
    
    working = false;
    
    float x = WIDTH - eyeline_width;
    x = x/2;
    pencil_x = x;
    pencil_y = eyeline_height;
  }
  
  public void drawLine(float x_end, float y_end, float max_stroke, String line_name)// Moves pencil position to be able to draw next portion of a line.
  {
    float x_dist = x_end - pencil_x;
    float y_dist = y_end - pencil_y;
    float difference = pow(x_dist, 2) + pow(y_dist, 2);                             // Checks distance from end of line to determine line tapering.
    difference = sqrt(difference);
    if(working_on.indexOf(line_name) == -1)                                         // Checks to see if just starting the line.
    {
      working_on.append(line_name);
      stroke_width = 0.5;
    }
    else if(difference <= 0.5)                                                      // Checks to see if the line is done.
    {
      int line_name_start = working_on.indexOf(line_name);
      working_on.delete(line_name_start, (working_on.length()));
      finished.append(line_name + " : ");
    }
    else                                                                            // Otherwise, must be int the middle of making the line.
    {
      if(stroke_width < max_stroke && difference > pow(max_stroke, 2)/2.5)
      {
        stroke_width += 0.5;
      }
      float slope_fraction = difference / stroke_width * 2;
      pencil_x += x_dist/slope_fraction;
      pencil_y += y_dist/slope_fraction;
    }
  }


  public boolean drawEyes()
  {
    if(working_on.indexOf("right eye") == -1 && finished.indexOf("and right eye") != -1)      // Completely finished, reset variables.
    {
      stroke_width = .5;
      working_on = new StringBuilder("draw: ");
      finished = new StringBuilder("finished: ");
      eyeline_height = (float)random(HEIGHT*.37, HEIGHT*.42);
      eyeline_width = (float)random(WIDTH*.2, WIDTH*.4);
    
      eye_width = eyeline_width/(random(2,4));
      float multiplier = random(1,4);
      multiplier = 1/multiplier;
      multiplier = abs(2 - multiplier);
      eye_height = eye_width / multiplier;
    
      working = false;
    
      float x = WIDTH - eyeline_width;
      x = x/2;
      pencil_x = x;
      pencil_y = eyeline_height;
      return false;
    }
    else if(working_on.indexOf("right eye") != -1 && finished.indexOf("and right eye") == -1) // Working on the right eye.
    {
      if(!drawRightEye())                                                                     // Just finished the right eye. If it's still working, 
      {                                                                                       // drawRightEye() returns true after moving pencil.
        int line_name_start = working_on.indexOf("right eye ");
        working_on.delete(line_name_start, (working_on.length() - 1));
        finished = new StringBuilder("finished: left eye and right eye");
      }
    }
    else if(working_on.indexOf("left eye ") != -1 && finished.indexOf("left eye ") == -1)     // Working on the left eye.
    {
      if(!drawLeftEye())
      {
        int line_name_start = working_on.indexOf("left eye ");                                // Just finished the left eye. If it's still working,
        working_on.delete(line_name_start, (working_on.length()));                            // drawLeftEye() returns true after moving pencil.
        finished = new StringBuilder("finished: left eye ");
          
        working_on.append("right eye ");
        int num = (int)random(1,5);
        switch(num)
        {
        case 1:
          eyeline_height += HEIGHT*random(-.01,.03);
          break;
        case 2:
          eyeline_height += WIDTH*random(-.03,.03);
          break;
        case 3:
          eyeline_height += HEIGHT*random(-.01,.03);
          eyeline_width += WIDTH*random(-.04,.04);
          break;
        default:
          break;
        }
        eye_width = eyeline_width/(random(2,6));
        float size_multiplier = random(1,4);
        size_multiplier = 1/size_multiplier;
        size_multiplier = abs(2 - size_multiplier);
        eye_height = eye_width / size_multiplier;
        pencil_x = WIDTH - (WIDTH - eyeline_width)/2;
        pencil_y = eyeline_height;
      }
    }
    else if(working_on.indexOf("left eye ") == -1 && finished.indexOf("left eye ") == -1)     // Just starting to draw the eyes, start with the left.
    {
      float x = width - eyeline_width;
      x = x/2;
      working_on.append("left eye ");
      drawLeftEye();
    }
    return true;
  }
  
  public boolean drawLeftEye()
  {
    if(working_on.indexOf("lower lid left") == -1 && finished.indexOf("lower lid left") != -1) // Finished drawing the left eye.
    {
      return false;
    }
    float x = (WIDTH - eyeline_width)/2;
    float y = eyeline_height;
    StringBuilder line_name = new StringBuilder();
    if(working_on.indexOf("top lid left ") == -1 && finished.indexOf("top lid left ") == -1)   // Starting the left eye.
    {
      x += eye_width * .25;
      y -= eye_height * .3;
      line_name = new StringBuilder("top lid left");
    }
    else if(finished.indexOf("top lid center ") == -1)
    {
      x += eye_width * .75;
      y -= eye_height/2;
      line_name = new StringBuilder("top lid center ");
    }
    else if(finished.indexOf("top lid right ") == -1)
    {
      x += eye_width * .9;
      y -= eye_height * .1;
      line_name = new StringBuilder("top lid right ");
    }
    else if(finished.indexOf("top lid tear duct ") == -1)
    {
      x += eye_width;
      line_name = new StringBuilder("top lid tear duct ");
    }
    else if(finished.indexOf("side tear duct ") == -1)
    {
      x += eye_width*.95;
      y += eye_height*.1;
      line_name = new StringBuilder("side tear duct ");
    }
    else if(finished.indexOf("lower lid tear duct ") == -1)
    {
      x += eye_width * .9;
      y += eye_height * .05;
      line_name = new StringBuilder("lower lid tear duct ");
    }
    else if(finished.indexOf("lower lid right ") == -1)
    {
      x += eye_width * .85;
      y += eye_height * .1;
      line_name = new StringBuilder("lower lid right ");
    }
    else if(finished.indexOf("lower lid center ") == -1)
    {
      x += eye_width * .3;
      y += eye_height * .3;
      line_name = new StringBuilder("lower lid center ");
    }
    else if(finished.indexOf("lower lid left") == -1)
    {
      line_name = new StringBuilder("lower lid left");
    }
    drawLine(x, y, 2, line_name.toString());
    return true;
  }
  
  public boolean drawRightEye()
  {
    if(working_on.indexOf("lower lid right") == -1 && finished.indexOf("lower lid right") != -1) // Finished drawing the right eye.
    {
      return false;
    }
    float x = WIDTH - (WIDTH - eyeline_width)/2;
    float y = eyeline_height;
    StringBuilder line_name = new StringBuilder();
    if(finished.indexOf("top lid right ") == -1)                                                // Starting the right eye.
    {
      x -= eye_width * .25;
      y -= eye_height * .3;
      line_name = new StringBuilder("top lid right ");
    }
    else if(finished.indexOf("top lid center ") == -1)
    {
      x -= eye_width * .75;
      y -= eye_height/2;
      line_name = new StringBuilder("top lid center ");
    }
    else if(working_on.indexOf("top lid left ") == -1 && finished.indexOf("top lid left ") == -1)
    {
      x -= eye_width * .9;
      y -= eye_height * .1;
      line_name = new StringBuilder("top lid left");
    }
    else if(finished.indexOf("top lid tear duct ") == -1)
    {
      x -= eye_width;
      line_name = new StringBuilder("top lid tear duct ");
    }
    else if(finished.indexOf("side tear duct ") == -1)
    {
      x -= eye_width*.95;
      y += eye_height*.1;
      line_name = new StringBuilder("side tear duct ");
    }
    else if(finished.indexOf("lower lid tear duct ") == -1)
    {
      x -= eye_width * .9;
      y += eye_height * .05;
      line_name = new StringBuilder("lower lid tear duct ");
    }
    else if(finished.indexOf("lower lid left ") == -1)
    {
      x -= eye_width * .85;
      y += eye_height * .1;
      line_name = new StringBuilder("lower lid left ");
    }
    else if(finished.indexOf("lower lid center ") == -1)
    {
      x -= eye_width * .3;
      y += eye_height * .3;
      line_name = new StringBuilder("lower lid center ");
    }
    else if(finished.indexOf("lower lid right") == -1)
    {
      line_name = new StringBuilder("lower lid right");
    }
    drawLine(x, y, 2, line_name.toString());
    return true;
  }
  
  public int getFill(){ return fill; }
  public float getPencilX(){ return pencil_x; }
  public float getPencilY(){ return pencil_y; }
  public float getStrokeWidth(){ return stroke_width; }
  public String getWorkingOn(){ return working_on.toString(); }
  public String getFinished(){ return finished.toString(); }
}