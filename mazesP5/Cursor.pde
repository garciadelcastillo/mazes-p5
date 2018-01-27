class Cursor {
  
  Node currentNode;
  Graph parent;
 
  ArrayList<Node> stack;  // all the nodes visited in current branch
  
  int visitedCount = 0;  // how many nodes has the cursor visited in the currrrent branch?
  int maxDepth = 0;      // what is the max depth ever reached?
  
  Cursor(Graph parent_, Node startNode) {
    parent = parent_;
    currentNode = startNode;
    startNode.visited = true;
    stack = new ArrayList<Node>();
    stack.add(currentNode);
  }
  
  void render() {
    pushStyle();
    noStroke();
    fill(255, 0, 0, 100);
    ellipse(currentNode.x, currentNode.y, 10, 10);
    fill(0, 0, 255);
    textSize(20);
    text(visitedCount, currentNode.x, currentNode.y);
    popStyle();
  }
  
  boolean searchNext() {
    ArrayList<Node> unvisitedNeighbours = currentNode.getUnvisitedNeighbours();
     
    boolean walked = false;
    int size = unvisitedNeighbours.size();
    if (size == 0) {
      walked = walkBack();
      if (!walked) {
        println("Finished graph!");
      }
    } else {
      Node randomNode = unvisitedNeighbours.get((int) random(size));
      linkTo(randomNode);
      walked = true;
    }
    return walked;
  }
  
  // Starts a random walk that iterates over all possible cells.
  void searchDeep() {
    while(searchNext()) {/* */}
  }
  
  boolean walkBack() {
    int size = stack.size();
    if (size > 1) {
      moveTo(stack.get(size - 2));
      stack.remove(size - 1);
      this.visitedCount--;
      return true;
    }
    return false;
  }
  
  void linkTo(Node targetNode) {
    Link link = new Link(currentNode, targetNode);
    parent.links.add(link);
    moveTo(targetNode);
    targetNode.visited = true;
    stack.add(targetNode);
    
    this.visitedCount++;
    targetNode.visitDepth = this.visitedCount;
    if (maxDepth < visitedCount) {
      maxDepth = visitedCount;
    }
  }
  
  void moveTo(Node targetNode) {
    currentNode = targetNode;
  }
  
  
}