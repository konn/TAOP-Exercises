constant(X) :- atom(X).
constant(X) :- integer(X).

% subterm(Sub, Term) :- Sub は基底項 Term の部分項である.
subterm(Term, Term).
subterm(Sub, Term) :-
	compound(Term), functor(Term, F, N), subterm(N, Sub, Term).
subterm(N, Sub, Term) :-
	N > 1, N1 is N - 1, subterm(N1, Sub, Term).
subterm(N,Sub,Term) :-
	arg(N, Term,  Arg), subterm(Sub, Arg).

% substitute(Old, New, OldTerm, NewTerm) :-
%	NewTerm は， OldTerm 中の Old を New で置き換えたものである.
substitute(Old, New, Old, New).
substitute(Old, New, Term, Term) :-
	constant(Term), Term \= Old.
substitute(Old, New, Term, Term1) :-
	compound(Term),
	functor(Term, F, N),
	functor(Term1, F, N),
	substitute(N, Old, New, Term, Term1).

substitute(N, Old, New, Term, Term1) :-
	N > 0,
	arg(N, Term, Arg),
	substitute(Old, New, Arg, Arg1),
	arg(N, Term1, Arg1),
	N1 is N - 1,
	substitute(N1, Old, New, Term, Term1).
substitute(0, Old, New, Term, Term1).

% subtermu(Sub, Term) :- subterm の univ 版.
subtermu(Term, Term).
subtermu(Sub, Term) :-
	compound(Term), Term =.. [F|Args], subtermu_list(Sub, Args).
subtermu_list(Sub, [Arg|Args]) :-
	subtermu(Sub, Arg).
subtermu_list(Sub, [Arg|Args]) :-
	subtermu_list(Sub, Args).