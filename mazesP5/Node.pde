class Node {
  int id;
  float x, y;
  boolean visited;
  boolean solid;  // can this node be traversed? useful for border nodes, internal islands, etc. 

  ArrayList<Node> neighbours;
  ArrayList<Link> incoming, outgoing;

  // Assuming square cells... (to improve)
  float w, h, w2, h2;
  
  int visitDepth = 0;  // when the cursor reaches this node, how many nodes were visited before?

  Node(int id_, float x_, float y_, float w_, float h_, boolean solid) {
    id = id_;
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    w2 = 0.5 * w;
    h2 = 0.5 * h;
    this.solid = solid;
    if (this.solid) this.visited = true;

    neighbours = new ArrayList<Node>();
    incoming = new ArrayList<Link>();
    outgoing = new ArrayList<Link>();
  }

  Node(int id_, float x_, float y_) {
    this(id_, x_, y_, 0, 0, false);
  }

  Node(int id_) {
    this(id_, random(width), random(height), 0, 0, false);
  }

  void render() {
    //stroke(0);
    //noFill();
    //ellipse(x, y, 6, 6);

    //renderOutgoingLinks();
    //renderNeighbourConnections();
    
    //if (this.solid) {
    //  quad(x - w2, y - h2, x + w2, y - h2, x + w2, y + h2, x - w2, y + h2);
    //}
  }

  void renderNeighbourConnections() {
    stroke(0, 20);
    for (Node n : neighbours) {
      line(x, y, n.x, n.y);
    }
  }

  void renderOutgoingLinks() {
    stroke(255, 0, 0, 150);
    strokeWeight(1);
    for (Link l : outgoing) {
      l.render();
    }
  }

  ArrayList<Node> getUnvisitedNeighbours() {
    ArrayList<Node> virgins = new ArrayList<Node>();
    for (Node n : neighbours) {
      if (!n.visited) {
        virgins.add(n);
      }
    }
    return virgins;
  }

  ArrayList<Node> getUnlinkedNeighbours() {
    ArrayList<Node> unlinked = (ArrayList<Node>) neighbours.clone();

    for (Link link : incoming) {
      unlinked.remove(link.from);
    }

    for (Link link : outgoing) {
      unlinked.remove(link.to);
    }

    return unlinked;
  }
}