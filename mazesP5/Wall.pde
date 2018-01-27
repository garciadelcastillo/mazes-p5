class Wall {
  
  Node n0, n1;
  float x0, y0, x1, y1;
  float x2, y2;
  
  Wall(Link link) {
    n0 = link.from;
    n1 = link.to;
    compute();
  }
  
  Wall(Node n0_, Node n1_) {
    n0 = n0_;
    n1 = n1_;
    compute();
  }
  
  // Performs calculation of wall coordinates
  // based on cell type
  void compute() {
    // It is assumed here that cells are square, 
    // and sizes can be fetched from cell. To be improved...
    float x2 = n0.x + 0.5 * (n1.x - n0.x); 
    float y2 = n0.y + 0.5 * (n1.y - n0.y);
    float a2 = atan2(n1.y - n0.y, n1.x - n0.x);
    float w2 = 0.5 * n0.w;  // gross oversimplification...
    
    this.x2 = x2;
    this.y2 = y2;
    x0 = x2 + w2 * cos(a2 - HALF_PI);
    y0 = y2 + w2 * sin(a2 - HALF_PI);
    x1 = x2 + w2 * cos(a2 + HALF_PI);
    y1 = y2 + w2 * sin(a2 + HALF_PI);
  }
  
  void render() {
    line(x0, y0, x1, y1);
  }
  
  
}