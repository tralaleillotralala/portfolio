PREDICATES
	parent(String, String)
	male(String)
	female(String)
	brother(String,String)
	print
CLAUSES
	parent("Tom","Jake").
	parent("Janna","Jake").
	parent("Tom","Tim").
	parent("Janna","Tim").
	male("Tom").
	male("Tim").
	male("Jake").
	female("Janna").
	
	brother(X,Y):-parent(Z,X),parent(Z,Y),male(X),X<>Y.
	print:-brother(X,Y),write(X,"- brat -",Y),nl,fail.
	