class Graph {

  ArrayList<Node> nodes;
  ArrayList<Link> links;
  ArrayList<Wall> walls;
  Cursor cursor;
  Node startNode;

  int cellsX = 21;
  int cellsY = 21;
  float depth = 0.05;  // normalized distance to graph center

  float centerX, centerY;

  boolean tickerGeneration;
  boolean complete = false;

  Graph(boolean useTicker) {
    nodes = new ArrayList<Node>();
    links = new ArrayList<Link>();
    walls = new ArrayList<Wall>();

    //generateNodes(200);
    generateNodes(cellsX, cellsY);
    assignNeighbours(cellsX, cellsY);
    computeCenter();

    //this.startNode = nodes.get(nodes.size() / 2);  // central node
    this.startNode = nodes.get(nodes.size() - cellsX / 2 - 1);  // bottom center
    //this.startNode = nodes.get(cellsX + cellsX / 2);  // top center
    //this.startNode = nodes.get(cellsX);  // top left corner
    cursor = new Cursor(this, this.startNode);  // start from the center?

    tickerGeneration = useTicker;

    if (!tickerGeneration) {
      generateFullGraph();
    }
  }

  void generateNodes(int count) {
    for (int i = 0; i < count; i++) {
      nodes.add(new Node(this, i));
    }
  }

  void generateNodes(int countX, int countY) {
    float dx = width / (float) countX;
    float dy = height / (float) countY;

    int it = 0;
    float x, y;
    boolean solid = false;
    
    for (int j = 0; j < countY; j++) {
      for (int i = 0; i < countX; i++) {
        x = 0.5 * dx + i * dx;
        y = 0.5 * dy + j * dy;
        solid = (i == 0 || i == countX - 1 || j == 0 || j == countY - 1);  // border walls
        nodes.add(new Node(this, it++, x, y, dx, dy, solid));
      }
    }
  }

  void assignNeighbours(float dist) {
    int len = nodes.size();
    for (int i = 0; i < len; i++) {
      Node n0 = nodes.get(i);
      for (int j = i + 1; j < len; j++) {
        Node n1 = nodes.get(j);
        if (dist(n0.x, n0.y, n1.x, n1.y) < dist) {
          n0.neighbours.add(n1);
          n1.neighbours.add(n0);
        }
      }
    }
  }

  void computeCenter() {
    float mx = 0, 
      my = 0;
    for (Node n : nodes) {
      mx += n.x;
      my += n.y;
    }
    centerX = mx / nodes.size();
    centerY = my / nodes.size();
    //println("Graph center: " + centerX + " " + centerY);
  }

  void assignNeighbours(int countX, int countY) {
    float max = width / (float) countX;
    if (height / (float) countY > max) 
      max = height / (float) countY;

    assignNeighbours(1.05 * max);
  }

  void render() {
    for (Node n : nodes) 
      n.render();

    for (Wall w : walls) {
      //w.renderLine();
      w.renderQuad();
    }

    if (tickerGeneration) 
      cursor.render();
      
    //ellipse(startNode.x, startNode.y, 4, 4);
  }

  void tick() {
    cursor.searchNext();
  }

  void generateFullGraph() {
    cursor.searchDeep();
    generateWalls();
    sortWallsByDistance();
    computeNodeFloor();
  }

  void generateWalls() {
    // Search all nodes, compare neighbours to i/o links, 
    // and create walls between unconnected nodes.
    ArrayList<Node> neigs;
    for (Node node : nodes) {
      if (node.solid) continue;  // if solid, let the neoghbouring non-solid node create the wall

      neigs = node.getUnlinkedNeighbours();
      for (Node n : neigs) {
        walls.add(new Wall(this, node, n));
      }
    }
  }

  // Resorts the walls list with elements from farthest to closest to the center.
  // This is useful for correct overlaps when rendering the walls.
  void sortWallsByDistance() {
    Collections.sort(walls);  // sortable because it implements the Comparable interface
  }
  
  void computeNodeFloor() {
    for (Node n : nodes) {
      n.computeFloor();
    }
  }
}