constant(X) :- atom(X).
constant(X) :- integer(X).
constant(X) :- float(X).

% unify(Term1, Term2) :-
%	項 Term1, Term2 は単一化可能である．
%       出現検査しないで許されるのは小学生までだよね!.
unify(X, Y) :-
	var(X), var(Y), X = Y.
unify(X, Y) :-
	var(X), nonvar(Y), not_occurs_in(X,Y), X = Y.
unify(X, Y) :-
	var(Y), nonvar(X), not_occurs_in(Y,X), Y = X.
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

not_occurs_in(X, Y) :-
	var(Y), X \== Y.
not_occurs_in(X, Y) :-
	nonvar(Y), constant(Y).
not_occurs_in(X, Y) :-
	nonvar(Y), compound(Y), functor(Y,F,N), not_occurs_in(N,X,Y).
not_occurs_in(N,X,Y) :-
	N > 0, arg(N,Y,Arg), not_occurs_in(X, Arg),
	N1 is N - 1, not_occurs_in(N1, X, Y).
not_occurs_in(0,X,Y).

% subterm(Sub, Term) :- Sub は基底項 Term の部分項である.
subterm(Term, Term).
subterm(Sub, Term) :-
	compound(Term), functor(Term, F, N), subterm(N, Sub, Term).
subterm(N, Sub, Term) :-
	N > 1, N1 is N - 1, subterm(N1, Sub, Term).
subterm(N,Sub,Term) :-
	arg(N, Term,  Arg), subterm(Sub, Arg).

% occurs_in(Sub, Term) :- Sub は項 Term の部分項である.
occurs_in(X, Term) :-
	subterm(Sub, Term), X == Sub.
