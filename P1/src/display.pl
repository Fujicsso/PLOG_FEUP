

startGameDisplay :-
    lastBoard(Board),
    clearTheConsole,
    display_game(Board, Player).

testGame :-
    initialBoard(Board),
    displayGameName, display_game(Board, Player).


initialBoard(
    [
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, black, black, black, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, white, white, white, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty]
    ]
    ).

initialBoard2(
    [
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, black, empty, black, empty, black, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, white, empty, white, empty, white, empty],
        [empty, empty, empty, empty, empty, empty, empty]
    ]
    ).

initialBoard3(
    [
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, black, empty, empty, empty],
        [empty, empty, black, empty, black, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, white, empty, white, empty, empty],
        [empty, empty, empty, white, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty]
    ]
    ).

initialBoard4(
    [
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, black, empty, black, empty, empty],
        [empty, empty, empty, black, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, white, empty, empty, empty],
        [empty, empty, white, empty, white, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty]
    ]
    ).

midBoard(
    [
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, black, black, white, white, empty],
        [empty, empty, black, white, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty]
    ]
    ).

lastBoard(
    [
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, empty, empty, empty],
        [empty, empty, empty, empty, black, white, empty],
        [empty, empty, black, empty, white, white, black],
        [empty, empty, empty, empty, empty, empty, empty]
    ]
    ).


cell(white, C) :-
    C = '0'.
cell(black, C) :-
    C = 'X'.
cell(empty, C) :-
    C = ' '.

% ------------- PRINT GAME NAME ---------------
displayGameName :-
    nl,
    write('         / $$    $$                | $$                          '), nl,  
    write('         | $$$ | $$                | $$                          '), nl,
    write('         | $$$$| $$  $$  / $$   $$$$$$$ / $$$$$$   / $$$$$$      '), nl,
    write('         | $$ $$ $$| $$  | $$ |$$__  $$ |$$__  $$ |$$__  $$      '), nl,
    write('         | $$  $$$$| $$  | $$| $$  | $$| $$  | $$| $$$$$$$$      '), nl,
    write('         | $$|  $$$| $$  | $$| $$  | $$| $$  | $$| $$_____|      '), nl,
    write('         | $$ |  $$|  $$$$$$||  $$$$$$$|  $$$$$$$|  $$$$$$$      '), nl,
    write('         |__|  |__| |______|  |_______| |____  $$ |_______|      '), nl,
    write('                                         $$  | $$|               '), nl,
    write('                                        |_ $$$$$$|               '), nl,
    write('                                          |____|                 '), nl, nl, nl, nl, nl, nl, nl.


display_game(Board, Player) :-
    printBoard(Board).


printBoard(Board) :-
    write('   '),
    printCoordLetters,
    write('   '),
    printMatrix(Board, 0).


printCoordLetters :-
    spacerTableTop, write('               A       B       C       D       E    '),
    nl.

printHeader :-
    spacerTableTop, write('           -----------------------------------------'),
    nl.

printEmpty :-
    spacerTableTop, write('           |       |       |       |       |       |'),
    nl.

printBlank :-
    spacerTableTop, write('                                                    '),
    nl.


%  ---------- PRINT LINE OF MATRIX -------------

printLineWithCell([]).
printLineWithCellOut([]).

%  ---------- PRINT LINE OF MATRIX with cells -------------
printLineWithCell([Head|Tail], Ind) :-
    Ind = 7 -> (cell(Head, Char), write('   '), write(Char), write('   '), printLineWithCell(Tail));
    cell(Head, Char),
    write('   '), write(Char), write('   |'),
    NextInd is Ind + 1,
    printLineWithCell(Tail, NextInd).

%  ---------- PRINT LINE OF MATRIX with no cells -------------
printLineWithCellOut([Head|Tail]) :-
    cell(Head, Char),
    write('   '), write(Char), write('    '),
    printLineWithCellOut(Tail).



%  ---------- PRINT MATRIX -------------
printMatrix([], _).

printMatrix([Head|Tail], Index) :-
    Index = 0 -> ( write('   '), printBlank,
    printBlank, NextIndex is Index + 1, 
    write('       '), printLineWithCellOut(Head), nl, 
    printBlank, write('   '), printHeader, 
    printMatrix(Tail, NextIndex));

    Index = 6 -> ( write('   '), printBlank, 
    printBlank, NextIndex is Index + 1, write('       '), 
    printLineWithCellOut(Head), nl, write('   '), 
    printMatrix(Tail, NextIndex));

    write('   '),
    printEmpty,
    spacerTableTop, 
    write('    '), write(Index), write('  '),
    NextIndex is Index + 1,
    printLineWithCell(Head, 1), nl,
    write('   '),
    printEmpty,
    write('   '),
    printHeader,
    printMatrix(Tail, NextIndex).    


%------------GAME MODE MENU PRINT---------------

printgameModeMenu:-
	clearTheConsole,
	displayGameName,
	spacerCenterBox, write(' -------------------------------'), nl,
	spacerCenterBox, write('|           Game Mode           |'), nl,
	spacerCenterBox, write('|                               |'), nl,
	spacerCenterBox, write('|   1. Player vs. Player        |'), nl,
	spacerCenterBox, write('|   2. Player vs. Computer      |'), nl,
	spacerCenterBox, write('|   3. Computer vs. Computer    |'), nl,
	spacerCenterBox, write('|   4. Back                     |'), nl,
	spacerCenterBox, write('|                               |'), nl,
	spacerCenterBox, write(' -------------------------------'), nl,
	spacerCenterBox, write('Choose an option(without the dot):'), nl.

%------------MAIN MENU PRINT---------------

printMainMenu:-
	clearTheConsole,
	displayGameName,
	spacerCenterBox, write(' -------------------------------'), nl,
	spacerCenterBox, write('|             Menu1             |'), nl,
	spacerCenterBox, write('|                               |'), nl,
	spacerCenterBox, write('|   1. Play a match             |'), nl,
	spacerCenterBox, write('|   2. Exit                     |'), nl,
	spacerCenterBox, write('|                               |'), nl,
	spacerCenterBox, write(' -------------------------------'), nl,
	spacerCenterBox, write('Choose an option(without the dot):'), nl.