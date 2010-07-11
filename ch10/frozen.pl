%TAOP の freeze は普通の処理系に実装されていないので注意．
% このコードは動かない．
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
	copy_term(X, Xf), copy_term(Term, Termf), subterm(Xf, Termf).