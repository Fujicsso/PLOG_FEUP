
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

manageInput(2) :-
	startGame('P', 'C').

manageInput(3) :-
	startGame('C', 'C').

manageInput(4).


startGame('P', 'P') :-
	initialBoard(Board),
	gamePvP(Board, black, white).

startGame('P', 'C') :-
	initialBoard(Board),
	gamePvC(Board, black, white).
	

startGame('C', 'C') :-
	initialBoard(Board),
	gameCvC(Board, black, white).
	
%------------STARTS PLAYER VS PLAYER------------


gamePvP(Board, Player1, Player2) :-
	write('Starting Game!\n'),
	game_loop(Board, Player1, Player2, 'P', 'P').


game_loop(Board, Player1, Player2, 'P', 'P') :-
	choose_move(Board, Player1, PlayerOneBoard, 'P'),	%black
	choose_move(PlayerOneBoard, Player2, PlayerTwoBoard, 'P'),	%white
	game_loop(PlayerTwoBoard, Player1, Player2, 'P','P').



%------------STARTS PLAYER VS AI---------------



%------------STARTS AI VS AI---------------


