choose_move(Player) :-
    write('Choose the coords for the cell to move.\n'),
    manageRow(CurrentRow),
    write(CurrentRow),
    manageColumn(CurrentColumn),
    write(CurrentColumn),
    get_move(Move),
    validate_move(Board, Move, CurrentRow, CurrentColumn).
    % write(CurrentRow),
    % write(CurrentColumn),
    % write(Move).
    % write('Player '), write(Player), write( ' choose a move [U,D,R,L]:'),
    % get_move(Move),
    % validate_move(Move).


get_move(Move) :-
    write('> Move:    (U,D,R,L)\n'),
    read(Char),
    Move = Char,
    write(Move).


%  MOVES OUT OF BOUNDARIES
validate_move(Board, 'U', 1, CurrentColumn):-
    write('ERROR: That move is not valid! UP\n\n'),
    write('Row: '), write('1\n'), write('Column: '), write(CurrentColumn), 
    write('\n'),
    get_move(M),
    validate_move(Board, M, 1, CurrentColumn).

validate_move(Board, 'D', 5, CurrentColumn):-
    write('ERROR: That move is not valid! DOWN\n\n'),
    write('Row: '), write('5\n'), write('Column: '), write(CurrentColumn), 
    write('\n'),

    get_move(M),
    validate_move(Board, M, CurrentRow, CurrentColumn).

validate_move(Board, 'R', CurrentRow, 5):-
    write('ERROR: That move is not valid! RIGHT\n\n'),
    get_move(M),
    validate_move(Board, M, CurrentRow, CurrentColumn).

validate_move(Board, 'L', CurrentRow, 1):-
    write('ERROR: That move is not valid! LEFT\n\n'),
    get_move(M),
    validate_move(Board, M, CurrentRow, CurrentColumn).

% MOVES OK

validate_move(Board, 'U', CurrentRow, CurrentColumn):-
    isEqual(CurrentRow, 1),
    validate_move(Board, 'U', 1, CurrentColumn);
    write('INPUT accepted UP\n').    

validate_move(Board, 'D', CurrentRow, CurrentColumn):-
    isEqual(CurrentRow, 5),
    validate_move(Board, 'D', 5, CurrentColumn);
    write('INPUT accepted DOWN\n').    

validate_move(Board, 'R', CurrentRow, CurrentColumn):-
    isEqual(CurrentColumn, 5),
    validate_move(Board, 'R', CurrentRow, 5);
    write('INPUT accepted RIGHT\n').    

validate_move(Board, 'L', CurrentRow, CurrentColumn):-
    isEqual(CurrentColumn, 1),
    validate_move(Board, 'L', CurrentRow, 1);
    write('INPUT accepted LEFT\n').


% DEFAULT
validate_move(Board, _Move, CurrentRow, CurrentColumn) :-
    write('ERROR: That move is not valid! DEFAULT\n\n'),
    get_move(M),
    validate_move(Board, M, CurrentRow, CurrentColumn).




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
    write('> Row:   (1, 2, 3, 4)\n'),
    read(Row),
    write('\n').

readColumn(Column) :-
    write('> Column:    (A, B, C, D, E)\n'),
    read(Column),
    write('\n').


validateRow(1, CurrentRow) :-
    CurrentRow = 1.

validateRow(2, CurrentRow) :-
    CurrentRow = 2.

validateRow(3, CurrentRow) :-
    CurrentRow = 3.

validateRow(4, CurrentRow) :-
    CurrentRow = 4.

validateRow(5, CurrentRow) :-
    CurrentRow = 5.


validateColumn('A', CurrentColumn) :-
    CurrentColumn = 1.

validateColumn('B', CurrentColumn) :-
    CurrentColumn = 2.

validateColumn('C', CurrentColumn) :-
    CurrentColumn = 3.

validateColumn('D', CurrentColumn) :-
    CurrentColumn = 4.

validateColumn('E', CurrentColumn) :-
    CurrentColumn = 5.

validateColumn(_Row, CurrentColumn) :-
    write('ERROR: That column is not valid!\n\n'),
    manageColumn(Column).

