writeIn([X|Xs]) :- write(X), writeIn(Xs).
writeIn([]) :- nl.

log :- shell_(log('prolog.log')).
log(Log) :- shell_(log(Log)).
shell_(Flag) :-
	shell_prompt, shell_read(Goal,Flag), shell_(Goal,Flag).
shell_(exit, Flag) :-
	!, close_logging_file(Flag).
shell_(nolog, Flag) :-
	!, shell_(nolog).
shell_(log, Flag) :-
	!, shell_(log('prolog.log')).
shell_(log(Log), Flag) :-
	!, shell_(log(Log)).
shell_(Goal, Flag) :-
	ground(Goal), !, shell_solve_ground(Goal, Flag), shell_(Flag).
shell_(Goal, Flag) :-
	shell_solve(Goal, Flag), shell_(Flag).

shell_solve(Goal,Flag) :-
	Goal, shell_write(Goal,Flag), nl, fail.
shell_solve(Goal,Flag) :-
	shell_write('No (more) solutions', Flag), nl.

shell_solve_ground(Goal,Flag) :-
	Goal, !, shell_write('Yes', Flag), nl.
shell_solve_ground(Goal,Flag) :-
	shell_write('Noooooo!', Flag), nl.

shell_prompt :- write('next command?  ').

shell_read(X, log(Log)) :-
	read(X),
	file_write(['Next command?  ', X], Log).
shell_read(X, nolog) :- read(X).

shell_write(X, nolog) :- write(X).
shell_write(X, log(Log)) :- write(X), file_write([X], Log).

file_write(X, File) :- telling(Old), tell(File), writeIn(X), tell(Old).
close_logging_file(log(Log)) :- tell(Log), told.