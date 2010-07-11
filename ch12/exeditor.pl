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
	N > 0, move(N, Xs, Ys, Xs1, Ys1).
apply(down, file(Xs, [Y|Ys]), file([Y|Xs], Ys)).
apply(down(N), file(Xs, Ys), file(Xs1, Ys1)) :-
	N > 0, move(-N, Xs, Ys, Xs1, Ys1).

apply(seek(X), file(Xs, Ys), file(Xs2, Ys2)) :-
	reverse(Xs, Xs1), append(Xs1, Ys, Zs), seek(X, [], Zs, Xs2, Ys2).

apply(insert(Line), file(Xs, Ys), file(Xs, [Line|Ys])).
apply(delete, file(Xs, [Y|Ys]), file(Xs, Ys)).
apply(delete(N), file(Xs, Ys), file(Xs1, Ys1)) :-
	N > 0, delete(N, Xs, Ys, Xs1, Ys1).

apply(replace(Old, New), file(Xs, Ys), file(Xs1, Ys1)) :-
	replace(Old, New, Xs, Xs1), replace(Old, New, Ys, Ys1).

apply(print, file([X|Xs], Ys), file([X|Xs], Ys)) :-
	write(X), nl.
apply(print(*), file(Xs, Ys), file(Xs, Ys)) :-
	reverse(Xs, Xs1), write_file(Xs1), write_file(Ys).

apply(swap(N,N), File, File) :- !.
apply(swap(N, M), file(Xs, Ys), file(Xs1, Ys1)) :-
	N > 0, M > 0, N > M, !,
	N1 is N - 1, M1 is M - 1,
	swap(M1, N1, Xs, Ys, Xs1, Ys1).
apply(swap(N, M), file(Xs, Ys), file(Xs1, Ys1)) :-
	N > 0, M > 0, N =< M, !,
	N1 is N - 1, M1 is M - 1,
	swap(N1, M1, Xs, Ys, Xs1, Ys1).

split(N, As, Xs, Ys) :-
	append(Xs, Ys, As), length(Xs, N).

swap(N, M, Xs, Ys, Xs1, Ys1) :-
	length(Xs, Pos),
	reverse(Xs, Xsr), append(Xsr, Ys, Zs),
	swap(N, M, Zs, Zs1),
	split(Pos, Zs1, Xsr1, Ys1),
	reverse(Xsr1, Xs1).

swap(N, M, Xs, Xs1) :-
	M1 is M - N - 1,
	split(N, Xs, Fs1, [X|Rs1]),
	split(M1, Rs1, Fs2, [Y|Rs2]),
	append(Fs1, [Y|Fs2], Is),
	append(Is, [X|Rs2], Xs1).

move(0, Xs, Ys, Xs, Ys) :- !.
move(N, [], Ys, [], Ys) :- !.
move(N, [X|Xs], Ys, Xs1, Ys1) :-
	N > 0, !, N1 is N-1, move(N1, Xs, [X|Ys], Xs1, Ys1).
move(N, Xs, [Y|Ys], Xs1, Ys1) :-
	N < 0, !, N1 is N+1, move(N1, [Y|Xs], Ys, Xs1, Ys1).

delete(0, Xs, Ys, Xs, Ys) :- !.
delete(N, Xs, [], Xs, []) :- !.
delete(N, Xs, [Y|Ys], Xs1, Ys1) :-
	N > 0, !, N1 is N-1, delete(N1, Xs, Ys, Xs1, Ys1).

seek(X, Xs, [X|Ys], [X|Xs], Ys) :- !.
seek(X, Xs, [Y|Ys], Xs1, Ys1) :- seek(X, [Y|Xs], Ys, Xs1, Ys1).

replace(Old, New, [Old|Xs], [New|Zs]) :- !, replace(Old, New, Xs, Zs).
replace(Old, New, [X|Xs], [X|Zs]) :- replace(Old, New, Xs, Zs).
replace(Old, New, [], []) :- !.

write_file([X|Xs]) :-
	write(X), nl, write_file(Xs).
write_file([]).
write_prompt :- write('>>'), nl.