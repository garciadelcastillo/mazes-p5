/*
  I woke up in New Year's and felt like playing around a little with mazes,
  no clear roadmap laid... ;)
 
  TODO
    - [ ] Node floor decrease is linear, which means it could reach the focal point. Make it 1/x or similar
 */

float NODE_FLOOR_DEPTH_FACTOR = 0;
boolean NODE_FLOOR_SHALLOW_FIRST = false;
boolean NODE_RENDER_SOLID = false;

import processing.pdf.*;
import java.util.*;

Graph graph;

float oscAngle = 0;

void setup() {
  size(800, 800);
  //fullScreen();
  frameRate(30);
  //noFill();

  graph = new Graph(false);
  //noLoop();
}

void draw() {
  //beginRecord(PDF, "maze.pdf");
  background(255);

  // These go here to be picked up by the PDF renderer
  stroke(0);
  //noStroke();
  strokeWeight(1);
  fill(191, 191);
  strokeJoin(BEVEL);
  textAlign(CENTER, CENTER);
  textSize(12);

  //println(frameCount);
  
  graph.updateGraphGeometry();
  graph.render();
  //graph.tick();
  
  saveFrame("screenshots/maze_" + now() + "_" + nf(frameCount, 4) + ".png");
  
  oscAngle += PI / 60.0;
  NODE_FLOOR_DEPTH_FACTOR = 0.001 * sin(oscAngle);
  if (oscAngle > PI) exit();
  
  //endRecord();
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) { 
      NODE_FLOOR_DEPTH_FACTOR += 0.0001;
    } else if (keyCode == DOWN) {
      NODE_FLOOR_DEPTH_FACTOR -= 0.0001;
    }
    graph.updateGraphGeometry();
  }
}







String now() {
  return nf(year(), 4) + "-" + nf(month(), 2) + "-" + nf(day(), 2) + "_" 
      + nf(hour(), 2) + "-" + nf(minute(), 2) + "-" + nf(second(), 2);
}