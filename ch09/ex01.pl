constant(X) :- atom(X).
constant(X) :- integer(X).

% flatten1(Xs, Ys) :- Ys は Xs の要素のリストである.
flatten1(Xs, Ys) :- flatten1(Xs, [], Ys).
flatten1([X|Xs], Acc, Ys) :-
	flatten1(Xs, Acc, Acc1), flatten1(X, Acc1, Ys).
flatten1(X, Acc, [X|Acc]) :-
	constant(X), X \= [].
flatten1([], Ys , Ys).