class Node {
  int id;
  float x, y;
  boolean visited;
  
  ArrayList<Node> neighbours;
  ArrayList<Link> incoming, outgoing;

  Node(int id_, float x_, float y_) {
    id = id_;
    x = x_;
    y = y_;
    
    neighbours = new ArrayList<Node>();
    
    incoming = new ArrayList<Link>();
    outgoing = new ArrayList<Link>();
  }
  
  Node(int id_) {
    this(id_, random(width), random(height));
  }
  
  void render() {
    //stroke(0);
    //noFill();
    //ellipse(x, y, 6, 6);

    renderOutgoingLinks();
    //renderNeighbourConnections();
  }
  
  void renderNeighbourConnections() {
    stroke(0, 20);
    for (Node n : neighbours) {
      line(x, y, n.x, n.y);
    }
  }
  
  void renderOutgoingLinks() {
    stroke(255, 0, 0, 150);
    strokeWeight(3);
    for (Link l : outgoing) {
      l.render();
    }
  }
  
  ArrayList<Node> getUnvisitedNeighbours() {
    ArrayList<Node> virgins = new ArrayList<Node>();
    for (Node n : neighbours) {
      if (n.visited == false) {
        virgins.add(n);
      }
    }
    return virgins;
  }

}