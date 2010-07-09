% gcd(X,Y,Z) :- Z は，整数X, Y の最大公約数である.
gcd(I, 0, I).
gcd(I,J, Gcd):-
	J > 0, R is I mod J, gcd(J, R, Gcd).

% factorial(N, F) :- F は N の階乗である.
factorial(N, F) :-
	N > 0, N1 is N - 1, factorial(N1, F1), F is N * F1.
factorial(0, 1).

% triangle(N, T) :- T は N 番目の三角数である.
triangle(0,0).
triangle(N, T) :-
	N > 0, N1 is N - 1, triangle(N1, T1), T is T1 + N.

% power(X, N, V) :- N, X, Y が自然数のとき，V は X の N 乗である．
power(X, 0, 1).
power(X, N, P) :-
	N>0, N1 is N - 1, power(X, N1, P1), P is P1 * X.