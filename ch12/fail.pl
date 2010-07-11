tab(N) :- between(1, N, I), put(32), fail.
echo :- repeat_, read(X), echo(X), !.
echo(X) :- end_of_file(X), !.
echo(X) :- write(X), nl, fail.

repeat_.
repeat_ :- repeat_.

end_of_file(33).

consult_(File) :- see(File), consult_loop, seen.
consult_loop :- repeat, read(Clause), process(Clause), !.
process(X) :- end_of_file(X).
process(Clause) :- assert(Clause), fail.

end_of_file(eof).