class Wall implements Comparable {
  
  Graph parent;
  Node n0, n1;
  float centerX, centerY, len, angle;
  float[] v = new float[8];  // vertices for a quad representation of deep wall
  float distanceToCenterSq = 0;  // squared distance to graph center, for overlapping comparisons
  
  Wall(Graph parent, Link link) {
    this.parent = parent;
    n0 = link.from;
    n1 = link.to;
    compute();
  }
  
  Wall(Graph parent, Node n0_, Node n1_) {
    this.parent = parent;
    n0 = n0_;
    n1 = n1_;
    compute();
  }
  
  // Performs calculation of wall coordinates
  // based on cell type
  void compute() {
    // It is assumed here that cells are square, 
    // and sizes can be fetched from cell. To be improved...
    this.centerX = n0.x + 0.5 * (n1.x - n0.x); 
    this.centerY = n0.y + 0.5 * (n1.y - n0.y);
    float dx = this.parent.centerX - this.centerX;
    float dy = this.parent.centerY - this.centerY;
    distanceToCenterSq = dx * dx + dy * dy;
    
    angle = atan2(n1.y - n0.y, n1.x - n0.x);
    len = abs(angle % PI) < 0.01 ? 0.5 * n0.h : 0.5 * n0.w;  // gross oversimplification...
    
    // Compute quad wall depth points as a normalized distance to the center
    v[0] = centerX + len * cos(angle - HALF_PI);
    v[1] = centerY + len * sin(angle - HALF_PI);
    v[2] = centerX + len * cos(angle + HALF_PI);
    v[3] = centerY + len * sin(angle + HALF_PI);
    v[4] = v[2] + (parent.centerX - v[2]) * parent.depth;
    v[5] = v[3] + (parent.centerY - v[3]) * parent.depth;
    v[6] = v[0] + (parent.centerX - v[0]) * parent.depth;
    v[7] = v[1] + (parent.centerY - v[1]) * parent.depth;
  }
  
  // Changes the internal orientation of this wall, 
  // i.e. switching the start/end points
  void flip() {
    float[] source = v.clone();
    
    v[0] = source[2];
    v[1] = source[3];
    v[2] = source[0];
    v[3] = source[1];
    v[4] = source[6];
    v[5] = source[7];
    v[6] = source[4];
    v[7] = source[5];
    
    angle += PI;
  }
  
  void renderLine() {
    line(v[0], v[1], v[2], v[3]);
  }
  
  void renderQuad() {
    quad(v[0], v[1], v[2], v[3], v[4], v[5], v[6], v[7]);
  }
  
  public int compareTo(Object other) {
     float d = ((Wall)other).distanceToCenterSq - this.distanceToCenterSq;
     return d < 0 ? -1 : (d > 0 ? 1 : 0);
  }
  
  public String toString() {
    return "";
  }
  
}