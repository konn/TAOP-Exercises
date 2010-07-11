delete([X|Ys], X, Zs) :- !, delete(Ys, X, Zs).
delete([Y|Ys], X, [Y|Zs]) :- !, delete(Ys, X, Zs).
delete([], X, []).

if_then_else(P, Q, R) :- P, !, Q.
if_then_else(P, Q, R) :- R.

member_check(X, [X|Xs]) :- !.
member_check(X, [Y|Xs]) :- member_check(X, Xs).

