% merge(Xs, Ys, Zs) :-
%	Zs は，整数の順序リストXs, Ys を併合して得られる整数の順序リストさ.
merge([X|Xs], [Y|Ys], [X|Zs]) :- X < Y, !, merge(Xs, [Y|Ys], Zs).
merge([X|Xs], [Y|Ys], [X,Y|Zs]) :- X = Y, !,merge(Xs, Ys, Zs).
merge([X|Xs], [Y|Ys], [Y|Zs]) :- X > Y, !,merge([X|Xs], Ys, Zs).
merge(Xs, [], Xs) :- !.
merge([], Ys, Ys) :- !.

% minimum(X, Y, Min) :- Min は，数 X, Y の最小値である.
minimum(X, Y, X) :- X =< Y, !.
minimum(X, Y, Y) :- Y < X, !.

constant(X) :- integer(X).

% polynomial(Term, X) :- Term は X の多項式でありんす.
polynomial(X,X) :- !.
polynomial(Term, X) :- constant(Term), !.
polynomial(Term1 + Term2, X) :-
	!, polynomial(Term1, X), polynomial(Term2, X).
polynomial(Term1 - Term2, X) :-
	!, polynomial(Term1, X), polynomial(Term2, X).
polynomial(Term1 * Term2, X) :-
	!, polynomial(Term1, X), polynomial(Term2, X).
polynomial(Term1 / Term2, X) :-
	!, polynomial(Term1, X), constant(Term2).
polynomial(Term^N, X) :-
	!, integer(N), polynomial(Term, X).

% sort(Xs, Ys) :- Ys は整数リストXsの順序付けされた順列である.
sort_(Xs, Ys) :-
	append(As, [X,Y|Bs], Xs),
	X > Y,
	!,
	append(As, [Y,X|Bs], Xs1),
	sort_(Xs1, Ys).
sort_(Xs, Xs) :- ordered(Xs), !.

ordered([X]).
ordered([X,Y|Ys]) :- X =< Y, ordered([Y|Ys]).
