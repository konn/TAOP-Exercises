% polynomial(Expression, X) :- Expression は X の多項式である。
polynomial(X, X).
polynomial(Term, X) :- constant(Term).
polynomial(Term1 + Term2, X) :-
	polynomial(Term1, X), polynomial(Term2, X).
polynomial(Term1 - Term2, X) :-
	polynomial(Term1, X), polynomial(Term2, X).
polynomial(Term1 * Term2, X) :-
	polynomial(Term1, X), polynomial(Term2, X).
polynomial(Term1 / Term2, X) :-
	polynomial(Term1, X), constant(Term2).
polynomial(Term^N, X) :-
	polynomial(Term, X), integer(N).

constant(N) :- integer(N).

%% 記号微分
% derivative(Expression, X, DifferentiatedExpression) :-
%	 DifferentiatedExpression は式 Expression の X に関する導関数である。
derivative(X, X, 1).
derivative(X^N, X, N*X^N1) :- N > 0, N1 is N - 1.
derivative(sin(X), X, cos(X)).
derivative(cos(X), X, -sin(X)).
derivative(e^X, X, e^X).
derivative(log(X), X, 1/X).
derivative(F + G, X, DF + DG) :-
	derivative(F, X, DF), derivative(G, X, DG).
derivative(F - G, X, DF - DG) :-
	derivative(F, X, DF), derivative(G, X, DG).
derivative(F * G, X, F*DG + DF*G) :-
	derivative(F, X, DF), derivative(G, X, DG).
derivative(1/F, X, -DF/(F*F)) :-
	derivative(F, X, DF).
derivative(F/G, X, (DF*G - F*DG)/(G*G)) :-
	derivative(F, X, DF), derivative(G, X, DG).
derivative(-F, X, -DF) :- derivative(F, X, DF).

% univ を使うことにより，合成関数の微分が記述出来る!
derivative(F_G_X, X, DF*DG) :-
	F_G_X =.. [F, G_X],
	derivative(F_G_X, G_X, DF),
	derivative(G_X, X, DG).