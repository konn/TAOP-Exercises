course(complexity, monday, 9, 11 , david, harel, feinberg, a).
course(complexity, time(monday, 9, 11), lecturer(david, harel),
       location(feinberg, a)).

lecturer(Lecturer, Course) :- course(Course, Time, Lecturer, Location).
duration(Course, Length) :-
	course(Course, time(Day, Start, Finish), Lecturer, Location),
	plus(Start, Duration, Finish).
teaches(Lecturer, Day) :-
	course(Course, time(Day, Start, Finish), Lecturer, Location).
occupied(Room, Day, Time) :-
	course(Course, time(Day, Start, Finish), Lecturer,
	       location(Building, Room)),
	Start =< Time, Time =< Room.

location(Course, Building) :-
	course(Course, Time, Lecturer, location(Building, Room)).
busy(Lecturer, time(Day, Time)) :-
	course(Course, time(Day, Start, Finish), Lecturer, Location),
	Start =< Time, Time =<  Finish.
cannot_meet(Lecturer1, Lecturer2) :-
	course(C1, Time, Lecturer1, Location1),
	course(C2, Time, Lecturer2, Location2),
	C1 \= C2, Lecturer1 \= Lecturer2, Location1 \= Location2.

schedule_conflict(Time, Place, Course1, Course2) :-
	course(Course1, Time, Lecturer1, Place),
	course(Course2, Time, Lecturer2, Place),
	Course1 \= Course2.