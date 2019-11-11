
%------------MAIN MENU---------------

mainMenu1:-
	printMainMenu,
	getChar(Input),
	(
		Input = '1' -> gameModeMenu;
		Input = '2';

		nl,
		write('Invalid input.'), nl,
		pressEnterToContinue, nl,
		mainMenu1
	).


%------------MAIN MENU PRINT---------------

printMainMenu:-
	clearTheConsole,
	displayGameName,
	spacerCenterBox, write(' -------------------------------'), nl,
	spacerCenterBox, write('|             Menu1             |'), nl,
	spacerCenterBox, write('|                               |'), nl,
	spacerCenterBox, write('|   1. Play a match             |'), nl,
	spacerCenterBox, write('|   2. Exit                     |'), nl,
	spacerCenterBox, write('|                               |'), nl,
	spacerCenterBox, write(' -------------------------------'), nl,
	spacerCenterBox, write('Choose an option(without the dot):'), nl.

%----------GAME MODE MENU-------------

gameModeMenu:-
	printgameModeMenu,
	getChar(Input),
	(
		Input = '1' -> startPvPGame;
		Input = '2' -> startPvBGame;
		Input = '3' -> startBvBGame;
		Input = '4' -> mainMenu1;

		nl,
		write('invalid input.'), nl,
		pressEnterToContinue, nl,
		gameModeMenu
	).

%------------GAME MODE MENU PRINT---------------

printgameModeMenu:-
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
	spacerCenterBox, write('Choose an option(without the dot):'), nl.

	
%------------STARTS PLAYER VS PLAYER------------

startPvPGame:-
	startGame.


%------------STARTS PLAYER VS AI---------------

%startPvBGame:-



%------------STARTS AI VS AI---------------

%startBvBGame:-

