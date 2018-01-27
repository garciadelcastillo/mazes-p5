/*
  I woke up in New Year's and felt like playing around a little with mazes,
  no clear roadmap laid... ;)
*/

import processing.pdf.*;

Graph graph;

void setup() {
  size(800, 800);
  //fullScreen();
  //frameRate(10);
  noFill();
  
  graph = new Graph(false);
  noLoop();
}

void draw() {
  beginRecord(PDF, "maze.pdf");
  background(255);
  
  //println(frameCount);
  
  graph.render();
  //graph.tick();
  
  //saveFrame("data/######.png");
  endRecord();
}