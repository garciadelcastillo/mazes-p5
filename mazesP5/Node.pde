class Node {
  int id;
  float x, y;
  boolean visited;
  boolean solid;  // can this node be traversed? useful for border nodes, internal islands, etc. 

  Graph parent;
  ArrayList<Node> neighbours;
  ArrayList<Link> incoming, outgoing;

  // Assuming square cells... (to improve)
  float w, h, w2, h2;
  
  int visitDepth = 0;  // when the cursor reaches this node, how many nodes were visited before?
  
  float[] v = new float[8];  // quad floor vertices
  float floorDepth = 0;      // quad floor depth relative to the baseline

  Node(Graph parent, int id_, float x_, float y_, float w_, float h_, boolean solid) {
    this.parent = parent;
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

  Node(Graph parent, int id_, float x_, float y_) {
    this(parent, id_, x_, y_, 0, 0, false);
  }

  Node(Graph parent, int id_) {
    this(parent, id_, random(width), random(height), 0, 0, false);
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
    
    //text(this.visitDepth, x, y);
    println("renderingnode " + id);
    //println(v);
    if (!solid) renderFloor();
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
  
  void renderFloor() {
    pushStyle();
    fill(255, 0, 0, 63);
    quad(v[0], v[1], v[2], v[3], v[4], v[5], v[6], v[7]);
    //ellipse(v[0], v[1], 4, 4);
    popStyle();
  }
  
  void computeFloor() {
    // ugh, this looks so bad...
    //depth = parent.depth;
    //float dx = this.parent.centerX - x - w2,
    //      dy = this.parent.centerY - y - h2;
    //v[0] = x + dx * depth;
    //v[1] = y + dy * depth;
    //dx = this.parent.centerX - x + w2;
    //v[2] = x + dx * depth;
    //v[3] = y + dy * depth;
    //dy = this.parent.centerY - y + h2;
    //v[4] = x + dx * depth;
    //v[5] = y + dy * depth;
    //dx = this.parent.centerX - x - w2;
    //v[6] = x + dx * depth;
    //v[7] = y + dy * depth;
    
    float dx = parent.centerX - (x - w2),
          dy = parent.centerY - (y - h2);
    v[0] = x - w2 + dx * parent.depth;
    v[1] = y - h2 + dy * parent.depth;
    
    dx = this.parent.centerX - (x + w2);
    v[2] = x + w2 + dx * parent.depth;
    v[3] = y - h2 + dy * parent.depth;
    
    dy = parent.centerY - (y + h2);
    v[4] = x + w2 + dx * parent.depth;
    v[5] = y + h2 + dy * parent.depth;
    
    dx = parent.centerX - (x - w2);
    v[6] = x - w2 + dx * parent.depth;
    v[7] = y + h2 + dy * parent.depth;
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