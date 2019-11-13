
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
	A == B.

isNotEqual(A,B):-
	not(A == B).
