DOMAINS
	cell_type = e; w; a; v
	row = cell_type*
	matrix = row*
	position = row_col(integer, integer)
	path = matrix*
    
PREDICATES
	nondeterm member(cell_type, row)
	nondeterm member(row, matrix)
	nondeterm append(row, row, row)
	nondeterm append(matrix, matrix, matrix)
	nondeterm move(matrix, position, matrix, position)
	nondeterm search_in_depth(matrix, position, path, path)
	nondeterm next_position(position, integer, integer, position)
	nondeterm solve
	length(row, integer)
	length(matrix, integer)
	nth0(integer, matrix, row)
	nth0(integer, row, cell_type)
	nth00(position, matrix, cell_type)
	set_nth0(row, integer, cell_type, row)
	set_nth0(matrix, integer, row, matrix)
	set_nth00(matrix, position, cell_type, matrix)
	print_matrix(matrix)
	print_cell(cell_type)
	no_apples(matrix)
	can_move(matrix, position)
	print_path(path)

CLAUSES
	member(Elem, [Elem|_]).
	member(Elem, [_|Tail]):-
	member(Elem, Tail).
	
	length([], 0):-!.
	length([_|Tail], Length):-
	length(Tail, TailLength),
	Length = TailLength + 1.
	
	nth0(0, [Elem|_], Elem):-!.
	nth0(Index, _, _):-
	Index < 0, !, fail.
	nth0(Index, [_|Tail], Elem):-
	NextIndex = Index - 1,
	nth0(NextIndex, Tail, Elem).
	
	nth00(row_col(Y, X), Matrix, Cell):-
	nth0(Y, Matrix, Row),
	nth0(X, Row, Cell).
	

	
	set_nth0(List, Position, Value, NewList):-
	append(LeftPart, Right, List),
	length(LeftPart, Position),
	Right = [_|RightWithoutValue],
	append(LeftPart, [Value|RightWithoutValue], NewList), !.
	
	set_nth00(Source, row_col(Y, X), Cell, Result):-
	nth0(Y, Source, Row),
	set_nth0(Row, X, Cell, NewRow),
	set_nth0(Source, Y, NewRow, Result).
	append([], List2, List2).

	append([Head|Tail], List2, [Head|TailResult]):-
	append(Tail, List2, TailResult).

	print_matrix([]):-!.
	print_matrix([[]|Tail]):-
	!, nl, print_matrix(Tail).
	print_matrix([[Head|RowTail]|Tail]):-
	print_cell(Head), write(" "), print_matrix([RowTail|Tail]).
	print_cell(a):-
	write("o").
	print_cell(e):-
	write(" ").
	print_cell(w):-
	write("#").
	print_cell(v):-
	write("x").
	
	no_apples(Matrix):-
	member(Row, Matrix), member(a, Row), !, fail;!.
	
	next_position(row_col(CurrentY, CurrentX), W, H, row_col(NextY, NextX)):-
	CurrentX > 0, NextX = CurrentX - 1, NextY = CurrentY;
	CurrentY > 0, NextX = CurrentX, NextY = CurrentY - 1;
	CurrentX < W-1, NextX = CurrentX + 1, NextY = CurrentY;
	CurrentY < H-1, NextX = CurrentX, NextY = CurrentY + 1.
	
	can_move(Matrix, Position):-
	nth00(Position, Matrix, e),!;
	nth00(Position, Matrix, a),!.
	
	move(Matr, Position, NextMatrix, NextPosition):-
	next_position(Position, 7, 7, NextPosition),
	can_move(Matr, NextPosition),
	set_nth00(Matr, NextPosition, v, NextMatrix).
	
	/*
	search_in_depth(Matrix, Position, Buffer, Path):-
	print_matrix(Matrix), nl, fail.*/
	search_in_depth(Matrix, Position, Buffer, Path):-
	%Position = row_col(0, 7), no_apples(Matrix), !,
	Position = row_col(3, 4), !,
	Path = Buffer.
	search_in_depth(Matrix, Position, Buffer, Path):-
	move(Matrix, Position, NextMatrix, NextPosition),
	%not(old_state(NextMatrix)),
	%assert(old_state(NextMatrix)),
	search_in_depth(NextMatrix, NextPosition, [NextMatrix|Buffer], Path).
	
	solve:-
	Matrix = [
	[a, e, w, e, a, e, a, v],
	[e, a, w, a, e, a, e, a],
	[a, e, a, e, a, e, a, e],
	[e, a, e, w, e, a, e, a],
	[a, e, a, w, a, e, a, e],
	[e, a, e, a, e, a, e, a],
	[a, e, a, e, w, e, a, e],
	[e, a, e, a, w, a, e, a]],
	%print_matrix(Matrix), nl,
	Position = row_col(0, 7),
	/*
	move(Matrix, Position, Next, NextPosition),
	print_matrix(Next), nl, fail; !.
	*/
	search_in_depth(Matrix, Position, [Matrix], Path),
	print_path(Path),!.
	print_path([]):-!.
	print_path([Head|Tail]):-
	print_path(Tail),
	
	print_matrix(Head), nl.

GOAL
	solve.