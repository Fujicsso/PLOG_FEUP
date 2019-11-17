
cell(white, C) :-
    C = '0'.
cell(black, C) :-
    C = 'X'.
cell(empty, C) :-
    C = ' '.

player(black).
player(white).


%  Consule Cleanage

clearTheConsole:-
	clearTheConsole(40), !.

clearTheConsole(0).

clearTheConsole(N):-
	nl,
	N1 is N-1,
  clearTheConsole(N1).



%  Input of 1 Char
getChar(Input):-
    get_char(Input),
    skip_line.  

% Spaces to Center Boxes
spacerCenterBox:-
    write('                 ').

% Spaces for the TableTop
spacerTableTop:-
    write('  ').


%----------COMPARISON-----------

isEqual(A,B):-
	A =:= B.

isNotEqual(A,B):-
	not(A == B).



% Matrix manipulation

replaceInList([_H|T], 0, Value, [Value|T]).
replaceInList([H|T], Index, Value, [H|TNew]) :-
        Index > 0,
        Index1 is Index - 1,
        replaceInList(T, Index1, Value, TNew).

replaceInMatrix([H|T], 0, Column,Value, [HNew|T]) :-
        replaceInList(H, Column, Value, HNew).

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

getValueFromMatrix([_H|T], Row, Column, Value) :-
    % write('Looking for values in '),
    % write(Row),
    % write(' x '),
    % write(Column),
    % write('\n'),
    Row > 0,
    Row1 is Row - 1,
    getValueFromMatrix(T, Row1, Column, Value).



%CHECKS IF GAME IS OVER
check_game_over(Board, Winner) :-
    write('Checking rows:\n'),
    check_row(Board, 0, Winner),
    write('Checking columns:\n'),
    check_column(Board, Winner),
    write('All checks good.').


check_column([], Winner) :-
    write('EMPTY COLUMN\n'),
    true.

check_column([H|T], Winner) :-
    check_vertical(H, Winner),
    check_column(T, Winner).

%TRUE IF GAMEOVER. Looks for black cell
check_vertical(List, Winner) :-
    \+ nth0(0, List, black),
    \+ nth0(0, List, white),
    \+ nth0(6, List, black),
    \+ nth0(6, List, white).

check_vertical(List, Winner) :-
    nth0(0, List, black),
    write('GAME OVER\n'),
    Winner = white,
    write('The Winner Is: '),
    write(Winner),
    write('\n'),
    write('Press Enter to Close Window\n'),
    read(Enter),
    halt(0).  
    
check_vertical(List, Winner) :-
    nth0(0, List, white),
    write('GAME OVER\n'),
    Winner = black,
    write('The Winner Is: '),
    write(Winner),
    write('\n'),
    write('Press Enter to Close Window\n'),
    read(Enter),    
    halt(0).  

check_vertical(List, Winner) :-
    nth0(6, List, black),
    write('GAME OVER\n'),
    Winner = white,
    write('The Winner Is: '),
    write(Winner),
    write('\n'),
    write('Press Enter to Close Window\n'),
    read(Enter),
    halt(0).    

check_vertical(List, Winner) :-
    nth0(6, List, white),
    write('GAME OVER\n'),
    Winner = black,
    write('The Winner Is: '),
    write(Winner),
    write('\n'),
    write('Write "." and Enter to Close Window\n'),
    read(Enter),
    halt(0).   

% First row
check_row([H|T], Index, Winner) :-
    Index == 0,
    write(Index),
    check_horizontal(H, Winner),
    get_last_row([H|T], 0, Row, Winner).


% White cell. Game Over!
check_horizontal(List, Winner) :-
    member(white, List),
    write('Game Over!!!'),
    Winner = black,
    write('The Winner Is: '),
    write(Winner),
    write('\n'),
    write('Press Enter to Close Window\n'),
    read(Enter),   %TRUE IF GAME OVER
    halt(0).   
    
    % Black cell. Game Over!
check_horizontal(List, Winner) :-
    member(black, List),   %TRUE IF GAME OVER
    write('Game Over!!!'),
    Winner = white,
    write('The Winner Is: '),
    write(Winner),
    write('\n'),
    write('Press Enter to Close Window\n'),
    read(Enter),   %TRUE IF GAME OVER
    halt(0).   

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


get_last_row([], Index, Row, Winner) :-
    write('LISTA VAZIA\n').




% INVERT PLAYERS
invertPlayer(white, InvertedPlayer):-
    InvertedPlayer = black.

invertPlayer(black, InvertedPlayer):-
    InvertedPlayer = white.


% getValueFromMatrix(_He, Row, Column, Value).

% GET PIECE

% getPiece(Board, NLine, NColumn, Piece):-
% 		getElemPos(NLine, Board, Line),
% 		getElemPos(NColumn, Line, Piece).


% % GET ELEMENT POSITION ON A LIST

% getElemPos(1,[Element|_], Element).
% getElemPos(Pos,[_|Tail], Element):-
% 		Pos > 1,
% 		Next is Pos-1,
% 		getElemPos(Next, Tail, Element).

% % SET PIECE

% setPiece(PrevBoard, NLine, NColumn, Piece, Board):-
% 		setNLine(NLine, PrevBoard, NColumn, Piece, Board).


% % SET PIECE ON LINE

% setNLine(1, [Line|Tail], NColumn, Piece, [NewLine| Tail]):-
% 		setNColumn(NColumn, Line, Piece, NewLine).
% setNLine(Pos, [Line|Tail], NColumn, Piece, [Line| NewTail]):-
% 		Pos > 1, Next is Pos-1,
% 		setNLine(Next, Tail, NColumn, Piece, NewTail).


% % SET PIECE ON COLUMN

% setNColumn(1, [_|Tail], Piece, [Piece| Tail]).
% setNColumn(Pos, [X|Tail], Piece, [X|NewTail]):-
% 		Pos > 1,
% 		Next is Pos-1,
% 		setNColumn(Next, Tail, Piece, NewTail).