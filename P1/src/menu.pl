
%------------MAIN MENU---------------

mainMenu:-
	printMainMenu,
	read(Input1),
	manageInput1(Input1).



%------------GAME MODE MENU ---------------


manageInput1(1) :-
	printgameModeMenu,
    read(Input),
    manageInput(Input).

manageInput1(2) :-
	halt(0).



manageInput(1) :-
	startGame('P', 'P').

manageInput(2) :-
	startGame('P', 'C').

manageInput(3) :-
	startGame('C', 'C').

manageInput(4) :-
	mainMenu.


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
	game_loop(Board, Player1, Player2).


gamePvC(Board, Player1, Player2) :-
	write('Starting Game!\n'),
	game_loop(Board, Player1, Player2).


gameCvC(Board, Player1, Player2) :-
	write('Starting Game!\n'),
	game_loop(Board, Player1, Player2, 'C', 'C').


game_loop(Board, Player1, Player2) :-
	choose_move(Board, Player1, PlayerOneBoard, 'P'),	%black
	choose_move(PlayerOneBoard, Player2, PlayerTwoBoard, 'P'),	%white
	game_loop(PlayerTwoBoard, Player1, Player2).



%------------STARTS PLAYER VS AI---------------



%------------STARTS AI VS AI---------------


