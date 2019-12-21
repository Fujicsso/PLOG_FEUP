

:-use_module(library(clpfd)).

aztec_test(N):-
 write('test 1'), nl,
 length(Table,N),
 write('test 2'), nl,
 N1 is 1,
 createTable(Table, N1),
 write('test 3'), nl,
 %constrainTable(Table),
 % all_distinct(Cols), % Redundante mas diminui o tempo de resolução
 write('test 4'), nl,
 write('test 5'), nl,
 TestTable = ([[2],[1,1],[3,2,2]]),
%  labeling([], Table),
 display_spaces(N), write('  ___'), nl,
 display_aztec(Table, N).
%  write(Table).


createTable([], _).

createTable([H | RTable], N):-
 write('test'), nl,
 length(TableRow, N),
 domain(TableRow, 1,9), 
 H = TableRow,
 N1 is N + 1,
 write('test2'), nl,
 createTable(RTable, N1).


constrainTable([]).

constrainTable([H | RTable]):-
 constrainRow(H, RTable, N),
 constrainTable(RTable).




constrainRow2([]).

constrainRow2(H, [Y | V], N):-
 


safe(_,[],_).

safe(X,[Y | T], K) :-
 noattack(X,Y,K),
 K1 is K + 1,
 safe(X,T,K1).


noattack(X,Y,K) :-
 X #\= Y,
 X + K #\= Y,
 X - K #\= Y.



display_aztec([]).

display_aztec([H | TCol], N):-
 display_spaces(N),
 write('_|'), display_aztec_row(H), write('_'), nl,
 N1 is N - 1,
 display_aztec(TCol, N1).




display_aztec_row([]).

display_aztec_row([H | Row]):-
 isSlotFree(H, 1), 
 write('|'),
 display_aztec_row(Row).



isSlotFree(H, N):-
 N > 9,
 write('_ _').

isSlotFree(H, N):-
 N < 10,
 H \== N,
 N1 is N + 1,
 isSlotFree(H, N1).

isSlotFree(H, N):-
 N < 10,
 H == N,
 write('_'), write(H), write('_').



display_spaces(N):-
 N > 0,
 write('  '),
 N1 is N - 1,
 display_spaces(N1).
 
display_spaces(N):-
 N =< 0.

 