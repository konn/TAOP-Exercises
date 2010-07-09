constant(X) :- integer(X).
constant(X) :- atom(X).

% occurences(Sub, Term, N) :- 基底項 Term 中には部分項 Sub が全部で N 個.
occurences(Term, Term, 1).
occurences(Sub, Term, N) :-
	compound(Term), Term =.. [F|Args] , occurences_list(Sub, Args, N).
occurences_list(Sub, [Arg|Args], N) :-
	occurences(Sub, Arg, N1),
	occurences_list(Sub, Args, N2),
	N is N1 + N2.
occurences_list(Sub, [Arg|Args], N) :-
	not( occurences(Sub, Arg, M)),
	occurences_list(Sub, Args, N).
occurences_list(Sub, [], 0).

% position(Sub, Term, Pos) :- Sub は 基底項 Term の Pos の位置に現れる. 
position(Term, Term, []).
position(Sub, Term, Pos) :-
	compound(Term), functor(Term, F, N), position(N, Sub, Term, Pos).
position(N, Sub, Term, Pos) :-
	N > 1,
	N1 is N - 1,
	position(N1, Sub, Term, Pos).
position(N, Sub, Term, [N|P2]) :-
	arg(N, Term, Arg),
	position(Sub, Arg, P2).

:- op(700, xfx, =...).
Term =... [F|Args] :-
	functor(Term, F, N), args(N, Term, [], Args).
args(N, Term, Acc, Args) :-
	N > 0, N1 is N-1, arg(N, Term, Arg), args(N1, Term, [Arg|Acc], Args).
args(0,Term,Acc,Acc).

% この様に定義すると，functor_(X, func, 3). などとして使えるが，
% functor_(f(a,b,c), F, N). は停止しない．
functor_(Term, F, N) :- length(Args, N), Term =.. [F|Args].

% この定義だとその逆．
functor__(Term, F, N) :- Term =.. [F|Args], length(Args, N).

% arg はおおむねちゃんと動くはず
arg_(N, Term, Arg) :-
	Term =.. [F | Args],
	sel(N, Args, Arg).
sel(N, [A2|Args], Arg) :-
	N > 1,
	N1 is N - 1,
	sel(N1, Args, Arg).
sel(1, [Arg|Args], Arg).



% substitute(Old, New, OldTerm, NewTerm) :-
%	NewTerm は 基底項 OldTerm 中の項 Old を New に置き換えたものである．
substitute(Old, New, Old, New).
substitute(Old, New, Term, Term) :-
	constant(Term), Term \= Old.
substitute(Old, New, Term, Term1) :-
	compound(Term),
	Term  =.. [F|Args1],
	substitute_list(Old, New, Args1, Args2),
	Term1 =.. [F|Args2].

substitute_list(Old, New, [Arg| Args1], [Arg2| Args2]) :-
	substitute(Old, New, Arg, Arg2),
	substitute_list(Old, New, Args1, Args2).
substitute_list(Old, New, [], []).