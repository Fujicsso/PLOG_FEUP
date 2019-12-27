:- use_module(library(clpfd)).

aztec :-
    Puzzle = [L1, L2, L3, L4],
    length(L1, 1), domain(L1, 1, 9), all_distinct(L1),
    length(L2, 1), domain(L2, 1, 9), all_distinct(L2),
    length(L3, 1), domain(L3, 1, 9), all_distinct(L3),
    length(L4, 1), domain(L4, 1, 9), all_distinct(L4),
    eval_puzzle(Puzzle),
    element(1, L1, 8),
    element(2, L3, 9),
    element(1, L4, 8), element(4, L4, 2), 
    % get_next_line(Indice, Puzzle, NextLine),


get_next_line(Indice, Puzzle, NextLine) :-
    nth0(Indice, Puzzle, Next),
    NextLine is Next.

eval_puzzle([]).

eval_puzzle([H|T]) :-
    eval_line(H),
    eval_puzzle(T).

eval_line([H|T]) :-
    
