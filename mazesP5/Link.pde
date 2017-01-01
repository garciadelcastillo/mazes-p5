class Link {
  Node from;
  Node to;
  
  Link(Node from_, Node to_) {
    from = from_;
    from.outgoing.add(this);
    to = to_;
    to.incoming.add(this);
  }
  
  void render() {
    line(from.x, from.y, to.x, to.y);
  }
}