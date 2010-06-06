edge(a, b).
edge(a, c).
edge(b, d).
edge(c, d).
edge(d, e).
edge(f, g).

% connected(Node1, Node2) :-
%	Node1 は、関係 edge/2 で定義されたグラフ中で Node2 に連結されている。
connected(Node, Node).
connected(Node1, Node2) :-
	edge(Node1, Link), connected(Link, Node2).

% on(Block1, Block2) :- Block1 が Block2 の真上にある。
% above(Block1, Block2) :- Block1 が Block2 の上方にある
above(Block1, Block2) :- on(Block1, Block2).
above(Block1, Block2) :- on(Block1, Other), above(Other, Block2).