Domains
Znak = x;o;h
Subject = computer;human;frendship
Hod = Integer     % это номер клетки
Tab = start;tab(Znak,Znak,Znak,Znak,Znak,Znak,Znak,Znak,Znak)
Prognoz = Real
ListReal = Real*

Database - temp
konez_igra temporary(Tab,Znak,Hod,Tab) 
znak(Subject,Znak)

Database - knowledge
rule(Tab,Hod,Prognoz)

Predicates
igra voprosi(Subject) igrat(Subject) try_consult 
voprosi1(Char,Subject) voprosi2(Char,Subject) 
nondeterm repeat 
nondeterm repeat1
poisk_i_zapis_hoda(Hod,Tab) vvod_i_zapis_hoda_human(Hod,Tab)
pokaz_hoda(Znak,Hod) exist_end(Tab)
poisk_v_db(Tab,Znak,Hod,Tab) 
nondeterm vibor_hod(Tab,Znak,Hod,Tab)
grabli(Tab,Hod) try_hoda_human(Tab,Znak,Hod,Tab) 
max_prognoz(ListReal,Real,Real)
kletka my_unif(Znak,Znak)
zapis_igra(Znak) mat(Znak,Tab) netupik(Tab) pozdravlenie(Subject)
gomeostat_plus(Tab,Hod) gomeostat_minus(Tab,Hod) gomeostat_zero(Tab,Hod)
refresh_all_synonim(Tab,Hod,Prognoz)
refresh_synonim90(Tab,Hod,Prognoz,Tab,Hod)
refresh_synonim_symetry(Tab,Hod,Prognoz,Tab,Hod)
create_all_synonim(Tab,Hod,Prognoz)
create_synonim90(Tab,Hod,Prognoz,Tab,Hod)
create_synonim_symetry(Tab,Hod,Prognoz,Tab,Hod)
povorot90tab(Tab,Tab) povorot90pnt(Hod,Hod)
symetry_tab(Tab,Tab) symetry_pnt(Hod,Hod)


Goal
igra.

Clauses
repeat1:-konez_igra,!,fail.
repeat1.
repeat1:-repeat1.
repeat.
repeat:-repeat.

/*********** Начальные установки и вопросы ************/

igra:-repeat,voprosi(Perv),
    asserta(temporary(start,h,0,tab(h,h,h,h,h,h,h,h,h))),
    asserta(znak(frendship,h)),try_consult,kletka,
    repeat1,igrat(Perv),fail.
try_consult:-existfile("baza.rul"),consult("baza.rul",knowledge),!.
try_consult:-!.
voprosi(Perv):-clearwindow,retractall(_,temp),
    write("Поиграем? (y/n):"),readchar(X),
    write(X),voprosi1(X,Perv).
voprosi1('Y',Perv):-nl,
    write("Кто первый ходит? (комп-0/человек-1):"),
    readchar(X),write(X),voprosi2(X,Perv),!.
voprosi1('y',Perv):-nl,
    write("Кто первый ходит? (комп-0/человек-1):"),
    readchar(X),write(X),voprosi2(X,Perv),!.
voprosi1(_,human):-nl,write("До свидания..."),readchar(_),exit.
voprosi2('0',computer):-nl,write("Первым хожу я."),nl,
    write("Ваши ходы отображаются ноликом, мои - крестиком."),
    asserta(znak(computer,x)),asserta(znak(human,o)).
voprosi2('1',human):-nl,write("Первым ходите Вы."),nl,
    write("Ваши ходы отображаются крестиком, мои - ноликом."),
    asserta(znak(computer,o)),asserta(znak(human,x)).

/*********** Главная рекурсия игры ***********/

igrat(computer):-
    poisk_i_zapis_hoda(Hod,Tab),znak(computer,Z),!,
    pokaz_hoda(Z,Hod),exist_end(Tab),
    vvod_i_zapis_hoda_human(Hod1,Tab1),znak(human,Z1),!,
    pokaz_hoda(Z1,Hod1),exist_end(Tab1).
igrat(human):-
    vvod_i_zapis_hoda_human(Hod,Tab),znak(human,Z),!,
    pokaz_hoda(Z,Hod),exist_end(Tab),
    poisk_i_zapis_hoda(Hod1,Tab1),znak(computer,Z1),!,
    pokaz_hoda(Z1,Hod1),exist_end(Tab1).

/************* Отображения таблицы *************/

kletka:-cursor(12,20),write(" Ваш ход: "),
    cursor(14,20),write("----T---T---¬"),
    cursor(15,20),write("¦   ¦   ¦   ¦"),
    cursor(16,20),write("+---+---+---+"),
    cursor(17,20),write("¦   ¦   ¦   ¦"),
    cursor(18,20),write("+---+---+---+"),
    cursor(19,20),write("¦   ¦   ¦   ¦"),
    cursor(20,20),write("L---+---+----").
pokaz_hoda(Z,1):-cursor(15,22),write(Z),!.
pokaz_hoda(Z,2):-cursor(15,26),write(Z),!.
pokaz_hoda(Z,3):-cursor(15,30),write(Z),!.
pokaz_hoda(Z,4):-cursor(17,22),write(Z),!.
pokaz_hoda(Z,5):-cursor(17,26),write(Z),!.
pokaz_hoda(Z,6):-cursor(17,30),write(Z),!.
pokaz_hoda(Z,7):-cursor(19,22),write(Z),!.
pokaz_hoda(Z,8):-cursor(19,26),write(Z),!.
pokaz_hoda(Z,9):-cursor(19,30),write(Z),!.

/************** Действия компьютера *************/

poisk_i_zapis_hoda(Hod,Tab1):-temporary(_,_,_,Tab),!,znak(computer,Znak),
    poisk_v_db(Tab,Znak,Hod,Tab1),asserta(temporary(Tab,Znak,Hod,Tab1)),!.

poisk_v_db(Tab,Znak,Hod,Tab1):-        %поиск наилучшего или ничейного хода
    findall(Prognoz,rule(Tab,_,Prognoz),ListPrognoz),
    max_prognoz(ListPrognoz,-1.0,Max),Max>=0.0,
    rule(Tab,Hod,Max),vibor_hod(Tab,Znak,Hod,Tab1),!.
poisk_v_db(Tab,Znak,Hod,Tab1):-        %не наступать на грабли
    vibor_hod(Tab,Znak,Hod,Tab1),not(grabli(Tab,Hod)),!.
poisk_v_db(Tab,Znak,Hod,Tab1):-        %выбрать наименьшие грабли 
    findall(Prognoz,rule(Tab,_,Prognoz),ListPrognoz),
    max_prognoz(ListPrognoz,-1000.0,Max),
    rule(Tab,Hod,Max),vibor_hod(Tab,Znak,Hod,Tab1),!.

max_prognoz([],Max,Max):-!.
max_prognoz([P|L],Prognoz,Max):-P>=Prognoz,!,max_prognoz(L,P,Max).
max_prognoz([_|L],Prognoz,Max):-!,max_prognoz(L,Prognoz,Max).

grabli(Tab,Hod):-rule(Tab,Hod,Prognoz),Prognoz<0.0,!.    
    
% выбор хода по приоритету: центр -> углы -> остальные клетки
vibor_hod(tab(Q,W,E,R,h,Y,U,I,O),Znak,5,tab(Q,W,E,R,Znak,Y,U,I,O)).
vibor_hod(tab(h,W,E,R,T,Y,U,I,O),Znak,1,tab(Znak,W,E,R,T,Y,U,I,O)).
vibor_hod(tab(Q,W,h,R,T,Y,U,I,O),Znak,3,tab(Q,W,Znak,R,T,Y,U,I,O)).
vibor_hod(tab(Q,W,E,R,T,Y,h,I,O),Znak,7,tab(Q,W,E,R,T,Y,Znak,I,O)).
vibor_hod(tab(Q,W,E,R,T,Y,U,I,h),Znak,9,tab(Q,W,E,R,T,Y,U,I,Znak)).
vibor_hod(tab(Q,h,E,R,T,Y,U,I,O),Znak,2,tab(Q,Znak,E,R,T,Y,U,I,O)).
vibor_hod(tab(Q,W,E,h,T,Y,U,I,O),Znak,4,tab(Q,W,E,Znak,T,Y,U,I,O)).
vibor_hod(tab(Q,W,E,R,T,h,U,I,O),Znak,6,tab(Q,W,E,R,T,Znak,U,I,O)).
vibor_hod(tab(Q,W,E,R,T,Y,U,h,O),Znak,8,tab(Q,W,E,R,T,Y,U,Znak,O)).

/************************ Действия человека ***********************/

vvod_i_zapis_hoda_human(Hod,Tab1):-
    cursor(12,30),readln(Str),str_int(Str,Hod),
    znak(human,Znak),temporary(_,_,_,Tab),try_hoda_human(Tab,Znak,Hod,Tab1),
    asserta(temporary(Tab,Znak,Hod,Tab1)),
    cursor(12,30),write("                  "),!.

try_hoda_human(Tab,Znak,Hod,Tab1):-vibor_hod(Tab,Znak,Hod,Tab1),!.

/************************ Гомеостат ***************************/
/*  + закончить игру если мат уже не возможен или поставлен,  */
/*  + сохранить все варианты сюжетов игры,              */
/**************************************************************/

exist_end(Tab):-mat(Who,Tab),zapis_igra(Who),asserta(konez_igra),!,fail.
exist_end(Tab):-not(netupik(Tab)),zapis_igra(h),asserta(konez_igra),!,fail.
exist_end(_):-!.

zapis_igra(x):-temporary(Tab,x,Hod,Tab1),retract(temporary(Tab,x,Hod,Tab1)),
    gomeostat_plus(Tab,Hod),!,zapis_igra(x).
zapis_igra(x):-temporary(Tab,o,Hod,Tab1),retract(temporary(Tab,o,Hod,Tab1)),
    gomeostat_minus(Tab,Hod),!,zapis_igra(x).
zapis_igra(o):-temporary(Tab,o,Hod,Tab1),retract(temporary(Tab,o,Hod,Tab1)),
    gomeostat_plus(Tab,Hod),!,zapis_igra(o).
zapis_igra(o):-temporary(Tab,x,Hod,Tab1),retract(temporary(Tab,x,Hod,Tab1)),
    gomeostat_minus(Tab,Hod),!,zapis_igra(o).
zapis_igra(h):-temporary(Tab,x,Hod,Tab1),retract(temporary(Tab,x,Hod,Tab1)),
    gomeostat_zero(Tab,Hod),!,zapis_igra(h).
zapis_igra(h):-temporary(Tab,o,Hod,Tab1),retract(temporary(Tab,o,Hod,Tab1)),
    gomeostat_plus(Tab,Hod),!,zapis_igra(h).
zapis_igra(Who):-temporary(start,Z,H,T),retract(temporary(start,Z,H,T)),
    save("baza.rul",knowledge),retractall(_,knowledge),
    znak(Subject,Who),!,pozdravlenie(Subject).

gomeostat_plus(Tab,Hod):-rule(Tab,Hod,Prognoz),!,Prognoz1=Prognoz+0.1,
    retract(rule(Tab,Hod,Prognoz)),asserta(rule(Tab,Hod,Prognoz1)),
    refresh_all_synonim(Tab,Hod,Prognoz1),!.
gomeostat_plus(Tab,Hod):-create_all_synonim(Tab,Hod,0.1).
gomeostat_minus(Tab,Hod):-rule(Tab,Hod,Prognoz),!,Prognoz1=Prognoz-0.1,
    retract(rule(Tab,Hod,Prognoz)),asserta(rule(Tab,Hod,Prognoz1)),
    refresh_all_synonim(Tab,Hod,Prognoz1),!.
gomeostat_minus(Tab,Hod):-create_all_synonim(Tab,Hod,-0.1).
gomeostat_zero(Tab,Hod):-rule(Tab,Hod,Prognoz),!,Prognoz1=Prognoz+0.01,
    retract(rule(Tab,Hod,Prognoz)),asserta(rule(Tab,Hod,Prognoz1)),
    refresh_all_synonim(Tab,Hod,Prognoz1),!.
gomeostat_zero(Tab,Hod):-create_all_synonim(Tab,Hod,0.0).

refresh_all_synonim(Tab,Hod,Prognoz):-
    refresh_synonim90(Tab,Hod,Prognoz,Tab1,Hod1),
    refresh_synonim90(Tab1,Hod1,Prognoz,Tab2,Hod2),
    refresh_synonim90(Tab2,Hod2,Prognoz,_,_),
    refresh_synonim_symetry(Tab,Hod,Prognoz,Tab4,Hod4),
    refresh_synonim90(Tab4,Hod4,Prognoz,Tab5,Hod5),
    refresh_synonim90(Tab5,Hod5,Prognoz,Tab6,Hod6),
    refresh_synonim90(Tab6,Hod6,Prognoz,_,_),!.
refresh_all_synonim(_,_,_):-!.

refresh_synonim90(Tab,Hod,Prognoz,Tab1,Hod1):-
    povorot90tab(Tab,Tab1),povorot90pnt(Hod,Hod1),
    rule(Tab1,Hod1,P1),retract(rule(Tab1,Hod1,P1)),!,
    asserta(rule(Tab1,Hod1,Prognoz)),!.
refresh_synonim_symetry(Tab,Hod,Prognoz,Tab1,Hod1):-
    symetry_tab(Tab,Tab1),symetry_pnt(Hod,Hod1),
    rule(Tab1,Hod1,P1),retract(rule(Tab1,Hod1,P1)),!,
    asserta(rule(Tab1,Hod1,Prognoz)),!.

create_all_synonim(Tab,Hod,Prognoz):-
    asserta(rule(Tab,Hod,Prognoz)),
    create_synonim90(Tab,Hod,Prognoz,Tab1,Hod1),
    create_synonim90(Tab1,Hod1,Prognoz,Tab2,Hod2),
    create_synonim90(Tab2,Hod2,Prognoz,_,_),
    create_synonim_symetry(Tab,Hod,Prognoz,Tab4,Hod4),
    create_synonim90(Tab4,Hod4,Prognoz,Tab5,Hod5),
    create_synonim90(Tab5,Hod5,Prognoz,Tab6,Hod6),
    create_synonim90(Tab6,Hod6,Prognoz,_,_),!.
create_all_synonim(_,_,_):-!.

create_synonim90(Tab,Hod,Prognoz,Tab1,Hod1):-
    povorot90tab(Tab,Tab1),povorot90pnt(Hod,Hod1),
    not(rule(Tab1,Hod1,Prognoz)),
    asserta(rule(Tab1,Hod1,Prognoz)),!.
create_synonim_symetry(Tab,Hod,Prognoz,Tab1,Hod1):-
    symetry_tab(Tab,Tab1),symetry_pnt(Hod,Hod1),
    not(rule(Tab1,Hod1,Prognoz)),
    asserta(rule(Tab1,Hod1,Prognoz)),!.

povorot90tab(tab(Q,W,E,R,T,Y,U,I,O),tab(E,Y,O,W,T,I,Q,R,U)).
povorot90pnt(3,1):-!. povorot90pnt(6,2):-!. povorot90pnt(9,3):-!.
povorot90pnt(2,4):-!. povorot90pnt(5,5):-!. povorot90pnt(8,6):-!.
povorot90pnt(1,7):-!. povorot90pnt(4,8):-!. povorot90pnt(7,9):-!.

symetry_tab(tab(Q,W,E,R,T,Y,U,I,O),tab(E,W,Q,Y,T,R,O,I,U)).
symetry_pnt(1,3):-!. symetry_pnt(2,2):-!. symetry_pnt(3,1):-!.
symetry_pnt(4,6):-!. symetry_pnt(5,5):-!. symetry_pnt(6,4):-!.
symetry_pnt(7,9):-!. symetry_pnt(8,8):-!. symetry_pnt(9,7):-!.

netupik(tab(Q,W,E,_,_,_,_,_,_)):-not(my_unif(Q,x)),not(my_unif(W,x)),not(my_unif(E,x)),!.
netupik(tab(Q,W,E,_,_,_,_,_,_)):-not(my_unif(Q,o)),not(my_unif(W,o)),not(my_unif(E,o)),!.
netupik(tab(_,_,_,Q,W,E,_,_,_)):-not(my_unif(Q,x)),not(my_unif(W,x)),not(my_unif(E,x)),!.
netupik(tab(_,_,_,Q,W,E,_,_,_)):-not(my_unif(Q,o)),not(my_unif(W,o)),not(my_unif(E,o)),!.
netupik(tab(_,_,_,_,_,_,Q,W,E)):-not(my_unif(Q,x)),not(my_unif(W,x)),not(my_unif(E,x)),!.
netupik(tab(_,_,_,_,_,_,Q,W,E)):-not(my_unif(Q,o)),not(my_unif(W,o)),not(my_unif(E,o)),!.
netupik(tab(Q,_,_,_,W,_,_,_,E)):-not(my_unif(Q,x)),not(my_unif(W,x)),not(my_unif(E,x)),!.
netupik(tab(Q,_,_,_,W,_,_,_,E)):-not(my_unif(Q,o)),not(my_unif(W,o)),not(my_unif(E,o)),!.
netupik(tab(_,_,Q,_,W,_,E,_,_)):-not(my_unif(Q,x)),not(my_unif(W,x)),not(my_unif(E,x)),!.
netupik(tab(_,_,Q,_,W,_,E,_,_)):-not(my_unif(Q,o)),not(my_unif(W,o)),not(my_unif(E,o)),!.
netupik(tab(Q,_,_,W,_,_,E,_,_)):-not(my_unif(Q,x)),not(my_unif(W,x)),not(my_unif(E,x)),!.
netupik(tab(Q,_,_,W,_,_,E,_,_)):-not(my_unif(Q,o)),not(my_unif(W,o)),not(my_unif(E,o)),!.
netupik(tab(_,Q,_,_,W,_,_,E,_)):-not(my_unif(Q,x)),not(my_unif(W,x)),not(my_unif(E,x)),!.
netupik(tab(_,Q,_,_,W,_,_,E,_)):-not(my_unif(Q,o)),not(my_unif(W,o)),not(my_unif(E,o)),!.
netupik(tab(_,_,Q,_,_,W,_,_,E)):-not(my_unif(Q,x)),not(my_unif(W,x)),not(my_unif(E,x)),!.
netupik(tab(_,_,Q,_,_,W,_,_,E)):-not(my_unif(Q,o)),not(my_unif(W,o)),not(my_unif(E,o)),!.

mat(Q,tab(Q,Q,Q,_,_,_,_,_,_)):-not(my_unif(Q,h)),!.
mat(Q,tab(_,_,_,Q,Q,Q,_,_,_)):-not(my_unif(Q,h)),!.
mat(Q,tab(_,_,_,_,_,_,Q,Q,Q)):-not(my_unif(Q,h)),!.
mat(Q,tab(Q,_,_,_,Q,_,_,_,Q)):-not(my_unif(Q,h)),!.
mat(Q,tab(_,_,Q,_,Q,_,Q,_,_)):-not(my_unif(Q,h)),!.
mat(Q,tab(Q,_,_,Q,_,_,Q,_,_)):-not(my_unif(Q,h)),!.
mat(Q,tab(_,Q,_,_,Q,_,_,Q,_)):-not(my_unif(Q,h)),!.
mat(Q,tab(_,_,Q,_,_,Q,_,_,Q)):-not(my_unif(Q,h)),!.

my_unif(X,X):-!.

pozdravlenie(human):-cursor(12,20),write("Выиграл человек."),readchar(_),!.
pozdravlenie(computer):-cursor(12,20),write("Выиграл компьютер!."),readchar(_),!.
pozdravlenie(frendship):-cursor(12,20),write("Ничья.        "),readchar(_),!.