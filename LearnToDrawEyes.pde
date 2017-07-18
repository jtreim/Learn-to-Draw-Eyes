Artist artist = new Artist();
Eraser eraser = new Eraser();
int frame = 0;
int erase_cnt;
PImage bg;

void setup()
{
  size(844, 1054);
  noStroke();
  background(255);
  frameRate(400);
}

void draw()
{
    frame++;
   if(!artist.working && !eraser.working)                                      // Start drawing eyes.
    { 
      artist.working = true;
      artist.drawEyes(); //<>//
    }
    else if(artist.working && !eraser.working && !artist.drawEyes())          // Stopping the artist and starting to erase
    {
      eraser.working = true;
      artist.working = false;
      erase_cnt  = (int)random(8,15);
      eraser.eraseAll(erase_cnt);
    }
    else if(!artist.working && eraser.working && !eraser.eraseAll(erase_cnt)) // Stopping the eraser to draw eyes again.
    {
      eraser.working = false; //<>//
    }
    if(artist.working)
    {
      fill(artist.getFill(), 80);
      ellipse(artist.getPencilX(), artist.getPencilY(), artist.getStrokeWidth(), artist.getStrokeWidth());
    }
    else if(eraser.working)
    {
      fill(255, eraser.getOpacity());
      ellipse(eraser.getEraserX(), eraser.getEraserY(), eraser.getStrokeWidth(), eraser.getStrokeWidth());
    }
    
    fill(255);
    rect(0, 600, 150, 30);
    if(artist.working)
    {
      fill(artist.getFill());
      StringBuilder out = new StringBuilder();
      out.append(artist.getWorkingOn());
      text(out.toString(), 10, 599, 149, 29);
    }
    else if(eraser.working)
    {
      fill(255);
      rect(0, 600, 150, 30);
      fill(0);
      text("erasing . . .", 10, 599, 149, 29);
    }
}