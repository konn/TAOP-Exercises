constant(X) :- atom(X).
constant(X) :- integer(X).

% flatten1(Xs, Ys) :- Ys は Xs の要素のリストである.
flatten1([X|Xs], Ys3) :-
	flatten2(X, Ys1), flatten2(Xs, Ys2), append(Ys1, Ys2, Ys3).
flatten1(X, [X]) :-
	constant(X), X \= [].
flatten1([], []).

flatten2(Xs, Ys) :- flatten2(Xs, [], Ys).
flatten2([X|Xs], S, Ys) :-
	list(X), flatten2(X, [Xs|S], Ys).
flatten2([X|Xs], S, [X|Ys]) :-
	constant(X), X \= [], flatten2(Xs, S, Ys).
flatten2([], [X|S], Ys) :-
	flatten2(X, S, Ys).
flatten2([],[],[]).
list([X|Xs]).