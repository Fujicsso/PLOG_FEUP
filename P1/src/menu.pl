
%------------MAIN MENU---------------

mainMenu:-
	printMainMenu,
    read(Input),
    manageInput(Input).


%------------GAME MODE MENU ---------------

printMainMenu:-
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
	spacerCenterBox, write('Choose an option(without a dot at the end):'), nl.


manageInput(1) :-
	startGame('P', 'P').

% manageInput(2) :-
% 	startGame('P', 'C').

% manageInput(3) :-
% 	startGame('C', 'C').

manageInput(4).


startGame('P', 'P') :-
	initialBoard(Board),
	gamePvP(Board, black, white).
	
%------------STARTS PLAYER VS PLAYER------------


gamePvP(Board, Player1, Player2) :-
	write('Starting Game!\n'),
	display_game(Board),
	choose_move(Board, Player1).	%black
	% choose_move(Player2).	%white
	% gamePvP(Player1, Player2).



%------------STARTS PLAYER VS AI---------------



%------------STARTS AI VS AI---------------


