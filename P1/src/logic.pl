choose_move(Board,Player) :-
    write('Choose the coords for the cell to move.\n'),
    manageRow(CurrentRow), write(CurrentRow),
    manageColumn(CurrentColumn), write(CurrentColumn),
    get_move(Move),
    validate_boundaries(Board, Move, CurrentRow, CurrentColumn),
    getValueFromMatrix(Board, CurrentRow, CurrentColumn, Elem),
    write('Found element: '), write(Elem), write('\n\n').
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
validate_boundaries(Board, 'U', 1, CurrentColumn):-
    write('ERROR: That move is not valid! UP\n\n'),
    write('Row: '), write('1\n'), write('Column: '), write(CurrentColumn), 
    write('\n'),
    get_move(M),
    validate_boundaries(Board, M, 1, CurrentColumn).

validate_boundaries(Board, 'D', 5, CurrentColumn):-
    write('ERROR: That move is not valid! DOWN\n\n'),
    write('Row: '), write('5\n'), write('Column: '), write(CurrentColumn), 
    write('\n'),
    get_move(M),
    validate_boundaries(Board, M, 5, CurrentColumn).

validate_boundaries(Board, 'R', CurrentRow, 5):-
    write('ERROR: That move is not valid! RIGHT\n\n'),
    get_move(M),
    validate_boundaries(Board, M, CurrentRow, 5).

validate_boundaries(Board, 'L', CurrentRow, 1):-
    write('ERROR: That move is not valid! LEFT\n\n'),
    get_move(M),
    validate_boundaries(Board, M, CurrentRow, 1).

validate_boundaries(Board, _Move, CurrentRow, CurrentRow):-
    write('\nACCEPTED MOVE\n\n').

% DEFAULT
% validate_move(Board, _Move, CurrentRow, CurrentColumn) :-
%     write('ERROR: That move is not valid! DEFAULT\n\n'),
%     get_move(M),
%     validate_move(Board, M, CurrentRow, CurrentColumn).


validate_cell(Player, CurrentRow, CurrentRow) :-
    getValueFromMatrix(Board, CurrentRow, CurrentColumn, Elem),
    write('Player: '), write(Player), write('\n'),
    write('Elem: '), write(Elem), write('\n').





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
    not(_Row=='A'),
    not(_Row=='B'),
    not(_Row=='C'),
    not(_Row=='D'),
    not(_Row=='E'),
    write('ERROR: That column is not valid!\n\n'),
    write(_Row), write('\n\n'),
    manageColumn(CurrentColumn).

