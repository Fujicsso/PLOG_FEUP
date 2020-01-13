
:- use_module(library(clpfd)).

elet1(16, 2).
elet2(6,9).
elet3(13,3).
elet4(7,7).
elet5(5,10).
elet6(18,1).
elet7(4,11).

cost([2,9,3,7,10,1,11]).
duration([16,6,13,7,5,18,1,11]).

% eletrodomesticos:-
eletrodomesticos:-
    schedule(Ss, End),
    write(End).

schedule(Ss, End) :-
    Ss = [S1,S2,S3,S4,S5,S6,S7],
    Es = [E1,E2,E3,E4,E5,E6,E7],
    Tasks = [
        task(S1, 16, E1, 2, 1),
        task(S2, 6, E2, 9, 2),
        task(S3, 13, E3, 3, 3),
        task(S4, 7, E4, 7, 4),
        task(S5, 5, E5, 10, 5),
        task(S6, 18, E6, 1, 6),
        task(S7, 4, E7, 11, 7)
    ],
    domain(Ss, 1, 30),
    maximum(End, Es),
    cumulative(Tasks, [limit(13)]),
    labeling([minimize(End)], Ss).



carteiro:-
    schedule2(D, L),
    write(L),
    nl,
    write(D).


schedule2(D, L) :-
    length(L,10), %ordem de visita
    domain(L,1,10),
    all_distinct(L),
    element(10,L,6),
    dist(L,D),
    labeling([maximize(D)], L).

dist([_], 0).

dist([A,B|T], D):-
    dist([B|T], D2),
    D #= D2 + abs(B-A).



domestico:-
    schedule3.

schedule3:-
    maria([4.5,7.8,3.6,2.9]),
    joao([4.9,7.2,4.3,3.1]),

    length(maria, LMaria),
    length(TMaria, LMaria),
    length(TJoao, LMaria),
    domain(TMaria, 1, LMaria),
    doamin(TJoao, 1, LMaria),

    length(TarefasMaria, 2),
    length(TarefasJoao, 2),

    dist2(TarefasMaria, TMaria, TM),
    dist2(TarefasJoao, TJoao, TJ),

    Tempo #= TM + TJ,
    append(TMaria, TJoao, Tarefas),
    all_distinct(Tarefas),
    labeling([minimize(Tempo)], Tarefas).



dist2([_], [MA, MB|MT], 0).

dist2([TA, TB|TT], [MA, MB|MT], TM):-
    dist2([TB|TT], [MB|MT], TM2),
    TM #= MA + TM2.