DOMAINS
	gorod, strana = symbol

PREDICATES
	situ(gorod, strana)

CLAUSES
	situ(buenosaires,argentina).
	situ(brasilia,brazil).
	situ(pekin,china).
	situ(london,england).
	situ(berlin,germany).
	situ(warszawa,poland).
	situ(moscow,russia).
	situ(petersburg,russia).
	situ(kiev,ykraine).
	situ(ottawa,canada).
	situ(ulaanbaatar,mongolia).
	situ(rabat,morocco).
	situ(seoul,southkorea).
	situ(lima,peru).
	situ(mexicocity,mexico).
	situ(cairo,egypt).
	situ(suva,fiji).
	situ(lusaka,zambia).
	situ(canberra,australia).
	situ(lapaz,bolivia).
	situ(sucre,bolivia).
	
	situ(X, asia):-situ(X, china).
	situ(X, asia):-situ(X, southkorea).
	situ(X, asia):-situ(X, mongolia).
	
	situ(X, europe):-situ(X, germany).
	situ(X, europe):-situ(X, poland).
	situ(X, europe):-situ(X, russia).
	situ(X, europe):-situ(X, ykraine).
	situ(X, europe):-situ(X, england).
	
	situ(X, southamerica):-situ(X, argentina).
	situ(X, southamerica):-situ(X, brazil).
	situ(X, southamerica):-situ(X, peru).
	situ(X, southamerica):-situ(X, bolivia).

	situ(X, northamerica):-situ(X, canada).
	situ(X, northamerica):-situ(X, mexico).
	
	situ(X, africa):-situ(X, morocco).
	situ(X, africa):-situ(X, egypt).
	situ(X, africa):-situ(X, zambia).
	
	situ(X, oceania):-situ(X, fiji).
	
	situ(X, mat_australia):-situ(X, australia).