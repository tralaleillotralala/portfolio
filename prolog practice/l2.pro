CONSTANTS 
	min = -1e+308 % нижняя граница диапазона вещественных чисел 
	max = 1e+308 % верхняя граница диапазона вещественных чисел 
DOMAINS 
	X1, Y1, X2, Y2, X31, Y31, X32, Y32, X33, Y33 = real % исходные данные, которые вводит пользователь 
	PREDICATES 
	tasktext % вывод сообщения "Enter variables for equation ax^2+bx+c=0." 
	equation %% внутренняя цель программы
	solve(real, real, real, real, real, real) % проверка условия
	checkreal(real) % проверка на корректный ввод 
	checkrange(real) % проверка на попадание значений в диапазон [-1e+307; 1e+308] 
CLAUSES 
	tasktext:- write("Vvedite x1, y1 dlya pr."),nl,nl. 
	equation:- 
	write("Enter X1: "), checkreal(X1),checkrange(X1), % вводим А и проверяем на корректность ввода 
	write("Enter Y1: "), checkreal(Y1),checkrange(Y1), % далее аналогично 
	write("Enter X2: "), checkreal(X2),checkrange(X2), 
	write("Enter Y2: "), checkreal(Y2),checkrange(Y2),
	
	write("Enter X31: "), checkreal(X31),checkrange(X31), 
	write("Enter Y31: "), checkreal(Y31),checkrange(Y31),
	
	write("Enter X32: "), checkreal(X32),checkrange(X32), 
	write("Enter Y32: "), checkreal(Y32),checkrange(Y32),
	
	write("Enter X33: "), checkreal(X33),checkrange(X33), 
	write("Enter Y33: "), checkreal(Y33),checkrange(Y33),

	solve(X1,Y1,X2,Y2,X31,Y31),
	solve(X1,Y1,X2,Y2,X32,Y32),
	solve(X1,Y1,X2,Y2,X33,Y33).% переходим к решению 
	
	checkreal(Variable):- readreal(Variable),!; 
	write("Input Error! Please, enter number: "),checkreal(Variable). 
	
	checkrange(Variable):- Variable>min,Variable<max,!; 
	write("Range Error! The number is not included in the range of valid values."),
	nl,write("Try again."),nl,Variable=0. % выводится сообщение об ошибке 
	
	solve(X1,Y1,X2,Y2,X3,Y3):- 
	X1<=X3, X2>=X3, Y1<=Y3,Y2>=Y3, nl, !;
	write(" ",X3," ",Y3," peresech"),nl.
GOAL 
	tasktext, equation.
	