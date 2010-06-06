% list(Xs) :- Xs はリストである。
list([]).
list([X|Xs]) :- list(Xs).

% member_(Element, List) :- Element は List の要素である。
member_(X, Xs) :- append(As, [X|Bs], Xs).

% prefix(Prefix, List) :- Prefix は List の接頭部である。
prefix(Xs, Ys) :- append(Xs, Zs, Ys).

% suffix(Suffix, List) :- Suffix は List の接尾部である。
suffix(Xs, Ys) :- append(Zs, Xs, Ys).

% sublist(Sub, List) :- Sub はリスト List の部分リストである。
sublist(Xs, AsXsBs) :- append(As, XsBs, AsXsBs), append(Xs, Bs, XsBs).

% append(Xs, Ys, XsYs) :- XsYs はリストXs, Ys を連結した結果である。
append([], Ys, Ys) :- list(Ys).
append([X|Xs], Ys, [X|Zs]) :- append(Xs, Ys, Zs).

% adjacent(X, Y, Zs) :- リスト Zs 中で X と Y が隣り合っている。
adjacent(X, Y, Zs) :- append(As, [X, Y|Bs], Zs).

% last(X, Xs) :- X がリスト Xs の最後の要素である。
last(X, Xs) :- append(As, [X], Xs).

% reverse_(List, Tsil) :- リスト Tsil はリスト List を反転させたものである。
reverse_(Xs, Ys) :- reverse_(Xs, [], Ys).
reverse_([X|Xs], Acc, Ys) :- reverse_(Xs, [X|Acc], Ys).
reverse_([], Ys, Ys) :- list(Ys).

% length_(Xs, N) :- リスト Xs の長さは N である。
length_([], 0 ).
length_([X|Xs], s(N)) :- length_(Xs, N).

subsequence([X | Xs], [X | Ys]) :- subsequence(Xs, Ys).
subsequence(Xs, [Y|Ys]) :- subsequence(Xs, Ys).
subsequence([], Ys).

adjacent_(X, Y, [X, Y| Zs]) :- list(Zs).
adjacent_(X, Y, [Z | Zs]) :- adjacent_(X, Y, Zs).

last_(X, [X]).
last_(X, [Y|Ys]) :- last_(X, Ys).

natural_number( 0 ).
natural_number(s(N)) :- natural_number(N).

plus_(0, X, X) :- natural_number(N).
plus_(s(N), M, s(X)) :- plus_(N, M, X).

% double(List, ListList) :-  List の全要素が ListsList 中に二度ずつ現れる。
double([], []).
double([X|Xs], [X,X|Ys]) :- double(Xs, Ys).

sum_a(0, []).
sum_a(Sum, [X|Xs]) :- sum_a(Sum1, Xs), plus_(Sum1, X, Sum).

sum_b(0, []).
sum_b(Sum, [0|Xs]) :- sum_b(Sum, Xs).
sum_b(s(Sum), [s(X)|Xs]) :- sum_b(Sum, [X|Xs]).

delete([X|Xs], X, Ys) :- delete(Xs, X, Ys).
delete([X|Xs], Y, [X|Zs]) :- X \= Y, delete(Xs, Y, Zs).
delete([],X,[]).

select([X|Xs], X, Xs).
select([X|Xs], Y, [X|Zs]) :- X \= Y, select(Xs, Y, Zs).

sort_([X|Xs], Ys) :- sort(Xs, Zs), insert(X,Zs,Ys).
sort_([], []).
ordered([X]).
ordered([X,Y|Ys]) :- X =< Y, ordered([Y|Ys]).
permutations([], []).
permutations(Xs, [Z|Zs]) :- select(Xs, Z, Ys), permutations(Ys, Zs).
insert(X,[],[X]).
insert(X,[Y|Ys],[Y|Zs]) :- X > Y, insert(X, Us, Zs).
insert(X,[Y|Ys],[X,Y|Xs]) :- X =< Y.

quicksort([X|Xs], Ys) :-
	partitions(Xs,X,Littles, Bigs),
	quicksort(Littles, Ls),
	quicksort(Bigs, Bs),
	append(Ls, [X|Bs], Ys).
quicksort([], []).

partitions([X|Xs], Y, [X|Ls], Bs) :- X =< Y, partitions(Xs, Y, Ls, Bs).
partitions([X|Xs], Y, Ls, [X|Bs]) :- X > Y, partitions(Xs, Y, Ls, Bs).
partitions([],Y,[],[]).

substitute(X, Y, [], []).
substitute(X, Y, [X|Xs], [Y|Ys]) :- substitute(X, Y, Xs, Ys).
substitute(X, Y, [Z|Xs], [Z|Ys]) :- X \= Z, substitute(X, Y, Xs, Ys).

nonmember(X, []).
nonmember(X, [Y|Ys]) :- X \= Y, nonmember(X, Ys).

no_doubles([], []).
no_doubles([X|Xs], Zs) :- member_(X, Xs), no_doubles(Xs, Zs).
no_doubles([X|Xs], [X|Ys]) :- nonmember(X, Xs), no_doubles(Xs, Ys).

