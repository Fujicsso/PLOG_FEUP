
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


getValueFromList([H|_T], 0, Value) :-
    Value = H.

getValueFromList([_H|T], Index, Value) :-
    Index > 0,
    Index1 is Index - 1,
    getValueFromList(T, Index1, Value).

getValueFromMatrix([H|_T], 0, Column, Value) :-
    getValueFromList(H, Column, Value).

getValueFromMatrix([_H|T], Row, Column, Value) :-
    Row > 0,
    Row1 is Row - 1,
    getValueFromMatrix(T, Row1, Column, Value).

% getValueFromMatrix(_He, Row, Column, Value).

% GET PIECE

getPiece(Board, NLine, NColumn, Piece):-
		getElemPos(NLine, Board, Line),
		getElemPos(NColumn, Line, Piece).


% GET ELEMENT POSITION ON A LIST

getElemPos(1,[Element|_], Element).
getElemPos(Pos,[_|Tail], Element):-
		Pos > 1,
		Next is Pos-1,
		getElemPos(Next, Tail, Element).

% SET PIECE

setPiece(PrevBoard, NLine, NColumn, Piece, Board):-
		setNLine(NLine, PrevBoard, NColumn, Piece, Board).


% SET PIECE ON LINE

setNLine(1, [Line|Tail], NColumn, Piece, [NewLine| Tail]):-
		setNColumn(NColumn, Line, Piece, NewLine).
setNLine(Pos, [Line|Tail], NColumn, Piece, [Line| NewTail]):-
		Pos > 1, Next is Pos-1,
		setNLine(Next, Tail, NColumn, Piece, NewTail).


% SET PIECE ON COLUMN

setNColumn(1, [_|Tail], Piece, [Piece| Tail]).
setNColumn(Pos, [X|Tail], Piece, [X|NewTail]):-
		Pos > 1,
		Next is Pos-1,
		setNColumn(Next, Tail, Piece, NewTail).