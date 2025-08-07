CONSTANTS
	min = -1e+307
	max = 1e+308
	
DOMAINS
	A, B, C = real

PREDICATES
	tasktext
	equation
	solve(real, real, real)
	solvecomplex(real, real, real)
	checkreal(real)
	checkrange(real)
	
CLAUSES
	tasktext:-write("Enter variables for equation ax^2+bx+c=0."),nl,nl.
	equation:-
	write("Enter a: "),
	checkreal(A),checkrange(A),
	write("Enter b: "),
	checkreal(B),checkrange(B),
	write("Enter c: "),
	checkreal(C),checkrange(C),
	solve(A,B,C).
	
	checkreal(Variable):-readreal(Variable),!;
	write("Input Error! Please, enter number: "),checkreal(Variable).
	checkrange(Variable):-Variable>min,Variable<max,!;
	write("Range Error! The number is not included in the range of valid values."),nl,write("Try again."),nl,Variable=0.
	
	solve(A,B,C):-
	A=0,B=0,C=0,write("x is any number"),nl,nl,!;
	A=0,B=0,write("no solutions"),nl,nl,!;
	A=0,!,write("A=0 => X= "),X=-C/B,write(X),nl,nl.

	solve(A,B,C):-D=B*B-4*A*C,D<0,!,write("D<0 => no real roots"),nl,solvecomplex(A,B,D).
	solve(A,B,C):-D=B*B-4*A*C,D=0,!, write("D=0 => X1=X2= "),X=-B/(2*A),write(X).
	solve(A,B,C):-D=B*B-4*A*C,X1=(-B+sqrt(D))/(2*A),X2=(-B-sqrt(D))/(2*A),write("D>0 => X1= "),
	write(X1),write(" X2= "),write(X2).
	
	solvecomplex(A,B,D):-
	X=(-B)/(2*A),Xi=sqrt(abs(D))/(2*A),
	write("X1= ",X," + ",Xi,"i"),nl,
	write("X2= ",X," - ",Xi,"i").
	
GOAL
	tasktext,
	equation