
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


