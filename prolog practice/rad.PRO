DOMAINS
	file = datafile
	reals = real*
	strings = string*
	size = sz(integer,integer,integer)
	matrix_size = size*
	%Раздел описания предикатов
PREDICATES
	read_real_greater_0(real)
	length(strings, integer)
	start()
	get(strings, integer, string)
	menu()
	choose(string)
	log_str(String)
	dialog_str_read_from_console()
	dialog_str_read_from_file()
	dialog_str_show_data()
	dialog_str_show_by_company()
	dialog_str_delete_from_database_by_articlenumber()
	dialog_str_clear_database()
	dialog_str_save_into_file()
	choose_variant(integer, integer, integer, integer, integer)
	print_articlenumbers(strings, integer)
	read_variant(integer, integer, integer, integer)
	print_enter_rows(strings, strings, reals, matrix_size, string)
	print_enter_rows(strings, strings, reals, matrix_size)
	read_cmd(string, string, real, size, string)
	insert_into_database(string, string, real, size)
	exists(string)
	remove_duplicates(strings, strings)
	member(string, strings)
	delete3(string, strings, strings)
	read_rows()
	front_int(string, string, string)
	clear_database()
	get_size(size,integer,integer,integer)
	dialog_str_read_from_console_1(string, string, real, size)
	radiator_edit(string, string, real, size, string, string, real,
	size)
	choose_edit(integer, string, string, real, size, string, string,
	real, size)
	print_format_consts(size)
	radiator_edited()
	print_database()
	print_database(strings, strings, reals, matrix_size)
	print_const(size)
	dialog_str_sort_by_price()
	sort(integer, reals)
	print_sorted(reals)
	upas(reals, reals, integer)
	upde(reals, reals, integer)
	bubblede(reals, reals)
	bubbleas(reals, reals)
	%Раздел описания базы данных
DATABASE
	radiator(string, string, real, size) %
	%radiators(company,articlenumber,averageprice,size)
	%Раздел описания внутренней цели
GOAL
	start().
	%Раздел описания предложений
CLAUSES
	length([], 0).
	length([_|Xs], N) :-
	length(Xs, P),
	N = P + 1.
	get([Head|_], 0, X) :-
	X = Head.
	get([_|Tail], I, X) :-
	I1 = I - 1,
	get(Tail, I1, X).
	start() :-
	makewindow(1, 15, 15, "Radiators", 1, 0, 24, 80),
	menu().
	menu() :-
	clearwindow(),
	write("*******************************"), nl,
	write("* MENU *"), nl,
	 write("*******************************"), nl,
	write("* 1. Add from console *"), nl,
	write("*******************************"), nl,
	write("* 2. Add from file *"), nl,
	write("*******************************"), nl,
	write("* 3. Show data *"), nl,
	write("*******************************"), nl,
	write("* 4. Show by company *"), nl,
	write("*******************************"), nl,
	write("* 5. Delete by article number*"), nl,
	write("*******************************"), nl,
	write("* 6. Sort by price *"), nl,
	write("*******************************"), nl,
	write("* 7. Clear *"), nl,
	write("*******************************"), nl,
	write("* 8. Save into file *"), nl,
	write("*******************************"), nl,
	write("* 0. Exit *"), nl,
	write("*******************************"), nl,
	write(" int>"), readln(S),
	clearwindow(), choose(S), menu();
	menu().
	choose(S) :-
	S = "0", !, exit;
	S = "1", !, dialog_str_read_from_console();
	S = "2", !, dialog_str_read_from_file();
	S = "3", !, dialog_str_show_data();
	S = "4", !, dialog_str_show_by_company();
	S = "5", !,
	dialog_str_delete_from_database_by_articlenumber();
	S = "6", !, dialog_str_sort_by_price();
	S = "7", !, dialog_str_clear_database();
	S = "8", !, dialog_str_save_into_file().
	dialog_str_sort_by_price():-
	clearwindow(),
	write("*************************"), nl,
	write("* 1. Ascending order *"),nl,
	write("* 2. Descending order *"),nl,
	write("* 0. Close *"),nl,
	write("*************************"), nl,
	write(" int>"),
	readint(C),
	sort(C,SL),print_sorted(SL),readln(_),!.
	print_sorted([]).
	print_sorted([Averageprice|AveT]):-
	radiator(Company,Articlenumber,Averageprice,Size),
	write("*************************"), nl,
	write("* Company: ", Company), nl,
	write("* Article number: ", Articlenumber), nl,
	write("* Average price: ", Averageprice), nl,
	get_size(Size, L,W,H),
	write("* Size:",L),write("*"),write(W),write("*"),write(H),nl,
	write("*************************"), nl,
	write(" next>"), readln(_), print_sorted(AveT).
	sort(C, SortedList) :-
	C = 1, findall(Averageprice, radiator(_, _, Averageprice,
	_), Averageprices), not(Averageprices = []), !,
	bubbleas(Averageprices,SortedList),!;
	C = 2, findall(Averageprice, radiator(_, _, Averageprice,
	_), Averageprices), not(Averageprices = []), !,
	bubblede(Averageprices,SortedList),!;
	C = 0, menu(),!;
	write("*************************"), nl,
	write("* No data or try again *"), nl,
	write("*************************"), nl,
	write(" any>"),
	readln(_),
	dialog_str_sort_by_price().
	print_articlenumbers([], _) :- !.
	print_articlenumbers([Articlenumber|Tail], N) :-
	writef("%3d. %s", N, Articlenumber), nl, N1 = N + 1,
	print_articlenumbers(Tail, N1).
	bubbleas(L,X):-upas(L,L1,0),!,bubbleas(L1,X).
	bubbleas(L,L).
	upas([X,Y|L],[Y|L1],_):-X>Y,!,upas([X|L],L1,1).
	upas([X,Y|L],[X|L1],B):-!,upas([Y|L],L1,B).
	upas(L,L,1).
	bubblede(L,X):-upde(L,L1,0),!,bubblede(L1,X).
	bubblede(L,L).
	upde([X,Y|L],[Y|L1],_):-X<Y,!,upde([X|L],L1,1).
	upde([X,Y|L],[X|L1],B):-!,upde([Y|L],L1,B).
	upde(L,L,1).
	dialog_str_show_by_company() :-
	findall(Company, radiator(Company, _,_,_), Companies),
	not(Companies = []), !,
	write("****************************"), nl,
	write("* ENTER Company *"), nl,
	remove_duplicates(Articlenumbers, AList),
	print_articlenumbers(AList, 1),
	write("****************************"), nl,
	length(AList, L), read_variant(N, 1, L, 0), N1 = N - 1,dialog_str_read_from_file
	get(AList, N1, A),
	findall(Articlenumber, radiator(_, Articlenumber, _, _),
	Articlenumbers),
	findall(Averageprice, radiator(_, _, Averageprice,_),
	Averageprices),
	findall(Size, radiator(_, _, _, Size),Sizes),
	print_enter_rows(Companies, Articlenumbers, Averageprices,
	Sizes, A);
	write("***************************"), nl,
	write("* NO DATA! *"), nl,
	write("***************************"), nl,
	write(" any>"), readln(_).
	member(Name,[Name |_]) :- !.
	member(Name,[_ |Tail]):- member(Name,Tail).
	delete3(_,[],[]) :- !.
	delete3(X,[X|T],R):- !, delete3(X,T,R).
	delete3(X,[H|T],[H|R]) :- delete3(X,T,R).
	remove_duplicates([],[]) :- !.
	remove_duplicates([H|T], [H|R]) :-
	member(H,T),!,
	delete3(H,T,R1),
	remove_duplicates(R1,R).
	remove_duplicates([H|T],[H|R]):-
	remove_duplicates(T,R).
	read_real_greater_0(D) :-
	readreal(A), A > 0, !, D = A;
	nl,
	write("********** SHOULD BE GREATER THAN 0 **********"),
	nl,
	write(" real>"), read_real_greater_0(D).
	print_enter_rows([], [], [], [], TArticlenumber) :-
	write("***********************"), nl,
	write("* DONE! *"), nl,
	write("***********************"), nl,
	write(" any>"), readln(_).
	print_enter_rows([Company|CT], [Articlenumber|ArtT],
	[Averageprice|AveT], [Size|ST], TArticlenumber):-
	Articlenumber = TArticlenumber,
	clearwindow(),
	write("*****************************************************************************"), nl,
	write("* Company: ", Company), nl,
	write("* Article number: ", Articlenumber), nl,
	write("* Average price: ", Averageprice), nl,
	get_size(Size, L,W,H),
	write("* Size:",L),write("*"),write(W),write("*"),write(H),nl,
	write("*****************************************************************************"), nl,
	write(" next>"), readln(C),
	read_cmd(Company, Articlenumber, Averageprice, Size, C),
	print_enter_rows(CT, ArtT, AveT, ST, TArticlenumber);
	Articlenumber = TArticlenumber, !;
	Articlenumber <> TArticlenumber,
	 print_enter_rows(CT, ArtT, AveT, ST, TArticlenumber).
	insert_into_database(Company, Articlenumber, Averageprice, Size)
	:-
	assertz(radiator(Company, Articlenumber, Averageprice,
	Size)).
	dialog_str_read_from_file() :-
	write("****************************"), nl,
	write("* ENTER FILE NAME *"), nl,
	write("****************************"), nl,
	write(" string>"),
	readln(Filename), exists(Filename),
	openread(datafile, Filename), readdevice(datafile),
	read_rows(),
	closefile(datafile), readdevice(keyboard),
	write("**********************"), nl,
	write("* DONE! *"), nl,
	write("**********************"), nl,
	write("any>"), !, readln(_);
	write("**************************"), nl,
	write("* RADIATORS NOT ADDED! *"), nl,
	write("**************************"), nl,
	write(" any>"), readln(_).
	exists(Filename) :-
	existfile(Filename), !;
	write("****************************"), nl,
	write("* FILE NOT FOUND *"), nl,
	write("****************************"), nl,
	write(" any>"), readln(_), !, fail.
	read_rows() :-
	not(eof(datafile)),
	readln(Line),
	front_string(Line, Company, Tail1),
	front_string(Tail1, Articlenumber, Tail2),
	front_string(Tail2, Averageprice_STR, Tail3),
	str_real(Averageprice_STR, Averageprice),
	front_string(Tail3, SIZE_STR, _),
	front_int(SIZE_STR,Length_str,T1),
	str_int(Length_str,Length),
	front_int(T1,Width_str,T2), str_int(Width_str,WIDTH),
	front_int(T2,Height_str,_), str_int(Height_str,HEIGHT),
	Size = sz(Length,WIDTH,HEIGHT),
	insert_into_database(Company, Articlenumber, Averageprice,
	Size), !, read_rows();
	not(eof(datafile)), !,
	write("**********************************"), nl,
	write("* READING ERROR! *"), nl,
	write("* REMAINING DATA WAS NOT READ! *"), nl,
	write("* SOME RADIATORS ADDED! *"), nl,
	write("**********************************"), nl; !.
	front_string("", "", "") :- !.
	front_string(Line, Param, Tail) :-
	frontchar(Line, LineH, LineT), LineH = ';',
	!, Param = "", Tail = LineT;
	frontchar(Line, LineH, LineT), LineH <> ';', !,
	front_string(LineT, T, Tail),
	str_char(LineHS, LineH),
	concat(LineHS, T, Param).
	front_int("", "", "") :- !.
	front_int(Line, Param, Tail) :-
	frontchar(Line, LineH, LineT), LineH = '*',
	!, Param = "", Tail = LineT;
	frontchar(Line, LineH, LineT), LineH <> '*', !,
	front_int(LineT, T, Tail),
	str_char(LineHS, LineH),
	concat(LineHS, T, Param).
	dialog_str_read_from_console() :-
	dialog_str_read_from_console_1(Company, Articlenumber,
	Averageprice, Size),
	insert_into_database(Company, Articlenumber, Averageprice,
	Size), !,
	write("*********************"),nl,
	write("* RADIATOR ADDED! *"),nl,
	write("*********************"),nl,
	write(" any>"), readln(_);
	write("*************************"),nl,
	write("* RADIATOR NOT ADDED! *"),nl,
	write("*************************"),nl,
	write(" any>"), readln(_).
	dialog_str_read_from_console_1(Company, Articlenumber,
	Averageprice, Size) :-
	write("*************************************"),nl,
	write("* COMPANY OF RADIATOR TO INSERT *"),nl,
	write("*************************************"),nl,
	write(" str>"), readln(Company), Company <> "",
	clearwindow(),
	write("********************************"),nl,
	write("* ARTICLE NUMBER OF RADIATOR *"),nl,
	write("********************************"),nl,
	write(" str>"), readln(Articlenumber), Articlenumber <>
	"",clearwindow(),
	write("******************************"),nl,
	write("* AVERAGE PRICE OF RADIATOR *"),nl,
	write("******************************"),nl,
	write(" real>"),
	read_real_greater_0(Averageprice),clearwindow(),
	write("*************************************"),nl,
	write("* LENGTH OF RADIATOR *"),nl,
	write("*************************************"),nl,
	write(" int>"), readint(Length), Length > 0,clearwindow(),
	write("*************************************"),nl,
	write("* WIDTH OF RADIATOR *"),nl,
	write("*************************************"),nl,
	write(" int>"), readint(Width), Width > 0,clearwindow(),
	write("*************************************"),nl,
	write("* HEIGHT OF RADIATOR *"),nl,
	write("*************************************"),nl,
	write(" int>"), readint(Height), Height > 0,
	Size = sz(Length,Width,Height),
	clearwindow().
	read_variant(N, From, To, ErrorCode) :-
	write(" int>"),
	readint(C), choose_variant(N, C, From, To, ErrorCode).
	choose_variant(N, C, From, To, ErrorCode) :-
	bound(ErrorCode), C = ErrorCode, !, fail;
	From <= C, C <= To, N = C, !;
	write("********** TRY AGAIN **********"),nl,
	write(" int>"), readint(D), choose_variant(N, D, From,
	To, ErrorCode).
	dialog_str_delete_from_database_by_articlenumber() :-
	findall(Averageprice, radiator(_, _, _, Averageprice),
	AveragepriceList), AveragepriceList = [],
	write("***********************"),nl,
	write("* NO DATA! *"),nl,
	write("***********************"),nl,
	write(" any>"), readln(_);
	write("*************************************"),nl,
	write("* COMPANY OF RADIATOR TO REMOVE*"),nl,
	write("*************************************"),nl,
	write(" str>"), readln(Company),
	retract(radiator(Company, _, _, _)), !,
	write("***********************"),nl,
	write("* RADIATOR DELETED! *"),nl,
	write("***********************"),nl,
	write(" any>"), readln(_);
	write("*************************"),nl,
	write("* RADIATOR NOT FOUND! *"),nl,
	write("*************************"),nl,
	write(" any>"), readln(_).
	dialog_str_clear_database() :-
	findall(Averageprice, radiator(_, _, _, Averageprice),
	AveragepriceList), AveragepriceList = [],
	write("***********************"),nl,
	write("* NO DATA! *"),nl,
	write("***********************"),nl,
	write(" any>"), readln(_);
	write("**************************************"),nl,
	write("* ARE YOU SURE TO DELETE ALL DATA? *"),nl,
	write("**************************************"),nl,
	write(" [y/n]>"), readln(X), X = "y", !,
	not(clear_database()),
	write("*******************"),nl,
	write("* DATA DELETED! *"),nl,
	write("*******************"),nl,
	write(" any>"), readln(_).
	clear_database() :-
	retract(radiator(_, _, _, _)), fail.
	dialog_str_show_data() :-
	findall(Company, radiator(Company, _, _, _), Companies),
	findall(Articlenumber, radiator(_, Articlenumber, _, _),
	Articlenumbers),
	findall(Averageprice, radiator(_, _, Averageprice, _),
	Averageprices), not(Averageprices = []),
	findall(Size, radiator(_, _, _, Size), SizeList),!,
	print_enter_rows(Companies, Articlenumbers, Averageprices,
	SizeList);
	write("***********************"),nl,
	write("* NO DATA! *"),nl,
	write("***********************"),nl,
	write(" any>"), readln(_).
	print_enter_rows([], [], [], []) :-
	write("***********************"), nl,
	write("* DONE! *"), nl,
	write("***********************"), nl,
	write(" any>"), readln(_).
	print_enter_rows([Company|CT], [Articlenumber|ArtT],
	[Averageprice|AveT], [Size|ST]) :-
	clearwindow(),
	write("*****************************************************************************"), nl,
	write("* Company: ", Company), nl,
	write("* Article number: ", Articlenumber), nl,
	write("* Average price: ", Averageprice), nl,
	 get_size(Size, L,W,H),
	write("* Size:",L),write("*"),write(W),write("*"),write(H),nl,
	write("*****************************************************************************"), nl,
	write(" next>"), readln(C),
	read_cmd(Company, Articlenumber, Averageprice, Size, C),
	print_enter_rows(CT, ArtT, AveT, ST).
	read_cmd(Company, Articlenumber, Averageprice, Size, C) :-
	C <> "delete", C <> "edit", C <> "close", !;
	C = "close", !, fail;
	C = "delete", retract(radiator(Company, Articlenumber,
	Averageprice, Size)), !,
	write("***********************"), nl,
	write("* RADIATOR DELETED! *"), nl,
	write("***********************"), nl,
	write(" any>"), readln(_);
	C = "edit", !, radiator_edit(Company, Articlenumber,
	Averageprice, Size, _, _, _, _);
	write("*************************"), nl,
	write("* RADIATOR NOT FOUND! *"), nl,
	write("*************************"), nl,
	write(" any>"), readln(_).
	radiator_edit(Company, Articlenumber, Averageprice, Size,
	NewCompany, NewArticlenumber, NewAverageprice, NewSize) :-
	clearwindow(),
	write("*************************"), nl,
	write("* EDIT RADIATOR *"), nl,
	write("*************************"), nl,
	write("Company: ", Company), nl,
	write("Article number: ", Articlenumber), nl,
	 write("Average price(rub): ", Averageprice), nl,
	write("Size: ", Size), nl,
	write("**************************"), nl,
	write("* 1. Edit Company *"), nl,
	write("**************************"), nl,
	write("* 2. Edit Article number*"), nl,
	write("**************************"), nl,
	write("* 3. Edit Average price *"), nl,
	write("**************************"), nl,
	write("* 4. Edit Size *"), nl,
	write("**************************"), nl,
	write("* 0. Close *"), nl,
	write("**************************"), nl,
	read_variant(N, 1, 4, 0),
	choose_edit(N, Company, Articlenumber, Averageprice, Size,
	NewCompany, NewArticlenumber, NewAverageprice, NewSize),
	radiator_edit(NewCompany, NewArticlenumber,
	NewAverageprice, NewSize, _, _, _, _), !; !.
	choose_edit(N, Company, Articlenumber, Averageprice, Size,
	NewCompany, NewArticlenumber, NewAverageprice, NewSize) :-
	N = 0, !, fail;
	N = 1, !,
	write("***********************"), nl,
	write("* EDIT COMPANY *"), nl,
	write("***********************"), nl,
	write(" str>"), readln(Cmpn), Cmpn <> "", clearwindow(),
	NewCompany = Cmpn, NewArticlenumber = Articlenumber,
	NewAverageprice = Averageprice, NewSize = Size,
	retract(radiator(Company, Articlenumber, Averageprice,
	Size)), 
	asserta(radiator(NewCompany, NewArticlenumber,
	NewAverageprice, NewSize)),
	radiator_edited();
	N = 2, !,
	write("***********************"), nl,
	write("* EDIT ARTICLE NUMBER *"),nl,
	write("***********************"),nl,
	write(" str>"), readln(Art), Art <> "", clearwindow(),
	NewCompany = Company, NewArticlenumber = Art,
	NewAverageprice = Averageprice, NewSize = Size,
	retract(radiator(Company, Articlenumber, Averageprice,
	Size)),
	asserta(radiator(NewCompany, NewArticlenumber,
	NewAverageprice, NewSize)),
	radiator_edited();
	N = 3, !,
	write("***********************"), nl,
	write("* EDIT AVERAGE PRICE *"), nl,
	write("***********************"), nl,
	write(" str>"), read_real_greater_0(D), clearwindow(),
	NewCompany = Company, NewArticlenumber = Articlenumber,
	NewAverageprice = D, NewSize = Size,
	retract(radiator(Company, Articlenumber, Averageprice,
	Size)),
	asserta(radiator(NewCompany, NewArticlenumber,
	NewAverageprice, NewSize)),
	radiator_edited();
	N = 4, !,
	write("*************************************"),nl,
	write("* EDIT LENGHT *"),nl,
	write("*************************************"),nl,
	write(" int>"), readint(L), L > 0, clearwindow(),
	write("*************************************"),nl,
	write("* EDIT WIDTH *"),nl,
	write("*************************************"),nl,
	write(" int>"), readint(W), W > 0, clearwindow(),
	write("*************************************"),nl,
	write("* EDIT HEIGHT *"),nl,
	write("*************************************"),nl,
	write(" int>"), readint(H), H > 0, clearwindow(),
	T = sz(L,W,H),
	NewCompany = Company, NewArticlenumber = Articlenumber,
	NewAverageprice = Averageprice, NewSize = T,
	retract(radiator(Company, Articlenumber, Averageprice,
	Size)),
	asserta(radiator(NewCompany, NewArticlenumber,
	NewAverageprice, NewSize)),
	radiator_edited().
	radiator_edited() :-
	write("***********************"), nl,
	write("* RADIATOR EDITED *"),nl,
	write("***********************"),nl,
	write(" any>"), readln(_).
	print_format_consts(sz(L,W,H)) :-
	writef("%d*d*%d", L,W,H), nl.
	dialog_str_save_into_file() :-
	findall(Averageprice, radiator(_, _, _, Averageprice),
	AveragepriceList), AveragepriceList = [], !,
	write("***********************"), nl,
	write("* NO DATA! *"), nl,
	write("***********************"), nl,
	write(" any>"), readln(_);
	write("****************************"), nl,
	write("* ENTER FILE NAME *"), nl,
	write("****************************"), nl,
	write(" string>"), readln(Filename),
	openwrite(datafile, Filename), writedevice(datafile),
	print_database(),
	closefile(datafile), writedevice(screen),
	write("***********************"), nl,
	write("* DONE! *"), nl,
	write("***********************"), nl,
	write(" any>"), readln(_).
	get_size(sz(L,W,H),L,W,H).
	print_database() :-
	findall(Company, radiator(Company, _, _, _), Companies),
	findall(Articlenumber, radiator(_, Articlenumber, _, _),
	Articlenumbers),
	findall(Averageprice, radiator(_, _, Averageprice, _),
	Averageprices),
	findall(Size, radiator(_, _, _, Size), Sizes),
	print_database(Companies, Articlenumbers, Averageprices,
	Sizes);
	writedevice(screen).
	print_database([], [], [], []) :- !.
	print_database([Company|CT], [Articlenumber|ArtT],
	[Averageprice|AvgT], [Size|ST]) :-
	write(Company, ";", Articlenumber, ";", Averageprice, ";"),
	print_const(Size),nl,
	print_database(CT, ArtT, AvgT, ST).
	print_const(sz(L,W,H)):-
	write(L,"*",W,"*",H).
	log_str(String) :-
	removewindow(), write(String), nl, makewindow(1, 15, 15,
	"Radiators", 1, 0, 24, 80).