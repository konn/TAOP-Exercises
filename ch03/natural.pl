% natural_number(X) :- X は自然数である.
natural_number(0).
natural_number(s(X)) :- natural_number(X).

% X <= Y :- X, Y は自然数であり、X は Y より小さいか等しい。
:-op(600, xfy, '<=').
0 <= X :- natural_number(X).
s(X) <= s(Y) :- X <=  Y.

% plus(X, Y, Z) :- X, Y, Z は自然数であり、 Z は X と Y の和である
plus_(0,X,X) :- natural_number(X).
plus_(s(X), Y, s(Z)) :- plus_(X, Y, Z).

% times(X, Y, Z) :-
% 	X, Y, Z が 自然数のとき、ZはXとYの積である。
times(0,X,0).
times(s(X), Y, Z) :- times(X,Y,W), plus_(W,Y,Z).

% exp(N, X, Y) :-
%	N, X, Y が自然数のとき、Yは XのN乗である。
exp(s(X), 0, 0 ).
exp(0, s(X), s(0 )).
exp(s(N), X, Y) :- exp(N,X,Z), times(Z, X, Y).

% factorial(N, X) :- X は N の階乗である。
factorial(0,s(0 )).
factorial(s(N), Y) :- factorial(N, F2), times(s(N), F2, Y).

% minimum(N1, N2, Min) :- 自然数 N1, N2 の最小値は Min である。
minimum(X, Y, X) :- X <= Y.
minimum(X, Y, Y) :- Y <= X.

:-op(600, xfy, '/=').
0 /= s(X) :- natural_number(X).
s(X) /= s(Y) :- X /= Y.

:-op(600, xfy, '<<').
X << Y :- X <= Y, X /= Y.

:-op(600, xfy, '=>').
X => Y :- Y <= X.

:-op(600, xfy, '>>').
X >> Y :- Y >> X.

% mod_(X, Y, Z) :- Z は X を Y で割った剰余である。
mod(X, Y, X) :- X << Y.
mod(X, Y, Z) :- plus_(X1, Y, X), mod(X1, Y, Z).

ackermann(0, N, s(N)) :- natural_number(N).
ackermann(s(M), 0,Val) :- ackermann(M, s(0), Val).
ackermann(s(M), N, Val) :-
	ackermann(s(M), N, Val1), ackermann(M, Val1, Val).

gcd(X, 0, X) :- X>> 0.
gcd(0, X, X) :- X >> 0.
gcd(X,X,X) :- X>> 0.
gcd(X, Y, G) :- X >> Y, plus_(W1, Y, X), gcd(W1, Y, G).
gcd(X, Y, G) :- X << Y, gcd(Y, X, G).

even(0 ).
even(s(s(N))) :- even(N).

odd(s(0 )).
odd(s(s(N))) :- odd(N).

fib(0, 0).
fib(s(0 ), s(0 )).
fib(s(s(N)), X) :- fib(N, Y) , fib(s(N), Z), plus_(Y, Z, X).

% div(X, Y, Z) :- X, Y, Z が自然数のとき、ZはXとYの商である。
div(X, Y, 0) :- X << Y.
div(N, Y, s(Z)) :- plus_(W, Y, N), div(W, Y, Z).