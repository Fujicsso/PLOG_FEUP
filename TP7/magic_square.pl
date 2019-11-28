
magic_square :-
    V=[A,B,C,
       D,E,F,
       G,H,I],
    all_distinc(V),
    domain(V, 1, 9),
    A+B+C #= S,
    D+E+F #= S,
    G+H+I #= S,
    A,D,G #= S,
    B,E,H #= S,
    C,F,I #= S,
    A,E,I #= S,
    C,E,G #= S,
    labeling([], V),
    write(V).

