:- op(700, xfx, to).
:- dynamic hanoi/5.
hanoi(1, A, B, C, [A to B]).
hanoi(N, A, B, C, Moves) :-
	N > 1,
	M is N -1,
	lemma(hanoi(M, A, C, B, Ms1)),
	hanoi(M, C, B, A, Ms2),
	append(Ms1, [A to B|Ms2], Moves).
lemma(P) :- P, asserta((P :- !)).

test_hanoi(N, Pegs, Moves) :-
	hanoi(N, A, B, C, Moves), Pegs = [A,B,C].