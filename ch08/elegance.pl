% area(Chain, Area) :-
% Area は，頂点のリスト Chain で囲まれた多角形の面積でる．
% 但し，各頂点の座標は整数の対 (X, Y) で表わされる.
area([Tuple], 0).
area([(X1, Y1), (X2,Y2) | XYs], Area) :-
	area([(X2, Y2)|XYs], Area1),
	Area is (X1 * Y2 - Y1*X2)/2 + Area1.

maximum([X|Xs], M) :- maximum(Xs,X,M).
maximum([X|Xs], Y, M) :- X =< Y, maximum(Xs, Y, M).
maximum([X|Xs], Y, M) :- X >  Y, maximum(Xs, X, M).
maximum([], M, M).

mlength([X|Xs], N) :- N > 0, N1 is N-1, mlength(Xs, N1).
mlength([], 0).

mlen([X|Xs], N) :- length(Xs, N1), N is N1 + 1.
mlen([], 0).

range(M,N,[M|Ns]) :- M1 is M+1, range(M1, N, Ns).
range(N,N,[N]).