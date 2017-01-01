class Cursor {
  
  Node currentNode;
  Graph parent;
 
  ArrayList<Node> stack;
  
  Cursor(Graph parent_, Node startNode) {
    parent = parent_;
    currentNode = startNode;
    startNode.visited = true;
    stack = new ArrayList<Node>();
    stack.add(currentNode);
  }
  
  void render() {
    noStroke();
    fill(255, 0, 0, 100);
    ellipse(currentNode.x, currentNode.y, 10, 10);
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
    if (size > 0) {
      moveTo(stack.get(size - 1));
      stack.remove(size - 1);
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
  }
  
  void moveTo(Node targetNode) {
    currentNode = targetNode;
  }
  
  
}