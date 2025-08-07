	CONSTANTS
	min = -1e+308
	max = 1e+308
	
DOMAINS
	TOx1, TOy1, TOx2, TOy2, TOx3, TOy3, ROx1, ROy1,  ROx2, ROy2, ROx3, ROy3, ROx4, ROy4 = real

PREDICATES
	tasktext
	intersection
	solve(real, real, real, real, real, real, real, real, real, real, real, real, real, real)
	determinant(real, real, real, real, real, real, real, real, real, real, real, real)
	correctDeterm(real, real, real, real, real, real, real, real, real, real)
	comparison(real, real, real)
	checkreal(real)
	checkrange(real)
	
CLAUSES
	tasktext:-write("Enter the coordinates of the vertices of the triangle and quadrilateral to find the intersection."),nl,nl.
	intersection:-
	write("Enter vertices coordinates  of the triangle:"),
	write("Enter TOx1: "),
	checkreal(TOx1),checkrange(TOx1),
	write("Enter TOy1: "),
	checkreal(TOy1),checkrange(TOy1),
	write("Enter TOx2: "),
	checkreal(TOx2),checkrange(TOx2),
	write("Enter TOy2: "),
	checkreal(TOy2),checkrange(TOy2),
	write("Enter TOx3: "),
	checkreal(TOx3),checkrange(TOx3),
	write("Enter TOy3: "),
	checkreal(TOy3),checkrange(TOy3),
	write("Enter vertices coordinates  of the quadrilateral:"),
	write("Enter ROx1: "),
	checkreal(ROx1),checkrange(ROx1),
	write("Enter ROy1: "),
	checkreal(ROy1),checkrange(ROy1),
	write("Enter ROx2: "),
	checkreal(ROx2),checkrange(ROx2),
	write("Enter ROy2: "),
	checkreal(ROy2),checkrange(ROy2),
	write("Enter ROx3: "),
	checkreal(ROx3),checkrange(ROx3),
	write("Enter ROy3: "),
	checkreal(ROy3),checkrange(ROy3),
	write("Enter ROx4: "),
	checkreal(ROx4),checkrange(ROx4),
	write("Enter ROy4: "),
	checkreal(ROy4),checkrange(ROy4),
	write("Result: "),
	solve(TOx1, TOy1, TOx2, TOy2, TOx3, TOy3, ROx1, ROy1,  ROx2, ROy2, ROx3, ROy3, ROx4, ROy4).
	
	% проверка на корректность ввода
	checkreal(Variable):-readreal(Variable),!;
	write("Input ErRor! Please, enter number: "),checkreal(Variable).
	checkrange(Variable):-Variable>min,Variable<max,!;
	write("Range ErRor! The number is not included in the range of valid values."),nl,write("Try again."),nl,Variable=0.

	% предикат для нахождения коэффициентов k и b линейного уравнения прямой y = kx + b
	% T - треугольник, R - четырехугольник
	solve(TOx1, TOy1, TOx2, TOy2, TOx3, TOy3, ROx1, ROy1, ROx2, ROy2, ROx3, ROy3, ROx4, ROy4):-
	TL1_k = (TOy2-TOy1)/(TOx2-TOx1), TL1_b = (((TOx2-TOx1)*(TOy1))-((TOy2-TOy1)*(TOx1)))/(TOx2-TOx1),
	TL2_k = (TOy3-TOy2)/(TOx3-TOx2), TL2_b = (((TOx3-TOx2)*(TOy2))-((TOy3-TOy2)*(TOx2)))/(TOx3-TOx2),
	TL3_k = (TOy1-TOy3)/(TOx1-TOx3), TL3_b = (((TOx1-TOx3)*(TOy3))-((TOy1-TOy3)*(TOx3)))/(TOx1-TOx3),
	RL1_k = (ROy2-ROy1)/(ROx2-ROx1), RL1_b = (((ROx2-ROx1)*(ROy1))-((ROy2-ROy1)*(ROx1)))/(ROx2-ROx1),
	RL2_k = (ROy3-ROy2)/(ROx3-ROx2), RL2_b = (((ROx3-ROx2)*(ROy2))-((ROy3-ROy2)*(ROx2)))/(ROx3-ROx2),
	RL3_k = (ROy4-ROy3)/(ROx4-ROx3), RL3_b = (((ROx4-ROx3)*(ROy3))-((ROy4-ROy3)*(ROx3)))/(ROx4-ROx3),
	RL4_k = (ROy1-ROy4)/(ROx1-ROx4), RL4_b = (((ROx1-ROx4)*(ROy4))-((ROy1-ROy4)*(ROx4)))/(ROx1-ROx4),
	determinant(TL1_k, TL1_b, RL1_k, RL1_b, TOx1, TOy1, TOx2, TOy2, ROx1, ROy1, ROx2, ROy2),
	determinant(TL1_k, TL1_b, RL2_k, RL2_b, TOx1, TOy1, TOx2, TOy2, ROx2, ROy2, ROx3, ROy3),
	determinant(TL1_k, TL1_b, RL3_k, RL3_b, TOx1, TOy1, TOx2, TOy2, ROx3, ROy3, ROx4, ROy4),
	determinant(TL1_k, TL1_b, RL4_k, RL4_b, TOx1, TOy1, TOx2, TOy2, ROx4, ROy4, ROx1, ROy1),
	
	determinant(TL2_k, TL2_b, RL1_k, RL1_b, TOx2, TOy2, TOx3, TOy3, ROx1, ROy1, ROx2, ROy2),
	determinant(TL2_k, TL2_b, RL2_k, RL2_b, TOx2, TOy2, TOx3, TOy3, ROx2, ROy2, ROx3, ROy3),
	determinant(TL2_k, TL2_b, RL3_k, RL3_b, TOx2, TOy2, TOx3, TOy3, ROx3, ROy3, ROx4, ROy4),
	determinant(TL2_k, TL2_b, RL4_k, RL4_b, TOx2, TOy2, TOx3, TOy3, ROx4, ROy4, ROx1, ROy1),
	
	determinant(TL1_k, TL1_b, RL1_k, RL1_b, TOx3, TOy3, TOx1, TOy1, ROx1, ROy1, ROx2, ROy2),
	determinant(TL1_k, TL1_b, RL2_k, RL2_b, TOx3, TOy3, TOx1, TOy1, ROx2, ROy2, ROx3, ROy3),
	determinant(TL1_k, TL1_b, RL3_k, RL3_b, TOx3, TOy3, TOx1, TOy1, ROx3, ROy3, ROx4, ROy4),
	determinant(TL1_k, TL1_b, RL4_k, RL4_b, TOx3, TOy3, TOx1, TOy1, ROx4, ROy4, ROx1, ROy1).
	
	% принимает значения коэффициентов уравнения прямой и вершины фигур, которые ограничивают прямые
	determinant(K1, B1, K2, B2, TX1, TY1, TX2, TY2, RX1, RY1, RX2, RY2):-
	K = K1-K2, B = B1-B2, K <> 0, !, X = (-B)/K,
	Y = K1*X+B1, correctDeterm(X, Y, TX1, TY1, TX2, TY2, RX1, RY1, RX2, RY2).
	
	% проверка точки пересечения, находится ли она в границах отрезка
	correctDeterm(X, Y, TX1, TY1, TX2, TY2, RX1, RY1, RX2, RY2):-
	comparison(X, TX1, TX2),comparison(Y, TY1, TY2),comparison(X, RX1, RX2),comparison(Y, RY1, RY2),!,
	write("  ( "),write(X),write("; "),write(Y),write(" ) "),nl.
	
	% предикат, который проверяет координаты на принадлежность к определенному диапазону
	comparison(X, X1, X2):-X1<=X, X<=X2,!;
	X2<X, X<X1.

	
	
GOAL
	tasktext,
	intersection
	

	
	
	
	
	
	
	
	
	





