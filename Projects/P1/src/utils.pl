
% Returns char associated to a given player
% C - char to be returned
cell(white, C) :-
    C = '0'.
cell(black, C) :-
    C = 'X'.
cell(empty, C) :-
    C = ' '.

% Validates player
player(black).
player(white).


% Cleans console
clearTheConsole:-
	clearTheConsole(40), !.

clearTheConsole(0).

clearTheConsole(N):-
	nl,
	N1 is N-1,
  clearTheConsole(N1).



% Formats display
spacerCenterBox:-
    write('                 ').

% Formats display
spacerTableTop:-
    write('  ').


%----------COMPARISON-----------

isEqual(A,B):-
	A =:= B.

isNotEqual(A,B):-
	not(A == B).




replaceInList([_H|T], 0, Value, [Value|T]).
replaceInList([H|T], Index, Value, [H|TNew]) :-
    Index > 0,
    Index1 is Index - 1,
    replaceInList(T, Index1, Value, TNew).

replaceInMatrix([H|T], 0, Column,Value, [HNew|T]) :-
    replaceInList(H, Column, Value, HNew).

% Matrix manipulation. Replaces element in Matrix.
% Board - old board
% Row - row of element to be replaced
% Column - column of element to be replaced
% Value - value to replace in respective place
% NewBoard - updated board, to be returned
replaceInMatrix([H|T], Row, Column, Value, [H|TNew]) :-
        Row > 0,
        Row1 is Row - 1,
        replaceInMatrix(T, Row1, Column, Value, TNew).




getValueFromList([H|_T], 0, Value) :-
    Value = H.

getValueFromList([_H|T], Index, Value) :-
    Index > 0,
    Index1 is Index - 1,
    getValueFromList(T, Index1, Value).

getValueFromMatrix([H|_T], 0, Column, Value) :-
    getValueFromList(H, Column, Value).


% Matrix manipulation. Gets velue in Matrix.
% Board - old board
% Row - row of element to be replaced
% Column - column of element to be replaced
% Value - value to replace in respective place
getValueFromMatrix([_H|T], Row, Column, Value) :-
    Row > 0,
    Row1 is Row - 1,
    getValueFromMatrix(T, Row1, Column, Value).


% Checks if game is over
% Board - current board
% Winner - returns winning player
check_game_over(Board, Winner) :-
    check_row(Board, 0, Winner),
    check_column(Board, Winner).


check_column([], Winner) :-
    NewWinner is 3,
    Winner is NewWinner,
    true.

check_column([H|T], Winner) :-
    check_vertical(H, Winner),
    check_column(T, Winner).

check_vertical(List, Winner) :-
    \+ nth0(0, List, black),
    \+ nth0(0, List, white),
    \+ nth0(6, List, black),
    \+ nth0(6, List, white).

check_vertical(List, Winner) :-
    nth0(0, List, black),
    write('GAME OVER\n'),
    NewWinner is 0,
    Winner is NewWinner,
    write('The Winner Is: '),
    write(white),
    write('\n'),
    write('Press Enter to Close Window\n'),
    true.
    
check_vertical(List, Winner) :-
    nth0(0, List, white),
    write('GAME OVER\n'),
    NewWinner is 1,
    Winner is NewWinner,
    write('The Winner Is: '),
    write(black),
    write('\n'),
    write('Press Enter to Close Window\n'),
    true.

check_vertical(List, Winner) :-
    nth0(6, List, black),
    write('GAME OVER\n'),
    NewWinner is 0,
    Winner is NewWinner,
    write('The Winner Is: '),
    write(white),
    write('\n'),
    write('Press Enter to Close Window\n'),
    true.    

check_vertical(List, Winner) :-
    nth0(6, List, white),
    write('GAME OVER\n'),
    NewWinner is 1,
    Winner is NewWinner,
    write('The Winner Is: '),
    write(black),
    write('\n'),
    write('Write "." and Enter to Close Window\n'),
    true.   

% First row
check_row([H|T], Index, Winner) :-
    Index == 0,
    check_horizontal(H, Winner),
    get_last_row([H|T], 0, Row, Winner).


% White cell. Game Over!
check_horizontal(List, Winner) :-
    member(white, List),
    write('Game Over!!!'),
    NewWinner is 1,
    Winner is NewWinner,
    write('The Winner Is: '),
    write(black),
    write('\n'),
    write('Press Enter to Close Window\n'),
    true.
    
    % Black cell. Game Over!
check_horizontal(List, Winner) :-
    member(black, List),   %TRUE IF GAME OVER
    write('Game Over!!!'),
    NewWinner is 0,
    Winner is NewWinner,
    write('The Winner Is: '),
    write(white),
    write('\n'),
    write('Press Enter to Close Window\n'),
    true.

% Black cell. Game Over!
check_horizontal(List, Winner) :-
    \+ member(black, List),   %TRUE IF GAME OVER
    \+ member(white, List).

get_last_row([H|T], Index, Row, Winner) :-
    Index < 6,
    NewIndex is Index + 1,
    get_last_row(T, NewIndex, Row, Winner).

get_last_row([H|T], Index, Row, Winner) :-
    Index == 6,
    Row = H,
    check_horizontal(Row, Winner).


get_last_row([], Index, Row, Winner).


% Return opponent of current player
% InvertedPlayer - opponent to be returned
invertPlayer(white, InvertedPlayer):-
    InvertedPlayer = black.

invertPlayer(black, InvertedPlayer):-
    InvertedPlayer = white.
