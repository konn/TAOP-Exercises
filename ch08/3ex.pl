triangle(N, T) :- triangle(N, 0, T).
triangle(N, Acc, T) :-
	N > 0, N1 is N - 1, Acc1 is Acc + N, triangle(N1, Acc1, T).
triangle(0, T, T).

power(X, N, V) :- power(X, N, 1, V).
power(X, N, Acc, V) :-
	N > 0, N1 is N - 1, Acc1 is Acc * X, power(X, N1, Acc1, V).
power(X, 0, V, V).

timeslist(Is, Prod) :- timeslist(Is, 1, Prod).
timeslist([I|Is], Acc, Prod) :-
	Acc1 is Acc * I, timeslist(Is, Acc1, Prod).
timeslist([], Prod, Prod).

area(XYs, Area) :- area(XYs, 0, Area).
area([Tuple], Area, Area).
area([(X1, Y1), (X2,Y2) | XYs], Acc, Area) :-
	Acc1 is Acc + (X1 * Y2 - Y1*X2)/2, area([(X2, Y2)|XYs], Acc1, Area).

minimum([X|Xs], M) :- minimum(Xs, X, M).
minimum([Y|Xs], X, M) :-
	Y < X, minimum(Xs, Y, M).
minimum([Y|Xs], X, M) :-
	Y >= X, minimum(Xs, X, M).
minimum([], M, M).

mlength(Xs,N) :- mlength(Xs, 0, N).
mlength([X|Xs], Acc, L) :-
	Acc1 is Acc + 1, mlength(Xs, Acc1, L).
mlength([], L, L).

range(M,N,Ns) :- range(M, N, [], Ns).
range(M, N, Acc, Ns) :-
	M<N, N1 is N - 1, range(M, N1, [N|Acc], Ns).
range(N, N, Ms, [N|Ms]).