factorial(N,F) :- factorial(N,1,F).
factorial(I,N,T,F) :-
	I < N, I1 is I + 1, T1 is T * I1, factorial(I1, N, T1, F).
factorial(N,N,F,F).

factorial(N,T,F) :-
	N > 0, N1 is N - 1, T1 is T * N, factorial(N1, T1, F).
factorial(0,F,F).

% between(I,J,K) :- K は，整数 I, J の両端を含む区間内の整数である.
between(I, J, I) :- I =< J.
between(I, J, K) :-
	I < J, I1 is I +1, between(I1, J, K).

sumlist([I|Is], Sum) :- sumlist(Is, IsSum), Sum is I + IsSum.
sumlist([], 0).

suml(Is, Sum) :- suml(Is, 0, Sum).
suml([I|Is], Acc, Sum) :-
	Acc1 is Acc + I, suml(Is, Acc1, Sum).
suml([], Sum, Sum).

dot([X|Xs], [Y|Ys], Dot) :- dot(Xs, Ys, D1), Dot is D1 + X*Y.
dot([], [], 0).

inner_product(Xs, Ys, P) :- inner_product(Xs, Ys, 0, P).
inner_product([X|Xs], [Y|Ys], Acc, P) :-
	Acc1 is Acc + X*Y, inner_product(Xs, Ys, Acc1, P).
inner_product([], [], P, P).