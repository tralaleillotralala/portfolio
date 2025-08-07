CONSTANTS
	min = -1e+308
	max = 1e+308

DOMAINS
	name = string
	main_ingredient = string
	caketype = string
	cuisine = string
	calorific_value = real
	protein, fats, carbs = real
	minq, maxq = real

DATABASE -cakes_db
	nondeterm cake(name, main_ingredient, caketype, cuisine, calorific_value, protein, fats, carbs)

PREDICATES
	menu(integer)
	checkreal(real)
	checkrange(real)
	check_menu_key(integer)
	check_menu_key_range(integer)
	nondeterm show_cakes_of_calorific(minq, maxq)
	nondeterm show_cakes_of_protein(minq, maxq)
	nondeterm show_cakes_of_fats(minq, maxq)
	nondeterm show_cakes_of_carbs(minq, maxq)
	nondeterm print_cake_information(name, main_ingredient, caketype, cuisine, calorific_value, protein, fats, carbs)
	nondeterm print_cakes_by_cuisine(cuisine)

CLAUSES
	cake("Gao","Bananas","Puff pastry or cupcake base","Chinese", 428, 6.5, 17, 60).
	cake("Bantuoy","Bananas","Pancake base","Vietnam", 115.4, 5.1, 3.4, 15.8).
	cake("Kue-nagasari","Bananas","Rice flour dough","Indonesian", 184.4, 7.2, 5.1, 34.7).
	cake("Banoffee pie","Bananas","Shortbread dough","English", 468, 78.2, 28.7, 44.6).
	cake("Battenberg cake","Apricot jam","Sponge cake and marzipan glaze","English", 381, 5.5, 13, 61).
	cake("Buccellato","Dried and fresh fruits, nuts","Biscuit","Austrian", 378, 7, 22, 38).
	cake("Waffle cake","Chocolate","Waffle sheets","Sicilian", 497, 6, 31.8, 58.9).
	cake("Garash","Chocolate","Ground walnuts","Bulgarian", 497, 6, 31.8, 58.9).
	cake("Sachertorte","Chocolate","Biscuit","Austrian", 420, 4.1, 19, 58).
	cake("Zuccotto","Ricotta cheese","Biscuit","Italian", 455, 11, 32.5, 23.4).
	cake("Caprese","Chocolate","Nut dough","Italian", 153, 6, 12.4, 23.4).
	cake("Red Velvet cake","Chocolate","Biscuit","American", 117, 12, 5, 12).
	cake("Mazurek","Dried and fresh fruits, nuts","Shortbread dough","Polish", 397, 23, 23, 4).
	cake("Medovik","Sour cream, honey","Honey cakes","Russian", 311.1, 8.3, 4.9, 62.3).
	cake("Napoleon","Cream filling","Puff pastry","Russian", 340, 7.2, 15.7, 43).
	cake("Prague","Chocolate","Biscuit","Russian", 416, 4.8, 24.4, 44.3).
	cake("RigóJancsi","Chocolate","Biscuit","Hungarian", 323, 3.1, 12.5, 53.7).
	cake("Sour cream","Sour cream","Biscuit","Ukrainian", 239, 3.9, 5.9,  44.3).
	cake("Tiramisu","Mascarpone cheese","Savoyardi cookies","Italian", 97.7, 8.4, 1.8, 11.4).
	cake("Cheesecake","Philadelphia Cheese","Biscuit","Greek", 293.3, 2.5, 21.3, 22.1).
	cake("Esterhazy","Almonds","Biscuit","Hungarian", 468, 7, 35.3, 41.4).
	
	checkreal(Variable):-readreal(Variable),!;
	write("Input Error! Please, enter number: "),checkreal(Variable).
	checkrange(Variable):-Variable>min,Variable<max,!;
	write("Range Error! The number is not included in the range of valid values."),nl,write("Try again."),nl,Variable=0.
	check_menu_key(Key):-readint(Key),!;
	write("Input Error! Please, enter number: "),checkreal(Key).
	check_menu_key_range(Key):- Key<10, Key>=0,!;
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
	
	menu(0):-
    %write("1 - dump all db"), nl,
    %write("2 - select cakes by cuisine"), nl,
    %write("3 - sort cakes by CV"), nl,
	%write("4 - srot cakes by P"), nl,
	%write("5 - srot cakes by F"), nl,
	%write("6 - srot cakes by C"), nl,
    %write("7 - insert cake in db"), nl,
    %write("8 - remove entry from db"), nl,
    %write("9 - exit"), nl,
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
	
	menu(9):-!.

GOAL
	menu(0).













