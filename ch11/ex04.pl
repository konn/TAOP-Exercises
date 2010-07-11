constant(X) :- integer(X).
constant(X) :- atom(X).

% substitute(Old, New, OldTerm, NewTerm) :-
%	NewTerm は， OldTerm 中の Old を New で置き換えたものである.
substitute(Old, New, Old, New) :- !.
substitute(Old, New, Term, Term) :-
	constant(Term), !, Term \= Old.

substitute(Old, New, Term, Term1) :-
	compound(Term),!,
	functor(Term, F, N),
	functor(Term1, F, N),
	substitute(N, Old, New, Term, Term1).

substitute(0, Old, New, Term, Term1) :- !.
substitute(N, Old, New, Term, Term1) :-
	!,
	arg(N, Term, Arg),
	substitute(Old, New, Arg, Arg1),
	arg(N, Term1, Arg1),
	N1 is N - 1,
	substitute(N1, Old, New, Term, Term1).
