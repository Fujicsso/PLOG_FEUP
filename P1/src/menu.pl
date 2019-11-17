
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
	testBoard(Board),
	gamePvP(Board, black, white).
	
%------------STARTS PLAYER VS PLAYER------------


gamePvP(Board, Player1, Player2) :-
	write('Starting Game!\n'),
	game_loop(Board, Player1, Player2).


game_loop(Board, Player1, Player2) :-
	choose_move(Board, Player1, PlayerOneBoard_1, 'P'),	%black
	choose_move(PlayerOneBoard_1, Player1, PlayerOneBoard_2, 'P'),	%black
	choose_move(PlayerOneBoard_2, Player2, PlayerTwoBoard_1, 'P'),	%white
	choose_move(PlayerTwoBoard_1, Player2, PlayerTwoBoard_2, 'P'),	%white
	game_loop(PlayerTwoBoard_2, Player1, Player2).



%------------STARTS PLAYER VS AI---------------



%------------STARTS AI VS AI---------------


