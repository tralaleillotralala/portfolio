Domains
	int=integer
	str=string

Predicates
	nondeterm event(str,int,str)
	nondeterm show_event(int,int)
	nondeterm show_state(str)
	nondeterm show_cent(int)
	nondeterm run_info
	nondeterm povtor(char)
	nondeterm menu(int)

Clauses
	event("Egipet", 30, "Obrazovalos' edinoe gosudarstvo").
	event("Indiya", 27, "Poyavilis' drevnejshie goroda").
	event("Egipet", 27, "Postroena piramida Heopsa").
	event("Greciya", 18, "Poyavilis' pervye gosudartva").
	event("Egipet", 18, "Krupnoe vosstanie bednyakov i rabov").
	event("Kitaj", 18, "Poyavlenie pervyh gosudarstv").
	event("Egipet", 15, "Pravlenie Tutmosa III").
	event("Greciya", 13, "Troyanskaya Vojna").
	event("Greciya", 11, "Vtorzhenie borijskih plemen").
	event("Rim", 8, "Byl osnovan gorod - gosudarstvo Rim").
	event("Greciya", 8, "Provedenie olimpijskih igr").
	event("Rim", 6, "Ustanovlena respublika").
	event("Greciya", 6, "reformy Solona").
	event("Egipet", 6, "persy vzyali Vavilon v Mezhdurech'e i zavoevali Egipet").
	show_event(X,Y) if event(_,Century,Event),Century>=Y,Century<=X,
	write("Sobytie: ",Event,"."),
	nl, fail.
	show_event(_,_).
	show_state(X) if event(State,Century,Event) ,X=State,
	write("Data: ",Century," vek do n.e. " ,"Sobytie: ",Event,"."),
	nl, fail.
	show_state(_).
	show_cent(X) if event(State, Century, Event) ,X=Century,
	write("Gosudarstvo: ",State,". ", "Sobytie: ",Event,"."),
	nl, fail.
	show_cent(_).
	menu(Menu) if Menu=1,
	write("Nazvanie gosudarstva: "),nl, readln(X),show_state(X),nl,write("Eshche vopros?"),readchar(Yes_No), povtor(Yes_No), nl.
	menu(Menu) if Menu=2,
	write("Istoriya Drevnego mira s (vek do n.e.)"),nl,
	readint(X),
	write("Istoriya Drevnego mira do (vek do n.e.)"),nl,
	readint(Y),
	show_event(X,Y), write("Eshche vopros?"),readchar(Yes_No), povtor(Yes_No), nl.
	menu(Menu) if Menu=3,
	write("Vek: "),nl, readint(X),show_cent(X),nl,write("Eshche vopros?"),readchar(Yes_No), povtor(Yes_No), nl.
	povtor('d') if nl, run_info.
	povtor('n') if exit.
	run_info if
	write("Istoriya Drevnego Mira"), nl,
	write("1-Istoriya gosudarstva s drevnosti"),nl,
	write("2-Vekhi istorii"),nl,
	write("3-Sobytie v opredelennom veke"),nl,
	readint(Menu),
	menu(Menu).

Goal
	run_info.
	
	
		s(X) if cake(Name, _, _, Cuisine, _, _, _, _), X=Cuisine,
	write("  - ", Name, "."), nl, fail.
	s(_).
	
	
	
	, nl,
    write("Main_ingredient: "), write(Main_ingredient), nl,
    write("Caketype: "), write(Caketype), nl,
    write("Cuisine: "), write(Cuisine), nl,
	write("CV: "), write(Calorific_value), nl,
	write("Protein: "), write(Protein), nl,
	write("Fats: "), write(Fats), nl,
    write("Carbs: "), write(Carbs), nl
	
	
	cake(Name, Main_ingredient, Caketype, Cuisine, Calorific_value, Protein, Fats, Carbs)
	
	

	list_to_set(d_continents, d_continents, d_continents)
	nondeterm member(d_continent, d_continents)
	nondeterm member(d_state, d_states)
	qsort(d_populations, d_populations)
	divide(d_populations, d_population, d_populations, d_populations)
	append(d_populations, d_populations, d_populations)
	
	print_states(d_states)
	filter_states_by_population(d_states, d_population, d_population, d_states)