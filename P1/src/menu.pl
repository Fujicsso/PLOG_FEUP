
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

	
%------------STARTS PLAYER VS PLAYER------------

startPvPGame:-
	startGame.


%------------STARTS PLAYER VS AI---------------

%startPvBGame:-



%------------STARTS AI VS AI---------------

%startBvBGame:-

