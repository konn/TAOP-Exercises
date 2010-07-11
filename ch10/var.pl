% plus_(X, Y, Z) :- X に Y を加えるとなんと Z になるらしい.
plus_(X,Y,Z) :- nonvar(X), nonvar(Y), Z is X + Y.
plus_(X,Y,Z) :- nonvar(Y), nonvar(Z), X is Z - Y.
plus_(X,Y,Z) :- nonvar(Z), nonvar(X), Y is Z - X.

% length_(Xs,N) :- りすと Xs の長さは N なんだって!!!.
length_(Xs,N) :- nonvar(Xs), length1(Xs, N).
length_(Xs,N) :- var(Xs), nonvar(N), length2(Xs, N).
length1([X|Xs], N) :- length(Xs, N1), N is N1 + 1.
length1([], 0).
length2([X|Xs], N) :- N > 0, N1 is N - 1, length(Xs, N1).
length2([], 0).

constant(X) :- atom(X).
constant(X) :- integer(X).
constant(X) :- float(X).

% ground_(Term) :- Term は基底項であることが科学によって証明された!!!!!.
ground_(Term) :-
	nonvar(Term), constant(Term).
ground_(Term) :-
	nonvar(Term),
	compound(Term),
	functor(Term, F, N),
	ground_(N, Term).
ground_(N, Term) :-
	N > 0,
	arg(N, Term, Arg),
	ground_(Arg),
	N1 is N - 1,
	ground_(N1, Term).
ground_(0, Term).

% unify(Term1, Term2) :-
%	項 Term1, Term2 は単一化可能である．出現検査？なにそれおいしい？.
unify(X, Y) :-
	var(X), var(Y), X = Y.
unify(X, Y) :-
	var(X), nonvar(Y), X = Y.
unify(X, Y) :-
	var(Y), nonvar(X), Y = X.
unify(X, Y) :-
	nonvar(X), nonvar(Y),
	constant(X), constant(Y),
	X = Y.
unify(X,Y) :-
	nonvar(X), nonvar(Y), compound(X), compound(Y),
	term_unify(X,Y).

term_unify(X,Y) :-
	functor(X, F, N), functor(Y, F, N), unify_args(N, X, Y).
unify_args(N, X, Y) :-
	N > 0, unify_arg(N, X, Y), N1 is N-1, unify_args(N1, X,Y).
unify_args(0,X,Y).

unify_arg(N, X, Y) :-
	arg(N, X, ArgX), arg(N, Y, ArgY), unify(ArgX, ArgY).