% writeIn(Xs) :- 項のリスト Xs は副作用により出力ストリームに書き出される.
writeIn([X|Xs]) :- write(X), writeIn(Xs).
writeIn([]) :- nl.

% read_word_list(Ws) :-
%	Ws は入力ストリームから副作用により読み込まれた語のリストである.
% 通常， get(X) は空白を無視するので期待通りには決して動かない．
read_word_list(Ws) :- get(C), read_word_list(C, Ws).
read_word_list(C, [W|Ws]) :-
	word_char(C),
	read_word(C,W,C1),
	read_word_list(C1, Ws).
read_word_list(C, Ws) :-
	fill_char(C),
	get(C1),
	read_word_list(C1, Ws).
read_word_list(C, []) :-
	end_of_words_char(C).

read_word(C, W, C1) :-
	word_chars(C, Cs, C1),
	name(W, Cs).

word_chars(C, [C|Cs], C0) :-
	word_char(C), !,
	get(C1),
	word_chars(C1, Cs, C0).
word_chars(C, [], C) :-
	not(word_char(C)).

word_char(C) :- 97 =< C, C =< 122.
word_char(C) :- 65 =< C, C =< 90.
word_char(C) :- 48 =< C, C =< 57.
word_char(39).
word_char(95).
fill_char(32).
fill_char(44).
end_of_words_char(46).
end_of_words_char(63).
end_of_words_char(33).