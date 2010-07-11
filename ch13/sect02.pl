% verify(Goal) :-
%	ゴール Goal は，真なる代入例を持つ．この検証は構成的ではないため，変数への代入は行われない.
verify(Goal) :- not( not(Goal) ).

numbervars_('$VAR'(N), N, N1) :- N1 is N + 1.
numbervars_(Term, N1, N2) :-
	nonvar(Term), functor(Term, Name, N),
	numbervars_(0,N,Term,N1,N2).

numbervars_(N,N,Term,N1,N1).
numbervars_(I,N,Term,N1,N3) :-
	I < N,
	I1 is I + 1,
	arg(I1, Term, Arg),
	numbervars_(Arg, N1, N2),
	numbervars_(I1, N, Term, N2, N3).

ground_(Term) :- numbervars(Term, 0, 0).

freeze(X, Term) :- copy_term(X, Term), numbervars(Term, 0, N).

occurs_in(X, Term) :-
	freeze(X, Xf), freeze(Term, Termf), subterm(Xf, Termf).

% subterm(Sub, Term) :- Sub は基底項 Term の部分項である.
subterm(Term, Term).
subterm(Sub, Term) :-
	compound(Term), functor(Term, F, N), subterm(N, Sub, Term).
subterm(N, Sub, Term) :-
	N > 1, N1 is N - 1, subterm(N1, Sub, Term).
subterm(N,Sub,Term) :-
	arg(N, Term,  Arg), subterm(Sub, Arg).

% variants(Term1, Term2) :- 項 Term1, Term2 は互いに別形項である.
variants(Term1, Term2) :-
	verify((numbervars(Term1, 0, N),
		numbervars(Term2, 0, N),
		Term1 = Term2)).

% write_vnames(Term) :- あらかじめ定義された変数名を用いて，項 Term を書き出す.
write_vnames(Term) :- lettervars(Term), write(Term), fail.
write_vnames(Term).

lettervars(Term) :-
	list_of_variables(Term, Vars),
	variable_names(Names),
	unify_variables(Vars, Names).

constant(X) :- atom(X).
constant(X) :- integer(X).
constant(X) :- float(X).

list_of_variables(V, [V]) :- var(V), !.
list_of_variables(V, []) :- constant(V), !.
list_of_variables(Term, Vs) :-
	functor(Term, F, N),
	list_of_variables(N, Term, Vs1),
	flatten(Vs1, Vs).
list_of_variables(N, Term, [VArgs | Vs] ) :-
	N > 0,
	arg(N, Term, Arg),
	list_of_variables(Arg, VArgs),
	N1 is N - 1,
	list_of_variables(N1, Term, Vs).
list_of_variables(0, Term, []).

unify_variables([V|Vs],[V|Ns]) :- !, unify_variables(Vs, Ns).
unify_variables([V|Vs], Ns) :- !, unify_variables(Vs, Ns).
unify_variables(Vs, Ns).

variable_names(['X', 'Y', 'Z', 'U', 'V', 'W', 'X1', 'Y1', 'Z1', 'U1', 'V1', 'W1',
		'X2', 'Y2', 'Z2', 'U2', 'V2', 'W2', 'X3', 'Y3', 'Z3', 'U3', 'V3', 'W3']).

:- dynamic flag/2.
% set_flag(Name, Value) :- フラッグ Name の値を Value にする.
set_flag(Name, X) :-
	nonvar(Name),
	retract(flag(Name, Val)), !,
	asserta(flag(Name, X)).
set_flag(Name, X) :-
	nonvar(Name), asserta(flag(Name, X)).

% gensym(Prefix, Constant) :- Const は Prefix を接頭部にもつ新しい定数名である.
gensym(Prefix, Constant) :-
	var(V),
	atom(Prefix),
	old_value(Prefix, N),
	N1 is N + 1,
	set_flag(gensym(Prefix), N1),
	string_concatenate(Prefix, N1, Constant),
	!.

old_value(Prefix, N) :- flag(gensym(Prefix), N), !.
old_value(Prefix, 0).

string_concatenate(X,Y,XY) :-
	name(X, Xs), name(Y, Ys), append(Xs, Ys, XYs), name(XY, XYs).