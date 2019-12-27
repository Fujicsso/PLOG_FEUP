:- use_module(library(clpfd)).


cp :-
    length(L, 10), domain(L,1,10), all_distinct(Order),
    element(10, L, 6),
    dist(L,D),
    labeling([maximize(D)], L).

dist([_], 0).

dist([A,B|T], D) :-
    dist([B|T], D2),
    D #= D2 + abs(B-A).

