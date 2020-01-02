
:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-use_module(library(random)).



aztec:-
 menu.




menu:-
 repeat,
 write('          ------------------------------          '), nl,
 write('          |  1. Solve a Random Level   |          '), nl,
 write('          |  2. Make a Level           |          '), nl,
 write('          ------------------------------          '), nl,
 read(Input),
 manageInputMenu(Input),
 !.




 manageInputMenu(1):-
  repeat,
  write('          ----------------------------------              '), nl,
  write('          |  How big should the level be?  |              '), nl,
  write('          |       (Tip: 4 to 8 rows)       |              '), nl,
  write('          ----------------------------------              '), nl,
  read(Input),
  number(Input),
  Input > 0,
  !,
  aztec_autogenerator(Input,Table).



manageInputMenu(2):-
 repeat,
 write('          ----------------------------------              '), nl,
 write('          |  How big should the level be?  |              '), nl,
 write('          |       (Tip: 4 to 8 rows)       |              '), nl,
 write('          ----------------------------------              '), nl,
 read(Input),
 number(Input),
 Input > 0,
 !,
 aztec_level_creator(Input,Table).



% ------------------- AUTO GENERATOR ---------------------
aztec_autogenerator(N,Table):-
 length(Table,N),
 createTable(Table,1),
 factorial(N,Size),
 repeat,
 randomNumberFiller(N,Size,Table),
 copy_term(Table,SolvedTable),
 aztec_solve(N,SolvedTable),
 !,
 aztec_play(N,Table,NewTable).


aztec_play(N,Table,NewTable):-
 repeat,
 copy_term(Table,NewTable),
 display_spaces(N), write('  ___'), nl,
 display_aztec(NewTable, N),
 write('     Choose a Row'),nl,
 read(InputRow),
 number(InputRow),
 write('     Choose an Index'),nl,
 read(InputIndex),
 number(InputIndex),
 Row is InputRow - 1,
 factorial(Row, NewRow),
 Index is InputIndex - 1,
 Slot is NewRow + Index,
 write(Slot),nl,
 write('     Choose a Number'),nl,
 read(InputNumber),
 number(InputNumber),
 write(Slot),nl,write(InputNumber),nl,write(NewTable),nl,  
 tableFiller(Slot,InputNumber,NewTable),
 copy_term(NewTable,TestTable),
 aztec_solve(N,TestTable),
 !,
 playMenu(N,Table,NewTable).

playMenu(N,Table,NewTable):-
 write('          ----------------------------------              '), nl,
 write('          |         1. Make a Play         |              '), nl,
 write('          |            2. Undo             |              '), nl,
 write('          ----------------------------------              '), nl,
 read(Input),
 managePlayMenu(Input, N, Table, NewTable).

managePlayMenu(1, N, Table, NewTable):-
 aztec_play(N,NewTable,X).

managePlayMenu(2, N, Table, NewTable):-
 aztec_play(N,Table,X).







% copyTable([],[]).

% copyTable([R1|Rows1],[R2|Rows2]):-
%  copyList(R1,R2),
%  copyTable(Rows1,Rows2).

% copyList([],[]).

% copyList([H|Row1],[H|Row2]):-
%  copyList(Row1,Row2).



randomNumberFiller(N,Size,Table):-
 repeat,
 randset(N,Size,Slots),
 slotsFiller(Slots,Table),
 !.


slotsFiller([],Table).

slotsFiller([S1|Slots],Table):-
 random(1,10,Number),
 tableFiller(S1,Number,Table),
 slotsFiller(Slots,Table).




% numberslotpicker(Size,Slot,Number,Slots):-
%  repeat,
%  RSize is Size+1,
%  random(0,RSize,Slot),
%  write(Slot), nl,
%  slotsCheck(Slots,Slot),
%  random(1,10,Number),
%  !.


% slotsCheck([],_).

% slotsCheck([H|Rest],Slot):-
%  H \== Slot,
%  slotsCheck(Rest,Slot).

% slotsCheck([H|Rest],Slot):-
%  H == Slot,
%  write('false'),
%  false.

% slotsCheck(H,Slot):-
%  H \== Slot.


tableFiller(Slot,Number,[]):-
 Slot == -1.

tableFiller(Slot,Number,[R|RTable]):-
 Slot == -1.

tableFiller(Slot,Number,[R|RTable]):-
 Slot \== -1,
 rowFiller(Slot,NewSlot,Number,R),
 tableFiller(NewSlot,Number,RTable).



rowFiller(Slot,NewSlot,Number,[]):-
 NewSlot is Slot.

rowFiller(Slot,NewSlot,Number,[Index|Row]):-
 Slot > 0,
 Slot2 is Slot - 1,
 rowFiller(Slot2,NewSlot,Number,Row).

rowFiller(Slot,NewSlot,Number,[Index|Row]):-
 Slot == 0,
 NewSlot = -1,
 Index = Number.



factorial(N, R) :- factorial(N, 1, R).
factorial(0, R, R) :- !.
factorial(N, Acc, R) :-
    NewN is N - 1,
    NewAcc is Acc + N,
    factorial(NewN, NewAcc, R).










% aztec_check(N, TestTable):-
%  constrainCheckTable(TestTable, 1).

aztec_solve(N, TestTable):-
%  all_distinct(Cols), 
%  TestTable = ([[2],[1,2],[3,_,_]]),
 append(TestTable, TableList),
%  domain(TableList,1,9),
 TableList ins 1..9,
 constrainTable(TestTable, 1),
 labeling([], TableList).
%  display_spaces(N), write('  ___'), nl,
%  display_aztec(TestTable, N).





aztec_test(N):-
 length(Table,N),
 createTable(Table, 1),
%  all_distinct(Cols), 
%  TestTable = ([[2],[1,1],[3,2,2]]),
 append(Table, TableList),
%  domain(TableList,1,9),
 TableList ins 1..9,
 constrainTable(Table, 1),
 labeling([], TableList),
 display_spaces(N), write('  ___'), nl,
 display_aztec(Table, N),
 false.
%  write(Table).


% ------ CREATION -------
createTable([], _).

createTable([H | RTable], N):-
 length(TableRow, N),
 H = TableRow,
 N1 is N + 1,
 createTable(RTable, N1).


constrainTable([],_).

constrainTable([H | RTable], N):-
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
 separateInto3Variables(H, H2, Row2, N1R1, N1R2, N2R2),
%  write(RTable), nl,
%  write(N1R1), nl,
%  write(N1R2), nl,
%  write(N2R2), nl,
 ((N1R1 #= N1R2 + N2R2) #\/
 (N1R1 #= N1R2 - N2R2) #\/
 (N1R1 #= N2R2 - N1R2) #\/
 (N1R1 #= N1R2 * N2R2) #\/
 (N1R2#>=N2R2 #/\ N1R1 #= N1R2 div N2R2 #/\ rem(N1R2,N2R2) #= 0) #\/
 (N2R2#>=N1R2 #/\ N1R1 #= N2R2 div N1R2 #/\ rem(N2R2,N1R2) #= 0)),
 constrainRow(Row, Row2, N).


separateInto3Variables(H1, H2, [H3 | Row2], N1R1, N1R2, N2R2):-
 N1R1 = H1,
 N1R2 = H2,
 N2R2 = H3.



% ------ CHECK -------

constrainCheckTable([],_).

constrainCheckTable([H | RTable], N):-
 separateRows(H, RTable, R2),
 constrainCheckRow(H, R2, N),
 N1 is N + 1,
 constrainCheckTable(RTable, N1).


separateRows(_,[],_).

separateRows(H, [Row2 | RTable], R2):-
 R2 = Row2.


constrainCheckRow([],_,_).

constrainCheckRow(_,[],_).

constrainRow([H | Row], [H2 | Row2], N):-
 separateInto3VariablesCheck(H, H2, Row2, N1R1, N1R2, N2R2),
%  write(RTable), nl,
%  write(N1R1), nl,
%  write(N1R2), nl,
%  write(N2R2), nl,
 ((N1R1 #= N1R2 + N2R2) #\/
 (N1R1 #= N1R2 - N2R2) #\/
 (N1R1 #= N2R2 - N1R2) #\/
 (N1R1 #= N1R2 * N2R2) #\/
 (N1R2#>=N2R2 #/\ N1R1 #= N1R2 div N2R2 #/\ rem(N1R2,N2R2) #= 0) #\/
 (N2R2#>=N1R2 #/\ N1R1 #= N2R2 div N1R2 #/\ rem(N2R2,N1R2) #= 0)),
 constrainRow(Row, Row2, N).


separateInto3VariablesCheck(H1, H2, [H3 | Row2], N1R1, N1R2, N2R2):-
 domainCheck(H1,1),
 domainCheck(H2,1),
 domainCheck(H3,1),
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


domainCheck(H, N):-
 N > 9,
 false.

domainCheck(H, N):-
 N < 10,
 H \== N,
 N1 is N + 1,
 domainCheck(H, N1).

domainCheck(H, N):-
 N < 10,
 H == N.


display_spaces(N):-
 N =< 0.

display_spaces(N):-
 N > 0,
 write('  '),
 N1 is N - 1,
 display_spaces(N1).

 
