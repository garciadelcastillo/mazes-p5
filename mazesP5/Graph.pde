class Graph {
  
  ArrayList<Node> nodes;
  ArrayList<Link> links;
  Cursor cursor;
  
  int cellsX = 100;
  int cellsY = 50;
  
  boolean tickerGeneration;
  boolean complete = false;
  
  Graph(boolean useTicker) {
    nodes = new ArrayList<Node>();
    links = new ArrayList<Link>();
 
    //generateNodes(200);
    generateNodes(cellsX, cellsY);
    assignNeighbours(cellsX, cellsY);
    
    cursor = new Cursor(this, nodes.get(0));
    
    tickerGeneration = useTicker;
    
    if (!tickerGeneration) {
      generateFullGraph();
    }
  }
  
  void generateNodes(int count) {
    for (int i = 0; i < count; i++) {
      nodes.add(new Node(i));
    }
  }
  
  void generateNodes(int countX, int countY) {
    float dx = width / (float) countX;
    float dy = height / (float) countY;
    
    int it = 0;
    float x, y;
    for (int i = 0; i < countX; i++) {
      for (int j = 0; j < countY; j++) {
        x = 0.5 * dx + i * dx;
        y = 0.5 * dy + j * dy;
        nodes.add(new Node(it++, x, y));
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
  
  void assignNeighbours(int countX, int countY) {
    float max = width / (float) countX;
    if (height / (float) countY > max) 
      max = height / (float) countY;
    
    assignNeighbours(1.05 * max);
  }
  
  void render() {
    for (Node n : nodes) {
      n.render();
    }
    cursor.render();
  }
  
  void tick() {
    cursor.searchNext();
  }
  
  void generateFullGraph() {
    cursor.searchDeep();
  }
  
}