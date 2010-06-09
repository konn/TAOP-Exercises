% natural_number(X) :- X は 自然数である。
natural_number( 0 ).
natural_number(s(N)) :- natural_number(N).

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
	polynomial(Term, X), natural_number(N).

constant(N) :- natural_number(N).
n( 0, 0 ).
n(M, s(N)) :- plus(N1, 1, M), n(N1, N).

%% 記号微分
% derivative(Expression, X, DifferentiatedExpression) :-
%	 DifferentiatedExpression は式 Expression の X に関する導関数である。
derivative(X, X, s( 0 )).
derivative(X^s(N), X, s(N)*X^N).
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

%% この様な形式だと、合成関数の導関数を記述できない。
%% unary_term 形式だと可能
% derive(Expression, X, DifferentiatedExpression) :-
%	 DifferentiatedExpression は式 Expression の X に関する導関数である。
derive(X, X, s( 0 )).
derive(unary_term(exp, X), X, unary_term(exp, X)).
derive(X^s(N), X, s(N)*X^N).
derive(unary_term(sin, X), X, unary_term(cos, X)).
derive(unary_term(cos, X), X, -unary_term(sin, X)).
derive(unary_term(log, X), X, 1/X).
derive(-F, X, DF) :- derive(F, X, -DF).
derive(-F, X, -DF) :- derive(F, X, DF).
derive(F + G, X, DF + DG) :- derive(F, X, DF), derive(G, X, DG).
derive(F - G, X, DF - DG) :- derive(F, X, DF), derive(G, X, DG).
derive(F * G, X, DF*G + F*DG) :- derive(F, X, DF), derive(G, X, DG).
derive(1/F, X, -DF/(F*F)) :- derive(F, X, DF).
derive(F/G, X, (DF*G - F*DG)/(G*G)) :- derive(F, X, DF), derive(G, X, DG).
derive(unary_term(F, U), X, DF * DU) :-
	derive(unary_term(F, U), U, DF), derive(U, X, DU).

% regular_form(Formula) :- Formula は正規化された算術和形式である。
regular_form(X) :- constant(X).
regular_form(A + B) :- constant(A), regular_form(B).