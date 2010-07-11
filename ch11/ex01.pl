quicksort([X|Xs], Ys) :-
	partitions(Xs,X,Littles, Bigs),
	quicksort(Littles, Ls),
	quicksort(Bigs, Bs),
	append(Ls, [X|Bs], Ys).
quicksort([], []).

partitions([X|Xs], Y, [X|Ls], Bs) :- X =< Y, !, partitions(Xs, Y, Ls, Bs).
partitions([X|Xs], Y, Ls, [X|Bs]) :- X > Y, !, partitions(Xs, Y, Ls, Bs).
partitions([],Y,[],[]) :- !.

constant_to(Y, X) :- integer(Y), !.
constant_to(Y, X) :- atom(Y), !, Y \= X.
constant_to(Term, X) :-
	compound(Term), !,
	functor(Term, F, N),
	constant_term(N, Term, X).
constant_term(N, Term, X) :-
	N > 0, !,
	arg(N, Term, Arg),
	constant_to(Arg, X),
	N1 is N - 1,
	constant_term(N1, Term, X).
constant_term(0, Term, X) :- !.

%% 記号微分
% derivative(Expression, X, DifferentiatedExpression) :-
%	 DifferentiatedExpression は式 Expression の X に関する導関数である。
derivative(X, X, 1) :- !.
derivative(X^N, X, N*X^N1) :- !, N > 0, N1 is N - 1.
derivative(sin(X), X, cos(X)) :- !.
derivative(cos(X), X, -sin(X)) :- !.
derivative(e^X, X, e^X) :- !.
derivative(log(X), X, 1/X) :- !.
derivative(F + G, X, DF + DG) :-
	!,
	derivative(F, X, DF), derivative(G, X, DG).
derivative(F - G, X, DF - DG) :-
	!,
	derivative(F, X, DF), derivative(G, X, DG).
derivative(F * G, X, F*DG + DF*G) :-
	!,
	derivative(F, X, DF), derivative(G, X, DG).
derivative(1/F, X, -DF/(F*F)) :-
	!,
	derivative(F, X, DF).
derivative(F/C, X, DF/C) :-
	constant_to(C, X), !,
	derivative(F, X, DF).

derivative(F/G, X, (DF*G - F*DG)/(G*G)) :-
	!,
	derivative(F, X, DF), derivative(G, X, DG).
derivative(-F, X, -DF) :- !, derivative(F, X, DF).
derivative(F_G_X, X, DF*DG) :-
	!,
	F_G_X =.. [F, G_X],
	derivative(F_G_X, G_X, DF),
	derivative(G_X, X, DG).
derivative(C, X, 0) :- constant_to(C, X), !.

sort_([X|Xs], Ys) :- !, sort_(Xs, Zs), insert(X, Zs, Ys).
sort_([], []) :- !.

insert(X, [], [X]) :- !.
insert(X, [Y|Ys], [Y|Zs]) :- X > Y, !, insert(X, Ys, Zs).
insert(X, [Y|Ys], [X,Y|Ys]) :- X =< Y, !.