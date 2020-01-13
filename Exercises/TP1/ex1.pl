male(aldo).
male(lincoln).
male(michael).
male(lj).

female(christina).
female(sara).
female(lisa).
female(ella).

parent(aldo,lincoln).
parent(christina,lincoln).
parent(aldo,michael).
parent(christina,michael).
parent(lisa,lj).
parent(lincoln,lj).
parent(michael, ella).
parent(sara, ella).

father(X, Y) :-
    male(X),
    parent(X,Y).

mother(X, Y) :-
    female(X),
    parent(X,Y).

child(X,Y) :-
    parent(Y,X).
