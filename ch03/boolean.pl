:- op(200, fx, '~').
:- op(500, xfy, 'or').
:- op(400, xfy, 'and').

% satisfiable(Formula) :- ブール式 Formula を真にする様な代入例が存在する。
satisfiable(true).
satisfiable(X and Y) :- satisfiable(X), satisfiable(Y).
satisfiable(X or Y) :- satisfiable(X).
satisfiable(X or Y) :- satisfiable(Y).
satisfiable(~X) :- invalid(X).

% invalid(Formula) :- ブール式 Formula を偽にする様な代入例が存在する。
invalid(false).
invalid(X or Y) :- invalid(X), invalid(Y).
invalid(X and Y) :- invalid(X).
invalid(X and Y) :- invalid(Y).
invalid(~X) :- satisfiable(X).

% boolean_formula(Formula) :- Formula はブール式である。
boolean_formula(true).
boolean_formula(false).
boolean_formula(~X) :- boolean_formula(X).
boolean_formula(X and Y) :- boolean_formula(X), boolean_formula(Y).
boolean_formula(X or Y) :- boolean_formula(X), boolean_formula(Y).

% regular_product_form(Formula) :- 論理式 Formula は積標準形である。
regular_product_form(X) :- sum_form(X).
regular_product_form(X and Y) :- regular_product_form(X), sum_form(Y).

literal(true).
literal(false).
literal(~X) :- literal(X).

sum_form(X or Y) :- sum_form(X), literal(Y).
sum_form(Lit) :- literal(Lit).

% negation_inwards(F1, F2) :- 論理式 F2 は F1 をリテラル以外に否定を持たない形にしたもの。
negation_inwards(X, X) :- literal(X).
negation_inwards(~(X and Y), X1 or Y1) :-
	negation_inwards(~X, X1), negation_inwards(~Y, Y1).
negation_inwards(~(X or Y), X1 and Y1) :-
	negation_inwards(~X, X1), negation_inwards(~Y, Y1).
