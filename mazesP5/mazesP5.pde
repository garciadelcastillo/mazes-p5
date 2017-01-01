/*
  I woke up in New Year's and felt like playing around a little with mazes,
  no clear roadmap laid... ;)
*/

Graph graph;

void setup() {
  //size(800, 600);
  fullScreen();
  //frameRate(10);
  noFill();
  
  graph = new Graph();
}

void draw() {
  background(255);
  
  println(frameCount);
  
  graph.render();
  graph.tick();
  
  //saveFrame("data/######.png");
}