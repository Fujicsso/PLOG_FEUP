fatorial(0,1).

fatorial(I,O) :-
    I > 0,
    N is I-1,
    fatorial(N,O1),
    O is I*O1.
