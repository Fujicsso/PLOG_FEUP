choose_move(Player) :-
    write('Choose the coords for the cell to move.\n'),
    manageRow(CurrentRow),
    manageColumn(CurrentColumn),
    get_move(Move),
    validate_move(Move).
    % write(CurrentRow),
    % write(CurrentColumn),
    % write(Move).
    % write('Player '), write(Player), write( ' choose a move [U,D,R,L]:'),
    % get_move(Move),
    % validate_move(Move).


get_move(Move) :-
    getChar(Char),
    Move = Char,
    write(Move).
                

validate_move('U').
validate_move('D').
validate_move('R').
validate_move('L').


validate_move(_Move) :-
    write('ERROR: That move is not valid!\n\n'),
    get_move(Move),
    validate_move(Move).




    % write(CurrentRow),
    % write(CurrentColumn),
    % write(NewRow),
    % write(NewColumn).
    % validateMove()

manageRow(CurrentRow) :-
    readRow(Row),
    validateRow(Row, CurrentRow).

manageColumn(CurrentColumn) :-
    readColumn(Column),
    validateColumn(Column, CurrentColumn).

readRow(Row) :-
    write('> Row:   \n'),
    read(Row),
    write('\n').

readColumn(Column) :-
    write('> Column:    \n'),
    getChar(Column),
    write('\n').


validateRow(1, CurrentRow) :-
    CurrentRow = 0.

validateRow(2, CurrentRow) :-
    CurrentRow = 1.

validateRow(3, CurrentRow) :-
    CurrentRow = 2.

validateRow(4, CurrentRow) :-
    CurrentRow = 3.

validateRow(5, CurrentRow) :-
    CurrentRow = 4.


validateColumn('A', CurrentColumn) :-
    CurrentColumn = 0.

validateColumn('B', CurrentColumn) :-
    CurrentColumn = 1.

validateColumn('C', CurrentColumn) :-
    CurrentColumn = 2.

validateColumn('D', CurrentColumn) :-
    CurrentColumn = 3.

validateColumn('E', CurrentColumn) :-
    CurrentColumn = 4.

validateColumn(_Row, CurrentColumn) :-
    write('ERROR: That row is not valid!\n\n'),
    readColumn(Input),
    validateColumn(Input, CurrentColumn).

