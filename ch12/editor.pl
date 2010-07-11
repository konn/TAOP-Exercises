writeIn([X|Xs]) :- write(X), writeIn(Xs).
writeIn([]) :- nl.

% echo :- 対話型ループ.
echo :- read(X), echo(X).
echo(X) :- end_of_file(X), !.
echo(X) :- write(X), nl, read(Y), !, echo(Y).

edit :- edit(file([],[])).
edit(File) :-
	write_prompt, read(Command), edit(File, Command).
edit(File, exit) :- !.
edit(File, Command) :-
	apply(Command, File, File1), !, edit(File1).
edit(File, Command) :-
	writeIn([Command, 'is not applicable']), !, edit(File).

apply(up, file([X|Xs], Ys), file(Xs, [X|Ys])).
apply(up(N), file(Xs, Ys), file(Xs1, Ys1)) :-
	N > 0, up(N, Xs, Ys, Xs1, Ys1).
apply(down, file(Xs, [Y|Ys]), file([Y|Xs], Ys)).
apply(insert(Line), file(Xs, Ys), file(Xs, [Line|Ys])).
apply(delete, file(Xs, [Y|Ys]), file(Xs, Ys)).
apply(print, file([X|Xs], Ys), file([X|Xs], Ys)) :-
	write(X), nl.
apply(print(*), file(Xs, Ys), file(Xs, Ys)) :-
	reverse(Xs, Xs1), write_file(Xs1), write_file(Ys).

up(N, [], Ys, [], Ys).
up(0, Xs, Ys, Xs, Ys).
up(N, [X|Xs], Ys, Xs1, Ys1) :-
	N > 0, N1 is N-1, up(N1, Xs, [X|Ys], Xs1, Ys1).

write_file([X|Xs]) :-
	write(X), nl, write_file(Xs).
write_file([]).
write_prompt :- write('>>'), nl.