abolish(F, N) :- repeat, abolish_loop, !

abolish_loop(F, N) :-
	length(Args, N),
	Term =.. [F|Args],
	retract((Term :- X)),!, fail.
abolish_loop(F,N).