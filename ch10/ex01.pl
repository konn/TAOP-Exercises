range(M,N,Xs) :- nonvar(M), nonvar(N), range1(M,N,Xs).
range(M,N,Xs) :- nonvar(Xs), range2(M,N,Xs).

range1(M,N,[M|Ns]) :- M < N, M1 is M + 1, range1(M1, N, Ns).
range1(N,N,[N]).

range2(M,N,[M|Ns]) :- M1 is M + 1, range2(M1, N, Ns).
range2(N,N,[N]).

% between(I,J,K) :- K は，整数 I, J の両端を含む区間内の整数である.
between(I, J, I) :- I =< J.
between(I, J, K) :-
	I < J, I1 is I +1, between(I1, J, K).


% plus_(X, Y, Z) :- X に Y を加えるとなんと Z になるらしい.
plus_(X,Y,Z) :- nonvar(X), nonvar(Y), Z is X + Y.
plus_(X,Y,Z) :- nonvar(Y), nonvar(Z), X is Z - Y.
plus_(X,Y,Z) :- nonvar(Z), nonvar(X), Y is Z - X.
plus_(X,Y,Z) :-
	var(X), var(Y), nonvar(Z),
	between(0, Z, X),
	Y is Z - X.