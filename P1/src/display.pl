startGame :-
    initialBoard(Board),
    displayGameName,
    display_game(Board, Player),
    ansi_format([bold,fg(cyan)], 'Hello ~w', [world]).


initialBoard(
    [
        [empty, empty, empty, empty, empty],
        [empty, black, black, black, empty],
        [empty, empty, empty, empty, empty],
        [empty, white, white, white, empty],
        [empty, empty, empty, empty, empty]
    ]
    ).


cell(white, C) :-
    C = '0'.
cell(black, C) :-
    C = 'X'.
cell(empty, C) :-
    C = '.'.


displayGameName :-
    write('     / $$    $$                | $$                          '), nl,  
    write('     | $$$ | $$                | $$                          '), nl,
    write('     | $$$$| $$  $$  / $$   $$$$$$$ / $$$$$$   / $$$$$$      '), nl,
    write('     | $$ $$ $$| $$  | $$ |$$__  $$ |$$__  $$ |$$__  $$      '), nl,
    write('     | $$  $$$$| $$  | $$| $$  | $$| $$  | $$| $$$$$$$$      '), nl,
    write('     | $$|  $$$| $$  | $$| $$  | $$| $$  | $$| $$_____|      '), nl,
    write('     | $$ |  $$|  $$$$$$||  $$$$$$$|  $$$$$$$|  $$$$$$$      '), nl,
    write('     |__|  |__| |______|  |_______| |____  $$ |_______|      '), nl,
    write('                                    |$$  | $$                '), nl,
    write('                                    |  $$$$$$|               '), nl,
    write('                                    |______|                 '), nl, nl.


display_game(Board, Player) :-
    printBoard(Board).


printBoard(Board) :-
    write('   '),
    printCoordLetters,
    write('   '),
    printHeader,
    printMatrix(Board, 1).


printCoordLetters :-
    write('    A       B       C       D       E    '),
    nl.

printHeader :-
    write('-----------------------------------------'),
    nl.

printEmpty :-
    write('|       |       |       |       |       |'),
    nl.


printLineWithCell([]).

printLineWithCell([Head|Tail]) :-
    cell(Head, Char),
    write('   '), write(Char), write('   |'),
    printLineWithCell(Tail).


printMatrix([], _).

printMatrix([Head|Tail], Index) :-
    write('   '),
    printEmpty,
    write(' '), write(Index), write(' |'),
    NextIndex is Index + 1,
    printLineWithCell(Head), nl,
    write('   '),
    printEmpty,
    write('   '),
    printHeader,
    printMatrix(Tail, NextIndex).    

