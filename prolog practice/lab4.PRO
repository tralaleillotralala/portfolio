DOMAINS
	int = integer
	ints = int*

PREDICATES
	ins_sort(ints,ints)
	insert(int,ints,ints)
	start
	readList(ints,int)
	writeList(ints)
	checkint(int)
	checkrange(int)

CLAUSES
	ins_sort([ ],[ ]). /*отсортированный пустой список остается пустым списком */
	ins_sort([Head|Tail],List):- ins_sort(Tail,Tail_Sort),/* Tail — хвост исходного списка, Tail_Sort — отсортированный хвост исходного списка */
	insert(Head,Tail_Sort,List). /* вставляем Head (первый элемент исходного списка)в Tail_Sort, получаем List (список, состоящий из элементов исходного списка, стоящих по неубыванию) */
	insert(Element,[],[Element]). /* при вставке любого значения в пустой список, получаем одноэлементный список */
	insert(Element,[Head|Tail],[Head|Res_Tail]):- Element > Head,!, /* если вставляемое значение больше головы списка, значит его нужно вставлять в хвост */
	insert(Element,Tail,Res_Tail). /* вставляем Element в хвост Tail, в результате получаем список Res_Tail */
	insert(Element,Tail,[Element|Tail]). /* это предложение (за счет отсечения в предыдущем правиле) выполняется, только если вставляемое значение не больше головы списка Tail, значит, добавляем его первым элементом в список Tail */
	
	checkint(Variable):- readint(Variable),!; 
	write("Input Error! Please, enter number: "),checkint(Variable).
	
	checkrange(Variable):- Variable>0,!; 
	write("Range Error! The quantity value cannot be a negative number."),
	nl,write("Try again."),nl,Variable=0.
	
	readList([], N):- N <= 0,!.
	readList([Head|Tail], N):- checkint(Head),!, NewN = N - 1,
	readList(Tail, NewN).
	
	writeList([]):-!.
	writeList([Head]):- !, write(Head).
	writeList([Head|Tail]):- !, write(Head), write(", "), writeList(Tail).
	
	start:-
	write("Enter the numbers amount: "),checkint(N),checkrange(N),nl,
	readList(List,N),
	ins_sort(List,SortedList),
	write("Result: "),writeList(SortedList),nl,nl.
	
GOAL
	start.



