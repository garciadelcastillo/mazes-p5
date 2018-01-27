/*
  I woke up in New Year's and felt like playing around a little with mazes,
 no clear roadmap laid... ;)
 */

import processing.pdf.*;
import java.util.*;

Graph graph;

void setup() {
  size(800, 800);
  //fullScreen();
  //frameRate(10);
  //noFill();

  graph = new Graph(false);
  noLoop();
}

void draw() {
  beginRecord(PDF, "maze.pdf");
  background(255);

  // These go here to be picked up by the PDF renderer
  stroke(0);
  //noStroke();
  strokeWeight(1);
  fill(191, 191);
  strokeJoin(BEVEL);

  //println(frameCount);

  graph.render();
  //graph.tick();
  
  saveFrame("screenshots/maze_" + now() + ".png");
  endRecord();
}








String now() {
  return nf(year(), 4) + "-" + nf(month(), 2) + "-" + nf(day(), 2) + "_" 
      + nf(hour(), 2) + "-" + nf(minute(), 2) + "-" + nf(second(), 2);
}