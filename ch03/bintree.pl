% binary_tree(Tree) :- Tree は 二分木である。
binary_tree(void).
binary_tree(tree(Element, Left, Right)) :-
	binary_tree(Left), binary_tree(Right).

% tree_member(Element, Tree) :- Element は 二分木 Tree の要素である。
tree_member(X, tree(X, Left, Right)).
tree_member(X, tree(Y, Left, Right)) :- tree_member(X, Left).
tree_member(X, tree(Y, Left, Right)) :- tree_member(X, Right).

% isotree(Tree1, Tree2) :- Tree1, Tree2 は同型な二分木である。
isotree(void, void).
isotree(tree(X, Left1, Right1), tree(X, Left2, Right2)) :-
	isotree(Left1, Left2), isotree(Right1, Right2).
isotree(tree(X, Left1, Right1), tree(X, Left2, Right2)) :-
	isotree(Left1, Right2), isotree(Right1, Left2).

% substitute(X, Y, TreeX, TreeY) :-
%	二分木 TreeY は、二分木 TreeX 中に現れるX を総て Y で置換したものである。
substitute(X, Y, void, void).
substitute(X, Y, tree(X, Left, Right), tree(Y, Left1, Right1)) :-
	substitute(X, Y, Left, Left1), substitute(X, Y, Right, Right1).
substitute(X, Y, tree(Z, Left, Right), tree(Z, Left1, Right1)) :-
	X \= Z,
	substitute(X, Y, Left, Left1), substitute(X, Y, Right, Right1).

% pre_order(Tree, Pre) :-
%	Pre は Tree の節点を前置順序で並べたものである。
pre_order(tree(X,L,R), Xs) :-
	pre_order(L, Ls), pre_order(R, Rs), append([X|Ls], Rs, Xs).
pre_order(void, []).

% in_order(Tree, In) :-
%	In は Tree の節点を中置順序で並べたものである。
in_order(tree(X,L,R), Xs) :-
	in_order(L, Ls), in_order(R, Rs), append(Ls, [X|Rs], Xs).
in_order(void, []).

% post_order(Tree, Post) :-
%	Post は Tree の節点を中置順序で並べたものである。
post_order(tree(X,L,R), Xs) :-
	post_order(L, Ls), post_order(R, Rs),
	append(Rs, [X], Rs1), append(Ls, Rs1, Xs).
post_order(void, []).

% subtree(S, T) :- 二分木 S は二分木 T の部分木である。
subtree(S, S).
subtree(S, tree(X, Left, Right)) :- subtree(S, Left).
subtree(S, tree(X, Left, Right)) :- subtree(S, Right).

% sum_tree(Tree, Sum) :- Sum は二分木 Tree の合計である。
sum_tree(void, 0 ).
sum_tree(tree(N, L, R), Sum) :-
	sum_tree(L, SumL), sum_tree(R, SumR),
	plus(SumL, SumR, Sum1), plus(Sum1, N, Sum).

% ordered(TreeOfIntegers) :- 二分木 TreeOfIntegers は整数を要素に含む順序木である。
ordered(void).
ordered(tree(X, L, R)) :- ordered_left(X, L), ordered_right(X, R).

ordered_left(X, void).
ordered_left(X, tree(Y, L, R)) :-
	ordered(L), ordered(R), Y < X.

ordered_right(X, void).
ordered_right(X, tree(Y, L, R)) :-
	ordered(L), ordered(R), Y > X.

% tree_insert(X, Tree, Tree1) :- X を二分順序木 Tree に挿入すると二分順序木 Tree1 になる。
tree_insert(X, void, tree(X, void, void)).
tree_insert(X, tree(X, L, R), tree(X, L, R)).
tree_insert(X, tree(Y, L, R), tree(Y, L, R1)) :-
	X > Y, tree_insert(X, R, R1).
tree_insert(X, tree(Y, L, R), tree(Y, L1, R)) :-
	X < Y, tree_insert(X, L, L1).
