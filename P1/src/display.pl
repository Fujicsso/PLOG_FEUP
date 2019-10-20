startGame :-
    initialBoard(Board),
    displayGameName,
    display_game(Board, Player),
    ansi_format([bold,fg(yellow)], 'Hello ~w', [world]).


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
    C = 'o'.
cell(black, C) :-
    C = 'X'.
cell(empty, C) :-
    C = '.'.


cellColor(white, C) :-
    C = 'white'.
cellColor(black, C) :-
    C = 'black'.
cellColor(empty, C) :-
    C = 'yellow'.


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
    % write('-----------------------------------------'),
    ansi_format([bold,fg(yellow)], '~w', [-----------------------------------------]),
    nl.

printEmpty :-
    write('|       |       |       |       |       |'),
    nl.


printLineWithCell([]).

printLineWithCell([Head|Tail]) :-
    cell(Head, Char),
    cellColor(Head, Color),
    % write('   '), write(Char), write('   |'),
    % ansi_format([bold,fg(yellow)], '   ', []), 
    ansi_format([bold,fg(yellow)], '~w', [Char]), 
    ansi_format([bold,fg(yellow)], '~w', [Char]), 
    ansi_format([bold,fg(yellow)], '~w', [Char]), 
    ansi_format([bold,fg(yellow)], '~w', [Char]), 
    ansi_format([bold,fg(yellow)], '~w', [Char]), 
    ansi_format([bold,fg(yellow)], '~w', [Char]), 
    ansi_format([bold,fg(yellow)], '~w', [Char]), 
    % ansi_format([bold,fg(yellow)], '   |', []),
    ansi_format([bold,fg(yellow)], '|', []),
    printLineWithCell(Tail).


printMatrix([], _).

printMatrix([Head|Tail], Index) :-
    write('   '),
    % printEmpty,
    ansi_format([bold,fg(yellow)], '|', []),
    printLineWithCell(Head), nl,
    write(' '), write(Index), write(' '),
    NextIndex is Index + 1,
    ansi_format([bold,fg(yellow)], '|', []),
    printLineWithCell(Head), nl,
    write('   '),
    % printEmpty,
    ansi_format([bold,fg(yellow)], '|', []),
    printLineWithCell(Head), nl,
    write('   '),
    printHeader,
    printMatrix(Tail, NextIndex).    

