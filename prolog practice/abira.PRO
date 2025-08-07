DOMAINS
	list = symbol*
	cell = e; w; a % empty; wall; apple
	row = cell*
	matrix = row*
	position = row_col(integer, integer)
	path = position*
	state_structure = status(path, integer) % путь и число яблок
	
PREDICATES
	search
	t(integer, integer, symbol)
	steps(integer, integer)
	step_left(integer, integer)
	step_right(integer, integer)
	step_down(integer, integer)
	%apple(symbol)
	check_status(integer, integer, symbol, integer)
	
CLAUSES
	search:-
	%Apples = 29,
	Initial_H =0, Initial_W=7,
	steps(Initial_H, Initial_W),nl,nl.
	
	/*Labyrinth = [
	a, e, w, e, a, e, a, e,
	e, a, w, a, e, a, e, a,
	a, e, a, e, a, e, a, e,
	e, a, e, w, e, a, e, a,
	a, e, a, w, a, e, a, e,
	e, a, e, a, e, a, e, a,
	a, e, a, e, w, e, a, e,
	e, a, e, a, w, a, e, a],*/
	
	t(0,0,a). t(0,1,e). t(0,2,w). t(0,3,e). t(0,4,a). t(0,5,e). t(0,6,a). t(0,7,e).
	t(1,0,e). t(1,1,a). t(1,2,w). t(1,3,a). t(1,4,e). t(1,5,a). t(1,6,e). t(1,7,a).
	t(2,0,a). t(2,1,e). t(2,2,a). t(2,3,e). t(2,4,a). t(2,5,e). t(2,6,a). t(2,7,e).
	t(3,0,e). t(3,1,a). t(3,2,e). t(3,3,w). t(3,4,e). t(3,5,a). t(3,6,e). t(3,7,a).
	t(4,0,a). t(4,1,e). t(4,2,a). t(4,3,w). t(4,4,a). t(4,5,e). t(4,6,a). t(4,7,e).
	t(5,0,e). t(5,1,a). t(5,2,e). t(5,3,a). t(5,4,e). t(5,5,a). t(5,6,e). t(5,7,a).
	t(6,0,a). t(6,1,e). t(6,2,a). t(6,3,e). t(6,4,w). t(6,5,e). t(6,6,a). t(6,7,e).
	t(7,0,e). t(7,1,a). t(7,2,e). t(7,3,a). t(7,4,w). t(7,5,a). t(7,6,e). t(7,7,a).
	
	
	steps(0,7):-step_left(0,7).
	
	step_left(H,W):-
	Next_H = H, Next_W = W - 1,
	t(Next_H,Next_W,Cell_Status),
	Check_Status = Cell_Status,
	check_status(Next_H,Next_W,Check_Status,1).
	
	
	check_status(H,W,Check_Status,1):-
	Check_Status = w,!,Back_W = W + 1,write("("),write(H),write("; "),write(Back_W),write("), "),step_down(H,W);
	write("("),write(H),write("; "),write(W),write("), "),step_left(H,W).
	
	check_status(H,W,Check_Status,0):-
	Check_Status = w,!,Back_W = W - 1,write("("),write(H),write("; "),write(Back_W),write("), "),step_down(H,W);
	write("("),write(H),write("; "),write(W),write("), "),step_right(H,W).
	
	step_down(H,W):-
	Next_H = H + 1, Next_W = W,
	step_right(Next_H,Next_W).
	
	step_right(H,W):-
	Next_H = H, Next_W = W + 1,
	t(Next_H,Next_W,Cell_Status),
	Check_Status = Cell_Status,
	check_status(Next_H,Next_W,Check_Status,0).
	
	/*steps(Initial_H,Initial_W):-
	Next_Step_H = Initial_H,
	Next_Step_W =  Initial_W - 1,
	write(Next_Step_H),write(Next_Step_W),
	t(Next_Step_H,Next_Step_W,X),
	Check_Cell_Of_Apple = X.
	
	
	apple(a,Apples):-
	Apples=Apples-1.
	apple(_,Apples):-Apples=Apples+0.*/
	
GOAL
	search.