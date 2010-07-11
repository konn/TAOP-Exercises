:- op(700, xfx, \===).
X \=== Y :- X == Y, !, fail.
X \=== Y.

nonvar_(X) :- var(X), !, fail.
nonvar_(X).