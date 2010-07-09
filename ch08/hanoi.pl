append([], Ys, Ys).
append([X|Xs], Ys, [X|Zs]) :- append(Xs, Ys, Zs).

hanoi(0, A, B, C, []).
hanoi(N, A, B, C, Moves) :- >(N,0), is(M, -(N,1)), hanoi(M, A, C, B, Ms1), hanoi(M, C, B, A, Ms2), append(Ms1, [to(A, B)|Ms2], Moves).
t(X) :- X.