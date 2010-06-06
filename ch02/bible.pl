father(terach, abraham).
father(terach, nachor).
father(terach, haran).
father(abraham, isaac).
father(haran, lot).
father(haran, milcah).
father(haran, yiscah).

mother(sarah, isaac).

male(terach).
male(abraham).
male(nachor).
male(haran).
male(isaac).
male(lot).

female(sarah).
female(milcah).
female(yiscah).

likes(_, pomegrnates).

son(X,Y) :- parent(Y,X), male(X).
daughter(X,Y) :- parent(Y,X), female(X).
parent(X, Y) :- father(X,Y).
parent(Y, X) :- mother(X,Y).
grandparent(X, Y) :- parent(X, Z), parent(Z, Y).
grandfather(X, Y) :- grandparent(X, Y), male(X).
grandmother(X, Y) :- grandparent(X, Y), female(X).

procreated(Man, Woman) :- father(Man, Child), mother(Woman, Child).

uncle(Uncle, NieceOrNephew) :- brother(Uncle, Parent), parent(Parent, NieceOrNephew).
niece(Niece, UncleOrAunt) :-
	sibling(UncleOrAunt, Parent), parent(Parent, Niece),
	female(Niece).

sibling(Sib1, Sib2) :-
	father(Father, Sib1), father(Father, Sib2),
	mother(Mother, Sib1), mother(Mother, Sib2), Sib1 \= Sib2.

cousin(Cousin1, Cousin2) :-
	parent(Parent1, Cousin1), parent(Parent2, Cousin2),
	sibling(Parent1, Parent2).

brother(Brother, Sib) :- sibling(Brother, Sib), male(Brother).
sister(Sister, Sib) :- sibling(Sister, Sib), female(Sister).

mother(Woman) :- mother(Woman, Child).

married_couple(Wife, Husband) :- procreated(Husband, Wife).

mother_in_law(MotherInLaw, Husband) :-
	mother(MotherInLaw, Wife), married_couple(Wife, Husband).
mother_in_law(MotherInLaw, Wife) :-
	mother(MotherInLaw, Husband), married_couple(Wife, Husband).

brother_in_law(BrotherInLaw, Husband) :-
	brother(BrotherInLaw, Wife), married_couple(Wife, Husband).
brother_in_law(BrotherInLaw, Wife) :-
	brother(BrotherInLaw, Husband), married_couple(Wife, Husband).
brother_in_law(BrotherInLaw, Person) :-
	sister(Sister, Person), married_couple(Sister, BrotherInLaw).
son_in_law(SonInLaw, Parent) :-
	married_couple(Daughter, SonInLaw),
	parent(Parent, Daughter).

father(X, Y, pa(X, Y)) :-
	parent(X,Y), male(X).

grandparent(Ancestor, Descendant) :-
	parent(Ancestor, Person), parent(Person, Descendant).
greatgrandparent(Ancestor, Descendant) :-
	parent(Ancestor, Person), grandparent(Person, Descendant).
greatgreatgrandparent(Ancestor, Descendant) :-
	parent(Ancestor, Person), greatgrandparent(Person, Descendant).

ancestor(Ancestor, Descendant) :-
	parent(Ancestor, Descendant).
ancestor(Ancestor, Descendant) :-
	parent(Ancestor, Person), ancestor(Person, Descendant).