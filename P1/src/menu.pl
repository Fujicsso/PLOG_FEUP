
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
	startPvPGame.

manageInput(2) :-
	startPvBGame.

manageInput(3) :-
	startBvBGame.

manageInput(4).

	
%------------STARTS PLAYER VS PLAYER------------

startPvPGame:-
	write('Starting Game!\n').
	

%------------STARTS PLAYER VS AI---------------

%startPvBGame:-



%------------STARTS AI VS AI---------------

%startBvBGame:-

