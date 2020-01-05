
:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-use_module(library(random)).

reset_timer :- statistics(walltime,_).	


print_time :-
  statistics(walltime,[_,T]),
  statistics,
	TS is ((T//10)*10)/1000,
	nl, write('Time: '), write(TS), write('s'), nl, nl.



aztec:-
 menu.


test_times :-
  Table = [[5], [_,_], [3,_,2], [_,_,_,_], [1,_,7,_,8]],
  reset_timer,
  aztec_solve(Table),
  print_time.




menu:-
 repeat,
 write('          ------------------------------          '), nl,
 write('          |  1. Solve a Random Level   |          '), nl,
%  write('          |  2. Make a Level           |          '), nl,
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
  manageInputMenu2(Input).




manageInputMenu2(Input):-
 factorial(Input,Size),
 repeat,
 write('          ----------------------------------              '), nl,
 write('          |  How many tips should it have? |              '), nl,
 write('          |  (Tip: same as the level size) |              '), nl,
 write('          |         [0 to '),write(Size),write(']              |              '),nl,
 write('          ----------------------------------              '), nl,
 read(Input2),
 number(Input2),
 Input2 > 0,
 Input2 < Size,
 !,
 aztec_autogenerator(Input,Input2,Table).



% manageInputMenu(2):-
%  repeat,
%  write('          ----------------------------------              '), nl,
%  write('          |  How big should the level be?  |              '), nl,
%  write('          |       (Tip: 4 to 8 rows)       |              '), nl,
%  write('          ----------------------------------              '), nl,
%  read(Input),
%  number(Input),
%  Input > 0,
%  !,
%  aztec_level_creator(Input,Table).



% ------------------- AUTO GENERATOR ---------------------
aztec_autogenerator(N,Tips,Table):-

 length(Table,N),
 write('here'),
 createTable(Table,1),
 factorial(N,Size),
 repeat,
 randomNumberFiller(Tips,Size,Table),
 copy_term(Table,SolvedTable),
 reset_timer(),
 aztec_solve(SolvedTable),
 print_time(),
 !,
 generatedMenu(N,Table,SolvedTable).




generatedMenu(N,Table,SolvedTable):-
 display_spaces(N), write('     ___'), nl,
 display_aztec(Table, N),
 repeat,
 write('          ----------------------------------              '), nl,
 write('          |         1. Make a Play         |              '), nl,
 write('          | 2. Display a Possible Solution |              '), nl,
 write('          ----------------------------------              '), nl,
 read(Input),
 Input > 0,
 Input < 3,
 !,
 manageGeneratedMenu(Input, N, Table, SolvedTable).


manageGeneratedMenu(1, N, Table, SolvedTable):-
 aztec_play(N,Table,NewTable).

manageGeneratedMenu(2, N, Table, SolvedTable):-
  display_spaces(N), write('     ___'), nl,
  display_aztec(SolvedTable, N),
 generatedMenu(N,Table,SolvedTable).





aztec_play(N,Table,NewTable):-
 repeat,
 copy_term(Table,NewTable),
 write('     Choose a Row (1 to '),write(N),write(')'),nl,
 read(InputRow),
 number(InputRow),
 InputRow > 0,
 InputRow =< N,
 write('     Choose an Index (1 to '),write(InputRow),write(')'),nl,
 read(InputIndex),
 number(InputIndex),
 InputIndex > 0,
 InputIndex =< InputRow,
 Row is InputRow - 1,
 factorial(Row, NewRow),
 Index is InputIndex - 1,
 Slot is NewRow + Index,
 write('     Choose a Number (0 to 9)'),nl,
 read(InputNumber),
 number(InputNumber),
 tableFiller(Slot,InputNumber,NewTable),
 copy_term(NewTable,TestTable),
 write('here'),
 aztec_solve(TestTable),
 !,
 playMenu(N,Table,NewTable,TestTable).


playMenu(N,Table,NewTable,TestTable):-
 isGameOver(NewTable),
 write('Congrats! You made it!'),nl,
 read(Input),
 abort.

playMenu(N,Table,NewTable,TestTable):-
 display_spaces(N), write('     ___'), nl,
 display_aztec(NewTable, N),
 repeat,
 write('          ----------------------------------              '), nl,
 write('          |         1. Make a Play         |              '), nl,
 write('          |       2. Undo Last Play        |              '), nl,
 write('          | 3. Display a Possible Solution |              '), nl,
 write('          ----------------------------------              '), nl,
 read(Input),
 Input > 0,
 Input < 4,
 !,
 managePlayMenu(Input, N, Table, NewTable, TestTable).

managePlayMenu(1, N, Table, NewTable, TestTable):-
 aztec_play(N,NewTable,X).

managePlayMenu(2, N, Table, NewTable, TestTable):-
 aztec_play(N,Table,X).

managePlayMenu(3, N, Table, NewTable, TestTable):-
 display_spaces(N), write('     ___'), nl,
 display_aztec(TestTable, N),
 playMenu(N,Table,NewTable,TestTable).




isGameOver([]).

isGameOver([R|Rtable]):-
 rowFull(R),
 isGameOver(Rtable).

rowFull([]).

rowFull([I|Row]):-
 domainCheck(I,1),
 rowFull(Row).


randomNumberFiller(N,Size,Table):-
 repeat,
 randset(N,Size,Slots),
 slotsFiller(N,Slots,Table),
 !.




slotsFiller(0,[],Table).

slotsFiller(N,[],Table).


slotsFiller(N,[S1|Slots],Table):-
 repeat,
 random(1,10,Number),
 S is S1 - 1,
 tableFiller(S,Number,Table),
 copy_term(Table,SolvedTable),
 aztec_solve(SolvedTable),
 !,
 N1 is N-1,
 slotsFiller(N1,Slots,Table).


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



equalIndex(Slot,[],[]):-
 Slot == -1.

equalIndex(Slot,[R1|RTable1],[RS|RTableS]):-
 Slot == -1.

equalIndex(Slot,[R1|RTable1],[RS|RTableS]):-
 Slot \== -1,
 equalIndexRow(Slot,NewSlot,R,RS),
 equalIndex(NewSlot,RTable1,RTableS).


equalIndexRow(Slot,NewSlot,[],[]):-
 NewSlot is Slot.

equalIndexRow(Slot,NewSlot,[Index1|Row1],[IndexS|RowS]):-
 Slot > 0,
 Slot2 is Slot - 1,
 equalIndexRow(Slot2,NewSlot,Row1,RowS).

equalIndexRow(Slot,NewSlot,[Index1|Row1],[IndexS|RowS]):-
 Slot == 0,
 NewSlot = -1,
 Index1 = IndexS.


factorial(N, R) :- factorial(N, 0, R).
factorial(0, R, R) :- !.
factorial(N, Acc, R) :-
    NewN is N - 1,
    NewAcc is Acc + N,
    factorial(NewN, NewAcc, R).


aztec_solve(TestTable):-
 append(TestTable, TableList),
 TableList ins 1..9,
 constrainTable(TestTable, 1),
 labeling([bisect], TableList).
%  statistics.





aztec_test(N):-
 length(Table,N),
 createTable(Table, 1),
 append(Table, TableList),
 TableList ins 1..9,
 constrainTable(Table, 1),
 labeling([], TableList),
 display_spaces(N), write('       ___'), nl,
 display_aztec(Table, N),
 false.


% ------ CREATION -------
createTable([], _).

createTable([H | RTable], N):-
 length(TableRow, N),
 H = TableRow,
 N1 is N + 1,
 createTable(RTable, N1).


constrainTable([],_).

constrainTable([H | RTable], N):-
 all_distinct(H),
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
 display_spaces(N), write('   '),
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

 
