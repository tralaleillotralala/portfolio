CONSTANTS
	min = 1e-307
	max = 1e+308
	
DOMAINS
	Variable = real
	A = real

PREDICATES
	tasktext
	equation
	solve(real)
	checkreal(real)
	checkrange(A)
	
CLAUSES
	tasktext:-write("Enter variables for equation ax^2+bx+c=0."),nl,nl.

	equation:-
	write("Enter a: "),
	checkreal(A),checkrange(A),
	solve(A),nl,nl.
	
	checkreal(A):-readreal(A),!;
	write("Input Error! Please, enter number: "),checkreal(A).
	checkrange(A):-A>min,A<max,!;
	write("Range Error! The number is not included in the range of valid values."),nl,write("Try again."),nl.
	
	solve(A):-
	write(A).
	
GOAL
	equation