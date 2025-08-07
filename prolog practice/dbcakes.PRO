CONSTANTS
	min = -1e+308
	max = 1e+308

DOMAINS
	file = datafile
	name = string
	main_ingredient = string
	caketype = string
	cuisine = string
	calorific_value = real
	protein, fats, carbs = real
	minq, maxq = real
	reals = real*
	strings = string*

DATABASE -cakes_db
	nondeterm cake(name, main_ingredient, caketype, cuisine, calorific_value, protein, fats, carbs)

PREDICATES
	start
	menu(integer)
	checkreal(real)
	checkrange(real)
	check_menu_key(integer)
	check_menu_key_range(integer)
	print_into_csv
	print_database()
	exists(string)
	dialog_str_read_from_file()
	print_database(strings, strings, strings, strings, reals, reals, reals, reals)
	nondeterm show_cakes_of_calorific(minq, maxq)
	nondeterm show_cakes_of_protein(minq, maxq)
	nondeterm show_cakes_of_fats(minq, maxq)
	nondeterm show_cakes_of_carbs(minq, maxq)
	nondeterm print_cake_information(name, main_ingredient, caketype, cuisine, calorific_value, protein, fats, carbs)
	nondeterm print_cakes_by_cuisine(cuisine)

CLAUSES
	cake("Gao","Bananas","Puff pastry or cupcake base","Chinese", 428, 66, 17, 60).
	cake("Bantuoy","Bananas","Pancake base","Vietnam", 115, 35, 35, 15).
	cake("Kue-nagasari","Bananas","Rice flour dough","Indonesian", 184, 77, 50, 34).
	cake("Banoffee pie","Bananas","Shortbread dough","English", 468, 78, 28, 44).
	cake("Battenberg cake","Apricot jam","Sponge cake and marzipan glaze","English", 381, 54, 13, 61).
	cake("Buccellato","Dried and fresh fruits, nuts","Biscuit","Austrian", 378, 74, 22, 38).
	cake("Waffle cake","Chocolate","Waffle sheets","Sicilian", 497, 66, 31, 58).
	cake("Garash","Chocolate","Ground walnuts","Bulgarian", 497, 16, 31, 58).
	cake("Sachertorte","Chocolate","Biscuit","Austrian", 420, 13, 19, 58).
	cake("Zuccotto","Ricotta cheese","Biscuit","Italian", 455, 112, 32, 23).
	cake("Caprese","Chocolate","Nut dough","Italian", 153, 64, 121, 23).
	cake("Red Velvet cake","Chocolate","Biscuit","American", 117, 129, 15, 100).
	cake("Mazurek","Dried and fresh fruits, nuts","Shortbread dough","Polish", 397, 23, 23, 4).
	cake("Medovik","Sour cream, honey","Honey cakes","Russian", 311, 81, 14, 62).
	cake("Napoleon","Cream filling","Puff pastry","Russian", 340, 17, 15, 43).
	cake("Prague","Chocolate","Biscuit","Russian", 416, 41, 24, 44).
	cake("RigóJancsi","Chocolate","Biscuit","Hungarian", 323, 23, 14, 53).
	cake("Sour cream","Sour cream","Biscuit","Ukrainian", 239, 32, 53, 44).
	cake("Tiramisu","Mascarpone cheese","Savoyardi cookies","Italian", 97, 83, 13, 11).
	cake("Cheesecake","Philadelphia Cheese","Biscuit","Greek", 293, 21, 21, 22).
	cake("Esterhazy","Almonds","Biscuit","Hungarian", 468, 70, 35, 41).
	
	checkreal(Variable):-readreal(Variable),!;
	write("Input Error! Please, enter number: "),checkreal(Variable).
	checkrange(Variable):-Variable>min,Variable<max,!;
	write("Range Error! The number is not included in the range of valid values."),nl,write("Try again."),nl,Variable=0.
	check_menu_key(Key):-readint(Key),!;
	write("Input Error! Please, enter number: "),checkreal(Key).
	check_menu_key_range(Key):- Key<=10, Key>=0,!;
	write("Range Error! The number is not included in the range of valid values."),nl,write("Try again."),nl,menu(0).
	
	show_cakes_of_calorific(X,Y) if cake(Name,_,_,_, Calorific_value,_,_,_), Calorific_value<=Y, Calorific_value>=X,
	write(Name, " CV = ", Calorific_value, "."), nl, fail.
	show_cakes_of_calorific(_,_).
	show_cakes_of_protein(X,Y) if cake(Name,_,_,_,_, Protein,_,_), Protein<=Y, Protein>=X,
	write(Name, " P = ", Protein, "."), nl, fail.
	show_cakes_of_protein(_,_).
	show_cakes_of_fats(X,Y) if cake(Name,_,_,_,_,_,Fats,_), Fats<=Y, Fats>=X,
	write(Name, " F = ", Fats, "."), nl, fail.
	show_cakes_of_fats(_,_).
	show_cakes_of_carbs(X,Y) if cake(Name,_,_,_,_,_,_,Carbs), Carbs<=Y, Carbs>=X,
	write(Name, " C = ", Carbs, "."), nl, fail.
	show_cakes_of_carbs(_,_).
	
	print_cake_information(Name, Main_ingredient, Caketype, Cuisine, Calorific_value, Protein, Fats, Carbs):-
    write("Name: "), write(Name), nl,
    write("Main_ingredient: "), write(Main_ingredient), nl,
    write("Caketype: "), write(Caketype), nl,
    write("Cuisine: "), write(Cuisine), nl,
	write("CV: "), write(Calorific_value), nl,
	write("Protein: "), write(Protein), nl,
	write("Fats: "), write(Fats), nl,
    write("Carbs: "), write(Carbs), nl.
	
	print_cakes_by_cuisine(Cuisine):-
    cake(Name,_,_,Cuisine,_,_,_,_),
    write(" -  ", Name), nl, fail, !.
	
	start:-
	makewindow(1, 15, 15, "Cakes", 1, 0, 24, 80),
	menu(0).
	
	menu(0):-
	write("******************************** MENU ********************************"), nl,
    write("1 - dump all database"), nl,
    write("2 - select cakes by cuisine"), nl,
    write("3 - sort cakes by calorific value"), nl,
	write("4 - srot cakes by protein"), nl,
	write("5 - srot cakes by fats"), nl,
	write("6 - srot cakes by carbohydrates"), nl,
    write("7 - insert cake in database"), nl,
    write("8 - remove entry from database"), nl,
	write("9 - save all database into file"), nl,
    write("10 - exit"), nl,nl,
    write("Choose option: "), check_menu_key(MenuPoint), check_menu_key_range(MenuPoint), 
    menu(MenuPoint), !.
	
	menu(1):-
    cake(Name, Main_ingredient, Caketype, Cuisine, Calorific_value, Protein, Fats, Carbs),
    print_cake_information(Name, Main_ingredient, Caketype, Cuisine, Calorific_value, Protein, Fats, Carbs), nl, fail;
    !, menu(0).
	
	menu(2):-
    write("Select cuisine: "), readln(SelectedCuisine),
    print_cakes_by_cuisine(SelectedCuisine),!;
	write("No more cakes were found in this cuisine."), nl, nl, menu(0).
	
	menu(3):-
    write("Print minimum quantity: "), checkreal(Min),checkrange(Min),
	write("Print maximum quantity: "), checkreal(Max),checkrange(Max),
	show_cakes_of_calorific(Min,Max), menu(0).
	
	menu(4):-
    write("Print minimum quantity: "), checkreal(Min),checkrange(Min),
	write("Print maximum quantity: "), checkreal(Max),checkrange(Max),
	show_cakes_of_protein(Min,Max), menu(0).
	
	menu(5):-
    write("Print minimum quantity: "), checkreal(Min),checkrange(Min),
	write("Print maximum quantity: "), checkreal(Max),checkrange(Max),
	show_cakes_of_fats(Min,Max), menu(0).
	
	menu(6):-
    write("Print minimum quantity: "), checkreal(Min),checkrange(Min),
	write("Print maximum quantity: "), checkreal(Max),checkrange(Max),
	show_cakes_of_carbs(Min,Max), menu(0).
	
	menu(7):-
	write("Name: "), readln(Name), cake(Name,_,_,_,_,_,_,_),
	write("Main_ingredient: "), readln(Main_ingredient), 
	write("Caketype: "), readln(Caketype), 
	write("Cuisine: "), readln(Cuisine), 
	write("Calorific_value: "), readreal(Calorific_value),
	write("Protein: "), readreal(Protein),
	write("Fats: "), readreal(Fats),
	write("Carbs"), readreal(Carbs),
	assert(cake(Name, Main_ingredient, Caketype, Cuisine, Calorific_value, Protein, Fats, Carbs)), !, menu(0);
	write("Error: wrong data"), nl, !, menu(0).
	
	menu(8):-
	write("Cake Name: "), readln(Name),
	retract(cake(Name,_,_,_,_,_,_,_)), !, menu(0);
	write("Error: wrong state"), nl, !, menu(0).
	
	menu(9):-
	findall(Name, cake(Name, _, _, _, _,_, _, _), Names), Names = [], !,
	write("***********************"), nl,
	write("******* NO DATA *******"), nl,
	write("***********************"), nl,
	menu(0);
	write("****************************"), nl,
	write("* ENTER FILE NAME: "), readln(Filename),
	openwrite(datafile, Filename), writedevice(datafile),
	print_into_csv,
	closefile(datafile), writedevice(screen),
	write("***********************"), nl,
	write("******** DONE! ********"), nl,
	write("***********************"), nl,
	menu(0).
	
	menu(10):-exit,!.
	
	print_into_csv:-write("Name", ";", "Main_ingredient", ";", "Caketype", ";", "Cuisine", ";", "Calorific_value", ";", "Protein", ";", "Fats", ";", "Carbs"),nl,
	print_database().
	
	print_database():-
	findall(Name, cake(Name, _, _, _, _,_, _, _), Names),
	findall(Main_ingredient, cake(_, Main_ingredient, _, _, _,_, _, _), Main_ingredients),
	findall(Caketype, cake(_, _, Caketype, _, _,_, _, _), Caketypes),
	findall(Cuisine, cake(_, _, _, Cuisine, _,_, _, _), Cuisines),
	findall(Calorific_value, cake(_, _, _, _, Calorific_value,_, _, _), Calorific_valueq),
	findall(Protein, cake(_, _, _, _, _,Protein, _, _), Proteinq),
	findall(Fats, cake(_, _, _, _, _,_, Fats, _), Fatsq),
	findall(Carbs, cake(_, _, _, _, _,_, _, Carbs), Carbsq),
	print_database(Names, Main_ingredients, Caketypes, Cuisines, Calorific_valueq, Proteinq, Fatsq, Carbsq);
	writedevice(screen).
	print_database([], [], [], [], [], [], [], []) :- !.
	print_database([Name|NT],[Main_ingredient|MT], [Caketype|CTT], [Cuisine|CT], [Calorific_value|CVT],
	[Protein|PT], [Fats|FT], [Carbs|CHT]) :-
	write(Name, ";", Main_ingredient, ";", Caketype, ";", Cuisine, ";", Calorific_value, ";", Protein, ";", Fats, ";", Carbs),nl,
	print_database(NT,MT,CTT,CT,CVT,PT,FT,CHT).
	
	dialog_str_read_from_file():-
	write("****************************"), nl,
	write("* ENTER FILE NAME: "),
	readln(Filename), exists(Filename),
	openread(datafile, Filename), readdevice(datafile),
	read_rows(),
	closefile(datafile), readdevice(keyboard),
	write("***********************"), nl,
	write("******** DONE! ********"), nl,
	write("***********************"), nl,
	menu(0);
	write("**************************"), nl,
	write("**** CAKES NOT ADDED! ****"), nl,
	write("**************************"), nl,
	menu(0).
	exists(Filename):-
	existfile(Filename), !;
	write("****************************"), nl,
	write("****** FILE NOT FOUND ******"), nl,
	write("****************************"), nl,
	menu(0), readln(_), !, fail.
	
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
	insert_into_database(Company, Articlenumber, Averageprice,Size),!, read_rows();
	not(eof(datafile)), !,
	write("**********************************"), nl,
	write("********* READING ERROR! *********"), nl,
	write("** REMAINING DATA WAS NOT READ! **"), nl,
	write("****** SOME CAKES ADDED ******"), nl,
	write("**********************************"), nl; !.
	front_string("", "", "") :- !.

GOAL
	start.













