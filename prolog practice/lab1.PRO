PREDICATES
male(symbol)
female(symbol)
parent(symbol,symbol)
married(symbol,symbol)
wife(symbol,symbol)
husband(symbol,symbol)
father(symbol,symbol)
mother(symbol,symbol)
son(symbol,symbol)
daughter(symbol,symbol)
brother(symbol,symbol)
brotherbymom(symbol,symbol)
brotherbydad(symbol,symbol)
sister(symbol,symbol)
sisterbymom(symbol,symbol)
sisterbydad(symbol,symbol)
uncle(symbol,symbol)
aunt(symbol,symbol)
grandmother(symbol,symbol)
grandfather(symbol,symbol)
grandson(symbol,symbol)
granddaughter(symbol,symbol)
motherinlaw(symbol,symbol)
fatherinlaw(symbol,symbol)
daughterinlaw(symbol,symbol)
soninlaw(symbol,symbol)
sisterinlaw(symbol,symbol)
brotherinlaw(symbol,symbol)
nephew(symbol,symbol)
checkmarried(symbol,symbol)

CLAUSES
checkmarried(X,Y):-married(Y,X);married(X,Y).
wife(X,Y):-checkmarried(X,Y),female(X).
husband(X,Y):-checkmarried(X,Y),male(X).
father(X,Y):-parent(X,Y),male(X).
mother(X,Y):-parent(X,Y),female(X).
son(X,Y):-parent(Y,X),male(X).
daughter(X,Y):-parent(Y,X),female(X).
brotherbydad(X,Y):-father(Z,X),father(Z,Y),male(X), X<>Y.
brotherbymom(X,Y):-mother(Z,X),mother(Z,Y),male(X), X<>Y.
brother(X,Y):-
brotherbydad(X,Y);
brotherbymom(X,Y),not(brotherbydad(X,Y)).
sisterbydad(X,Y):-father(Z,X),father(Z,Y),female(X), X<>Y.
sisterbymom(X,Y):-mother(Z,X),mother(Z,Y),female(X), X<>Y.
sister(X,Y):-
sisterbydad(X,Y);
sisterbymom(X,Y),not(sisterbydad(X,Y)).
uncle(X,Y):-parent(Z,Y),brother(X,Z).
aunt(X,Y):-parent(Z,Y),sister(X,Z).
grandmother(X,Y):-parent(Z,Y),parent(X,Z),female(X).
grandfather(X,Y):-parent(Z,Y),parent(X,Z),male(X).
grandson(X,Y):-parent(Z,X),parent(Y,Z),male(X).
granddaughter(X,Y):-parent(Z,X),parent(Y,Z),female(X).
motherinlaw(X,Y):-checkmarried(Y,Z),mother(X,Z).
fatherinlaw(X,Y):-checkmarried(Y,Z),father(X,Z).
daughterinlaw(X,Y):-wife(X,Z),parent(Y,Z).
soninlaw(X,Y):-husband(X,Z),parent(Y,Z).
sisterinlaw(X,Y):-
sister(X,Z),checkmarried(Y,Z);
wife(X,Z),brother(Z,Y).
brotherinlaw(X,Y):-
brother(X,Z),checkmarried(Y,Z);
husband(X,Z),sister(Z,Y).
nephew(X,Y):-
aunt(Y,X);
uncle(Y,X).

male(roman).
male(artemiy).
male(egor).
male(oleg).
male(vsevolod).
female(ella).
female(polina).
female(julia).
female(liza).
female(olga).

parent(roman, egor).
parent(roman, liza).
parent(artemiy, oleg).
parent(artemiy, julia).
parent(egor, vsevolod).
parent(egor, olga).
parent(ella, egor).
parent(ella, liza).
parent(polina, oleg).
parent(polina, julia).
parent(julia, vsevolod).
parent(julia, olga).

married(roman, ella).
married(artemiy, polina).
married(egor, julia).