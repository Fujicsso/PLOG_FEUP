

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
 write(Table).


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


% Test: nqueens(4,C).
% C = [2, 4, 1, 3] More? (;)
% C = [3, 1, 4, 2] More? (;)
% no (more) solution.
