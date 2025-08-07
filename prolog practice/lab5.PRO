DOMAINS
	cell = e; w; a % empty; wall; apple
	row = cell*
	matrix = row*
	position = row_col(integer, integer)
	path = position*
	state_structure = status(path, integer) % путь и число яблок
	
PREDICATES
	search
	depth_search(matrix, state_structure, path)
	step(matrix, state_structure, state_structure)
	next_cell(integer, integer)
	cell_pass(cell, integer, integer)
	matrix_cell(position, matrix, cell)
	member(position, path)
	nth0(integer, matrix, cell)
	
CLAUSES
	search:-
	Labyrinth = [
	[a, e, w, e, a, e, a, e],
	[e, a, w, a, e, a, e, a],
	[a, e, a, e, a, e, a, e],
	[e, a, e, w, e, a, e, a],
	[a, e, a, w, a, e, a, e],
	[e, a, e, a, e, a, e, a],
	[a, e, a, e, w, e, a, e],
	[e, a, e, a, w, a, e, a]],
	
	/*[a, e, w, |, -, -, -, o],
	[e, a, w, |, -, -, |, a],
	[a, e, a, e, a, e, a, e],
	[e, a, e, w, e, a, e, a],
	[a, e, a, w, a, e, a, e],
	[e, a, e, a, e, a, e, a],
	[a, e, a, e, w, e, a, e],
	[e, a, e, a, w, a, e, a]],*/
	
		/*Labyrinth = [
	a, e, w, e, a, e, a, e,
	e, a, w, a, e, a, e, a,
	a, e, a, e, a, e, a, e,
	e, a, e, w, e, a, e, a,
	a, e, a, w, a, e, a, e,
	e, a, e, a, e, a, e, a,
	a, e, a, e, w, e, a, e,
	e, a, e, a, w, a, e, a],
	Initial_Position = row_col(0, 7),
	depth_search(Labyrinth,Initial_Position, 29),nl.
	
	depth_search(Labyrinth,Position,Apples):-
	write(Labyrinth),nl,
	write(Apples),nl,
	write(Position),nl.*/
	
/*  Лабиринт = [
    [яблоко, пусто, стена, пусто, яблоко, пусто, яблоко, пусто],
    [пусто, яблоко, стена, яблоко, пусто, яблоко, пусто, яблоко],
    [яблоко, пусто, яблоко, пусто, яблоко, пусто, яблоко, пусто],
    [пусто, яблоко, пусто, стена, пусто, яблоко, пусто, яблоко],
    [яблоко, пусто, яблоко, стена, яблоко, пусто, яблоко, пусто],
    [пусто, яблоко, пусто, яблоко, пусто, яблоко, пусто, яблоко],
    [яблоко, пусто, яблоко, пусто, стена, пусто, яблоко, пусто],
    [пусто, яблоко, пусто, яблоко, стена, яблоко, пусто, яблоко]],*/
	
    depth_search(Labyrinth,status([row_col(0, 7)|_], 29),Path),nl,write(Path),nl.
	
	depth_search(Labyrinth, Current_status, Path):-
    step(Labyrinth, Current_status, Final_status), 
    Final_status = status(Path, 0),
    Path = [row_col(0, 7)|_], !.
	depth_search(Labyrinth, Current_status, Path):-
    step(Labyrinth, Current_status, New_status), 
    New_status = status([New_cell|Back_Path], _),
	write(New_status),nl,
    NOT(member(New_cell, Back_Path)),
    depth_search(Labyrinth, New_status, Path).
	
	step(Labyrinth, status(Current_position, Apples_now), status(Current_position, Apples_then)):-
	%Current_Path = [Current_position|_],
	next_cell(Current_position, Next_cell_position),
	matrix_cell(Next_cell_position, Labyrinth, Cell),
	cell_pass(Cell, Apples_now, Apples_then).
	%New_Path = [Next_cell_position|Current_Path].
	
	member(X, [X|_]).
	member(X, [_|C]):- member(X, C).

	next_cell(row_col(Row, Col), row_col(New_Row, Col)):-
	New_Row = Row + 1; New_Row = Row  - 1.
	next_cell(row_col(Row, Col), row_col(Row, New_Col)):-
	New_Col = Col + 1; New_Col = Col - 1.
	
	cell_pass(a, Apples_now, Apples_then):-
	Apples_then = Apples_now - 1.
	cell_pass(e, Apples_quantity, Apples_quantity).
	
	matrix_cell(row_col(Row, Col), Matrix, Variable):-
    nth0(Row, Matrix, Variable),
    nth0(Col, Matrix, Variable).
	
	nth0(0, _, _):-!.
	nth0(Index, _, _):-
	Index < 0, !, fail.
	nth0(Index, Matrix, Elem):-
	NextIndex = Index - 1,
	nth0(NextIndex, Matrix, Elem).


GOAL
	search