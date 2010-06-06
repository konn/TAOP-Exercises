resistor(power, n1).
resistor(power, n2).

transistor(n2, ground, n1).
transistor(n3, n4, n2).
transistor(n5, ground, n4).

inverter(Input, Output) :-
	transistor(Input, ground, Output),
	resistor(power, Output).

nand_gate(Input1, Input2, Output) :-
	transistor(Input1, X, Output),
	transistor(Input2, ground, X),
	resistor(power, Output).

and_gate(Input1, Input2, Output) :-
	nand_gate(Input1, Input2, X), inverter(X, Output).
