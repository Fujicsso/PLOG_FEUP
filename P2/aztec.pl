

:-use_module(library(clpfd)).
:-use_module(library(lists)).

aztec_test(N):-
 length(Table,N),
 createTable(Table, 1),
%  all_distinct(Cols), 
%  TestTable = ([[2],[1,1],[3,2,2]]),
 append(Table, TableList),
 constrainTable(Table, 1),
 write('TEEEESTE'), nl,
 labeling([], TableList),
 display_spaces(N), write('  ___'), nl,
 display_aztec(Table, N).
%  write(Table).


createTable([], _).

createTable([H | RTable], N):-
 length(TableRow, N),
 domain(TableRow, 1,9), 
 H = TableRow,
 N1 is N + 1,
 createTable(RTable, N1).


constrainTable([],_).

constrainTable([H | RTable], N):-
 write('test Pre Constrain Row'), nl,
 constrainRow(H, RTable, N),
 N1 is N + 1,
 constrainTable(RTable, N1).



constrainRow([],_,_).

constrainRow(_,[],_).

constrainRow([H | Row], RTable, N):-
 write('test Pre Sep3Var'), nl,
 write(H), nl,
 write(RTable), nl,
 separateInto3Variables(H, RTable, N1R1, N1R2, N2R2),
 write('test Post Sep3Var'), nl,
%  write(RTable), nl,
%  write(N1R1), nl,
%  write(N1R2), nl,
%  write(N2R2), nl,
 (N1R1 #= N1R2 + N2R2;
 N1R1 #= N1R2 - N2R2;
 N1R1 #= N2R2 - N1R2;
 N1R1 #= N1R2 * N2R2;
 (N1R1 #= N1R2 // N2R2, mod(N1R2,N2R2) #= 0);
 (N1R1 #= N2R2 // N1R2, mod(N2R2,N1R2) #= 0)),
 write('test Pos Constrain Row'), nl,
 constrainRow(Row, RTable, N).



separateInto3Variables(H1, [R2 | Rows], N1R1, N1R2, N2R2):-
 N1R1 = H1,
 separateInto2Variables(R2, N1R1, N1R2, N2R2).


separateInto2Variables([H2 | Row2], N1R1, N1R2, N2R2):-
 N1R2 = H2,
 separateInto1Variables(Row2, N1R1, N1R2, N2R2).


separateInto1Variables([H3 | Row2], N1R1, N1R2, N2R2):-
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

 
