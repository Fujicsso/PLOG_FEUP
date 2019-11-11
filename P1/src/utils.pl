
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
    get_char(_).

% Spaces to Center Boxes
spacerCenterBox:-
    write('                 ').

% Spaces for the TableTop
spacerTableTop:-
    write('  ').


% Reads Move Input

getCoordsPlayer(NLine, NCol):-
	write('Type Board Coordinates Of The Piece You Want To Move: (Column. <enter> Line.)'), nl,
	read(NCol), nl,read(NLine)
    (
    NCol == 'A' -> ;
	NCol == 'B' -> ;
	NCol == 'C' -> ;
	NCol == 'D' -> ;
    NCol == 'E' -> ;

    NLine == '1' -> ;
	NLine == '2' -> ;
	NLine == '3' -> ;
	NLine == '4' -> ;
    NLine == '5' -> ;
    
    )

% Reads and Validates Move Input

getMovePlayer(Move1,Again):-
    