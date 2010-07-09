joint(Xs, Ys) :- member(X, Xs), member(X, Ys).
disjoint(Xs, Ys) :- not(joint(Xs,Ys)).
member(X, [X|Xs]).
member(X, [Y|Xs]) :- \=(X,Y), member(X,Xs).