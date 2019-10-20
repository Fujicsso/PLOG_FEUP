

startGame :-
    lastBoard(Board),
    displayGameName,
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
    write('                                          |____|                 '), nl, nl, nl.


display_game(Board, Player) :-
    printBoard(Board).


printBoard(Board) :-
    write('   '),
    printCoordLetters,
    write('   '),
    printMatrix(Board, 0).


printCoordLetters :-
    write('               A       B       C       D       E    '),
    nl.

printHeader :-
    write('           -----------------------------------------'),
    nl.

printEmpty :-
    write('           |       |       |       |       |       |'),
    nl.

printBlank :-
    write('                                                    '),
    nl.


printLineWithCell([]).
printLineWithCellOut([]).

printLineWithCell([Head|Tail], Ind) :-
    Ind = 7 -> (cell(Head, Char), write('   '), write(Char), write('   '), printLineWithCell(Tail));
    cell(Head, Char),
    write('   '), write(Char), write('   |'),
    NextInd is Ind + 1,
    printLineWithCell(Tail, NextInd).

printLineWithCellOut([Head|Tail]) :-
    cell(Head, Char),
    write('   '), write(Char), write('    '),
    printLineWithCellOut(Tail).


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
    write('    '), write(Index), write('  '),
    NextIndex is Index + 1,
    printLineWithCell(Head, 1), nl,
    write('   '),
    printEmpty,
    write('   '),
    printHeader,
    printMatrix(Tail, NextIndex).    

