% hanoi(N, A, B, C, Moves) :-
%	Moves は N枚の円盤と三本の杭 A, B, C を用いたハノイの塔の
%	問題を解く指手の系列である。
:- op(100, xfy, 'to').
hanoi(0, A, B, C, []).
hanoi(s(N), A, B, C, Moves) :-
	hanoi(N, A, C, B, Ms1),
	hanoi(N, C, B, A, Ms2),
	append(Ms1, [A to B|Ms2], Moves).