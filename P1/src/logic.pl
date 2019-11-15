choose_move(Board, Player, BoardToReturn) :-
    write('\n\nPlayer '), write(Player), write(' turn!\n'),
    display_game(Board),
    get_play(Board, Player, ValidatedRow, ValidatedColumn, NewRow, NewColumn),
    %Cells and Move are valid
    replaceInMatrix(Board, ValidatedRow, ValidatedColumn, empty, NewBoard),
    replaceInMatrix(NewBoard, NewRow, NewColumn, Player, BoardToReturn).

get_play(Board, Player, ValidatedRow, ValidatedColumn, NewRow, NewColumn) :-
    write('Choose the coords for the cell to move.\n'),
    manageRow(CurrentRow), write(CurrentRow),
    manageColumn(CurrentColumn), write(CurrentColumn),
    piece_color(Board, Player, CurrentRow, CurrentColumn, ValidatedRow, ValidatedColumn),
    get_move(Move),
    validate_boundaries(Board, Move, ValidatedRow, ValidatedColumn, NewMove),
    validate_push(Board, Player, NewMove, ValidatedRow, ValidatedColumn, NewerMove),
    % update_coords(NewMove, ValidatedRow, ValidatedColumn, UpdatedRow, UpdatedColumn),
    % empty_space(Board, Player, UpdatedRow, UpdatedColumn, NewRow, NewColumn).


%  MOVES INTO OPOSITE PIECE
validate_push(Board, Player, NewMove, Row, Column, NewerMove):-
    update_coords(NewMove, Row, Column, TestRow, TestColumn),
    getValueFromMatrix(Board, TestRow, TestColumn, Value),
    manageTypeMatrix(Value, Player, Board, NewMove, Row, Column, NewerMove).

manageTypeMatrix(empty, Player, Board, NewMove, Row, Column, NewerMove):-
    write('Cell to move into is free!\n').

manageTypeMatrix(black, black, Board, NewMove, Row, Column, NewerMove):-
    write('LINE SPOTTED\n').

manageTypeMatrix(black, white, Board, NewMove, Row, Column, NewerMove):-
    write('Cell to move into is occupied!\n').
    

manageTypeMatrix(white, white, Board, NewMove, Row, Column, NewerMove):-
    write('LINE SPOTTED\n').

manageTypeMatrix(white, black, Board, NewMove, Row, Column, NewerMove):-
    write('Cell to move into is occupied!\n').



% Checks if the selected piece's color is correct, taking into account the Player
piece_color(Board, Player, Row, Column, FinalRow, FinalColumn) :-
    getValueFromMatrix(Board, Row, Column, Value),
    Value == Player,
    write('Correct cell selected\n'),
    FinalRow is Row,
    FinalColumn is Column.


% If the selected piece is not the right color, asks for another piece to be selected
piece_color(Board, Player, Row, Column, FinalRow, FinalColumn) :-
    write('Selected cell does not contain a piece of the correct color.\n'),
    write('Choose the coords for the cell to move.\n'),
    manageRow(CurrentRow), write(CurrentRow),
    manageColumn(CurrentColumn), write(CurrentColumn),
    piece_color(Board, Player, CurrentRow, CurrentColumn, FinalRow, FinalColumn).
    

% Checks if the cell to be moved into is empty
empty_space(Board, Player, Row, Column, FinalRow, FinalColumn) :-
    getValueFromMatrix(Board, Row, Column, Value),
    Value == empty,
    write('Cell to move into is free!\n'),
    FinalRow is Row,
    FinalColumn is Column.




update_coords(Move, CurrentRow, CurrentColumn, NewRow, NewColumn) :-
    Move == 'U',
    write('Move = U\n'),
    NewRow is CurrentRow - 1,
    NewColumn is CurrentColumn.

update_coords(Move, CurrentRow, CurrentColumn, NewRow, NewColumn) :-
    Move == 'D',
    write('Move = D\n'),
    NewRow is CurrentRow + 1,
    NewColumn is CurrentColumn.

update_coords(Move, CurrentRow, CurrentColumn, NewRow, NewColumn) :-
    Move == 'L',
    write('Move = L\n'),
    NewColumn is CurrentColumn - 1,
    NewRow is CurrentRow.

update_coords(Move, CurrentRow, CurrentColumn, NewRow, NewColumn) :-
    Move == 'R',
    write('Move = R\n'),
    NewColumn is CurrentColumn + 1,
    NewRow is CurrentRow.

update_coords(Move, CurrentRow, CurrentColumn, NewRow, NewColumn) :-
    not(Move == 'R'),
    not(Move == 'L'),
    not(Move == 'U'),
    not(Move == 'D'),
    write('Move is not valid what\n'), write(Move), write('\n').


get_move(MoveS) :-
    write('> Move:    (U,D,R,L)\n'),
    read(Char),
    MoveS = Char,
    write(MoveS).


%  MOVES OUT OF BOUNDARIES
validate_boundaries(Board, 'U', 1, CurrentColumn, NewMove):-
    write('ERROR: That move is not valid! UP\n\n'),
    write('Row: '), write('1\n'), write('Column: '), write(CurrentColumn), 
    write('\n'),
    get_move(M),
    validate_boundaries(Board, M, 1, CurrentColumn, NewMove).

validate_boundaries(Board, 'D', 5, CurrentColumn, NewMove):-
    write('ERROR: That move is not valid! DOWN\n\n'),
    write('Row: '), write('5\n'), write('Column: '), write(CurrentColumn), 
    write('\n'),
    get_move(M),
    validate_boundaries(Board, M, 5, CurrentColumn, NewMove).

validate_boundaries(Board, 'R', CurrentRow, 5, NewMove):-
    write('ERROR: That move is not valid! RIGHT\n\n'),
    get_move(M),
    validate_boundaries(Board, M, CurrentRow, 5, NewMove).

validate_boundaries(Board, 'L', CurrentRow, 1, NewMove):-
    write('ERROR: That move is not valid! LEFT\n\n'),
    get_move(M),
    validate_boundaries(Board, M, CurrentRow, 1, NewMove).

validate_boundaries(Board, _Move, CurrentRow, CurrentColumn, NewMove):-
    write('\nACCEPTED MOVE BOUNDARIES\n\n'),
    NewMove = _Move.

% MOVES INTO OPOSITE PIECE
check_empty(Board, NLine, NCol, NextBoard, Player, Computer):-
	getPiece(Board, NLine, NCol, X),
	X == empty, setPiece(Board, NLine, NCol, Player, NextBoard);
    X \= empty, write('There is already a piece there! Try again!'), nl, check_empty(Board, NLine, NCol, NextBoard, Player, Computer).

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
    write('> Row:   (1, 2, 3, 4, 5)\n'),
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

validateColumn(Row, CurrentColumn) :-
    not(Row=='A'),
    not(Row=='B'),
    not(Row=='C'),
    not(Row=='D'),
    not(Row=='E'),
    write('ERROR: That column is not valid!\n\n'),
    write(Row), write('\n\n'),
    manageColumn(CurrentColumn).

