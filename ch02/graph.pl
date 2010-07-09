edge(a, b).
edge(a, c).
edge(b, d).
edge(c, d).
edge(d, e).
edge(f, g).

connected(Node, Node).
connected(Node1, Node2) :-
	edge(Node1, Link), connected(Link, Node2).

above(Block1, Block2) :- on(Block1, Block2).
above(Block1, Block2) :- on(Block1, Other), above(Other, Block2).