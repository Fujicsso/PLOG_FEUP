
:-use_module(library(clpfd)).
:-use_module(library(lists)).



aztec_test_solve(N, TestTable):-
%  all_distinct(Cols), 
%  TestTable = ([[2],[1,2],[3,_,_]]),
 append(TestTable, TableList),
 domain(TableList,1,9),
%  TableList ins 1..9,
 constrainTable(TestTable, 1),
 write('TEEEESTE'), nl,
 labeling([], TableList),
 display_spaces(N), write('  ___'), nl,
 display_aztec(TestTable, N),
 false.





aztec_test(N):-
 length(Table,N),
 createTable(Table, 1),
%  all_distinct(Cols), 
%  TestTable = ([[2],[1,1],[3,2,2]]),
 append(Table, TableList),
 domain(TableList,1,9),
%  TableList ins 1..9,
 constrainTable(Table, 1),
 write('TEEEESTE'), nl,
 labeling([], TableList),
 display_spaces(N), write('  ___'), nl,
 display_aztec(Table, N),
 false.
%  write(Table).


createTable([], _).

createTable([H | RTable], N):-
 length(TableRow, N),
 H = TableRow,
 N1 is N + 1,
 createTable(RTable, N1).


constrainTable([],_).

constrainTable([H | RTable], N):-
 write('test Pre Constrain Row'), nl,
 separateRows(H, RTable, R2),
 constrainRow(H, R2, N),
 N1 is N + 1,
 constrainTable(RTable, N1).



separateRows(_,[],_).

separateRows(H, [Row2 | RTable], R2):-
 R2 = Row2.




constrainRow([],_,_).

constrainRow(_,[],_).

constrainRow([H | Row], [H2 | Row2], N):-
 write('test Pre Sep3Var'), nl,
 separateInto3Variables(H, H2, Row2, N1R1, N1R2, N2R2),
 write('test Post Sep3Var'), nl,
%  write(RTable), nl,
%  write(N1R1), nl,
%  write(N1R2), nl,
%  write(N2R2), nl,
 write('test Conditions'), nl,
 ((N1R1 #= N1R2 + N2R2) #\/
 (N1R1 #= N1R2 - N2R2) #\/
 (N1R1 #= N2R2 - N1R2) #\/
 (N1R1 #= N1R2 * N2R2) #\/
 (N1R2#>=N2R2 #/\ N1R1 #= N1R2 div N2R2 #/\ rem(N1R2,N2R2) #= 0) #\/
 (N2R2#>=N1R2 #/\ N1R1 #= N2R2 div N1R2 #/\ rem(N2R2,N1R2) #= 0)),
 write('test Pos Constrain Row'), nl,
 constrainRow(Row, Row2, N).




separateInto3Variables(H1, H2, [H3 | Row2], N1R1, N1R2, N2R2):-
 N1R1 = H1,
 N1R2 = H2,
 N2R2 = H3.



safe(_,[],_).

safe(X,[Y | T], K):-
 noattack(X,Y,K),
 K1 is K + 1,
 safe(X,T,K1).


noattack(X,Y,K) :-
 X #\= Y,
 X + K #\= Y,
 X - K #\= Y.



display_aztec([],_).

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
 N =< 0.

display_spaces(N):-
 N > 0,
 write('  '),
 N1 is N - 1,
 display_spaces(N1).

 
