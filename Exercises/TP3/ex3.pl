append1([],L,L).

append1([X|L1],L2,[X|L3]):-
    append1(L1,L2,L3).
