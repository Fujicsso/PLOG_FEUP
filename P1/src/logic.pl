choose_move(Board, Player, FinalBoard, 'P') :-
    write('\n\nPlayer '), write(Player), write(' turn!\n'),
    display_game(Board),
    get_play(Board, Player, ValidatedRow, ValidatedColumn, NewRow, NewColumn, FinalBoard1, Board),
    display_game(FinalBoard1),
    get_play(FinalBoard1, Player, ValidatedRow2, ValidatedColumn2, NewRow2, NewColumn2, FinalBoard, Board),
    write('SAIUUUU\n').

get_play(Board, Player, ValidatedRow, ValidatedColumn, NewRow, NewColumn, FinalBoard, PreviousBoard) :-
    check_game_over(Board, Winner),
    write('Choose the coords for the cell to move.\n'),
    repeat,
    manageRow(CurrentRow), write(CurrentRow),
    manageColumn(CurrentColumn), write(CurrentColumn),
    piece_color(Board, Player, CurrentRow, CurrentColumn, ValidatedRow, ValidatedColumn),
    get_move(Move),
    validate_boundaries(Board, Move, ValidatedRow, ValidatedColumn),
    write('Validated Boundaries\n'),
    validate_push(Board, Player, Move, ValidatedRow, ValidatedColumn, NewerMove, FinalBoard),
    checkNullMove(FinalBoard, PreviousBoard).
    % update_coords(NewMove, ValidatedRow, ValidatedColumn, UpdatedRow, UpdatedColumn).


% CHECK NULL PLAY



checkNullMove(Board1, Board2):-
    Board1 == Board2,
    write('This play will make your 2 plays null, chose another move\n'),
    fail.

checkNullMove(Board1, Board2):-
    Board1 \= Board2,
    write('BOARD IS DIFFERENT\n').
    % write(Board1),
    % write('\n'),
    % write(Board2),
    % write('\n').

% checkNullMove(Board1, Board2):-
%     write('BOARD2 IS NULL\n'),
%     write(Board2).


%  MOVES INTO OPOSITE PIECE
validate_push(Board, Player, NewMove, Row, Column, NewerMove, FinalBoard):-
    write('Entered Validate Push\n'),
    update_coords(NewMove, Row, Column, TestRow, TestColumn),
    write('updated coords\n'),
    getValueFromMatrix(Board, TestRow, TestColumn, Value),
    write('Value From Matrix Gotten\n'),
    manageTypeMatrix(Value, Player, Board, NewMove, Row, Column, TestRow, TestColumn, FinalBoard).


manageTypeMatrix(empty, Player, Board, NewMove, OldRow, OldColumn, Row, Column, FinalBoard):-
    write('Cell to move into is free!\n'),
    replaceInMatrix(Board, OldRow, OldColumn, empty, NewBoard),
    replaceInMatrix(NewBoard, Row, Column, Player, FinalBoard).


manageTypeMatrix(black, black,  Board, NewMove, OldRow, OldColumn, Row, Column, FinalBoard):-
    write('LINE SPOTTED\n'),
    Counter = 2,
    check_next_pos_line(Board, black, NewMove, Row, Column, Counter, FinalCounter, Collision),
    notifyCounter(FinalCounter),
    replaceLineInMatrix(Board, NewMove, OldRow, OldColumn, black, FinalCounter, FinalBoard, Collision).
    


manageTypeMatrix(black, white,  Board, NewMove, OldRow, OldColumn, Row, Column, FinalBoard):-
    write('Cell to move into is occupied//Cant Push!\n'),
    fail.
    

manageTypeMatrix(white, white,  Board, NewMove, OldRow, OldColumn, Row, Column, FinalBoard):-
    write('LINE SPOTTED\n'),
    Counter = 2,
    check_next_pos_line(Board, white, NewMove, Row, Column, Counter, FinalCounter, Collision),
    notifyCounter(FinalCounter),
    replaceLineInMatrix(Board, NewMove, OldRow, OldColumn, white, FinalCounter, FinalBoard, Collision).

manageTypeMatrix(white, black,  Board, NewMove, OldRow, OldColumn, Row, Column, FinalBoard):-
    write('Cell to move into is occupied//Cant Push!\n'),
    fail.



% CHECKS NEXT POSITION FOR A LINE
check_next_pos_line(Board, Player, Move, Row, Column, Counter, FinalCounter, Collision):-
    write('Entered CheckPosLine\n'),
    update_coords(Move, Row, Column, TestRow, TestColumn),
    write('updated coords\n'),
    getValueFromMatrix(Board, TestRow, TestColumn, Value),
    write('Value From Matrix Gotten\n'),
    manageCounterLine(Board, Player, Value, Move, TestRow, TestColumn, Counter, FinalCounter, Collision).

% CHECKS NEXT POSITION FOR AN ANTI-LINE
check_next_pos_anti_line(Board, Player, Move, Row, Column, Counter, FinalCounter):-
    write('Entered CheckPosAntiLine\n'),
    update_coords(Move, Row, Column, TestRow, TestColumn),
    write('updated coords\n'),
    getValueFromMatrix(Board, TestRow, TestColumn, Value),
    write('Value From Matrix Gotten\n'),
    manageCounterAntiLine(Board, Player, Value, Move, TestRow, TestColumn, Counter, FinalCounter).

% LINE COUNTER MANAGER

manageCounterLine(Board, Player, empty, Move, Row, Column, Counter, FinalCounter, Collision):-
    write('Next Slot is Empty\n'),
    FinalCounter is Counter,
    validate_boundaries_suicide(Board, Move, Row, Column),
    manageCollision(Counter, 0, Collision),
    write(FinalCounter), write(' \n').

manageCounterLine(Board, black, black, Move, Row, Column, Counter, FinalCounter, Collision):-
    NewCounter is Counter + 1,
    check_next_pos_line(Board, black, Move, Row, Column, NewCounter, FinalCounter, Collision).

manageCounterLine(Board, white, white, Move, Row, Column, Counter, FinalCounter):-
    NewCounter is Counter + 1,
    check_next_pos_line(Board, white, Move, Row, Column, NewCounter, FinalCounter, Collision).

manageCounterLine(Board, black, white, Move, Row, Column, Counter, FinalCounter, Collision):-
    NewCounter is Counter - 1,
    manageCollision(Counter, 1, Collision),
    check_next_pos_anti_line(Board, black, Move, Row, Column, NewCounter, FinalCounter).

manageCounterLine(Board, white, black, Move, Row, Column, Counter, FinalCounter, Collision):-
    NewCounter is Counter - 1,
    manageCollision(Counter, 1, Collision),
    check_next_pos_anti_line(Board, white, Move, Row, Column, NewCounter, FinalCounter).


% ANTI-LINE COUNTER MANAGER

manageCounterAntiLine(Board, Player, empty, Move, Row, Column, Counter, FinalCounter):-
    write('Next Slot is Empty\n'),
    FinalCounter is Counter,
    write(FinalCounter), write(' \n').

manageCounterAntiLine(Board, black, black, Move, Row, Column, Counter, FinalCounter):-
    write('There is another piece of yours on the other side. Try another move.\n'),
    FinalCounter is Counter,
    write(FinalCounter), write(' \n'),
    fail.

manageCounterAntiLine(Board, white, white, Move, Row, Column, Counter, FinalCounter):-
    write('There is another piece of yours on the other side. Try another move.\n'),
    FinalCounter is Counter,
    write(FinalCounter), write(' \n'),
    fail.

manageCounterAntiLine(Board, black, white, Move, Row, Column, Counter, FinalCounter):-
    NewCounter is Counter - 1,
    check_next_pos_anti_line(Board, black, Move, Row, Column, NewCounter, FinalCounter).

manageCounterAntiLine(Board, white, black, Move, Row, Column, Counter, FinalCounter):-
    NewCounter is Counter - 1,
    check_next_pos_anti_line(Board, white, Move, Row, Column, NewCounter, FinalCounter).



% FinalCounter Notifier

notifyCounter(Counter):-
    Counter > 0,
    write('Can Push!\n').

notifyCounter(Counter):-
    Counter < 1,
    write('Cant Push! Try Again.\n'),
    fail.

% COLLISION HANDLER
manageCollision(3, 1, Collision):-
    write('Collision is 2'),
    write(' \n'),
    Collision = 2.

manageCollision(Counter, 1, Collision):-
    write('Collision is 1'),
    write(' \n'),
    Collision = 1.

manageCollision(Counter, One, Collision):-
    write('Collision is 0'),
    write(' \n'),
    Collision = 0.


% REPLACE LINES IN MATRIX
replaceLineInMatrix(Board, Move, OldRow, OldColumn, Player, 1, FinalBoard, 1):-
    write('2v1 \n'),
    replaceInMatrix(Board, OldRow, OldColumn, empty, NewBoard),
    write('1 empty \n'),
    update_coords(Move, OldRow, OldColumn, TestRow1, TestColumn1),
    replaceInMatrix(NewBoard, TestRow1, TestColumn1, Player, TestBoard1),
    write('1 Player1 \n'),
    update_coords(Move, TestRow1, TestColumn1, TestRow2, TestColumn2),
    replaceInMatrix(TestBoard1, TestRow2, TestColumn2, Player, TestBoard2),
    write('2 Player1 \n'),
    invertPlayer(Player, InvertedPlayer),
    update_coords(Move, TestRow2, TestColumn2, TestRow3, TestColumn3),
    replaceInMatrix(TestBoard2, TestRow3, TestColumn3, InvertedPlayer, FinalBoard),
    write('1 Player2 \n').


replaceLineInMatrix(Board, Move, OldRow, OldColumn, Player, 1, FinalBoard, 2):-
    write('3v2 \n'),
    replaceInMatrix(Board, OldRow, OldColumn, empty, NewBoard),
    write('1 empty \n'),
    update_coords(Move, OldRow, OldColumn, TestRow1, TestColumn1),
    replaceInMatrix(NewBoard, TestRow1, TestColumn1, Player, TestBoard1),
    write('1 Player1 \n'),
    update_coords(Move, TestRow1, TestColumn1, TestRow2, TestColumn2),
    replaceInMatrix(TestBoard1, TestRow2, TestColumn2, Player, TestBoard2),
    write('2 Player1 \n'),
    update_coords(Move, TestRow2, TestColumn2, TestRow3, TestColumn3),
    replaceInMatrix(TestBoard2, TestRow3, TestColumn3, Player, TestBoard3),
    write('3 Player1 \n'),
    invertPlayer(Player, InvertedPlayer),
    update_coords(Move, TestRow3, TestColumn3, TestRow4, TestColumn4),
    replaceInMatrix(TestBoard3, TestRow4, TestColumn4, InvertedPlayer, TestBoard4),
    write('1 Player2 \n'),
    update_coords(Move, TestRow4, TestColumn4, TestRow5, TestColumn5),
    replaceInMatrix(TestBoard4, TestRow5, TestColumn5, InvertedPlayer, FinalBoard),
    write('2 Player2 \n').


replaceLineInMatrix(Board, Move, OldRow, OldColumn, Player, 2, FinalBoard, 2):-
    write('3v1 \n'),
    replaceInMatrix(Board, OldRow, OldColumn, empty, NewBoard),

    update_coords(Move, OldRow, OldColumn, TestRow1, TestColumn1),
    replaceInMatrix(NewBoard, TestRow1, TestColumn1, Player, TestBoard1),

    update_coords(Move, TestRow1, TestColumn1, TestRow2, TestColumn2),
    replaceInMatrix(TestBoard1, TestRow2, TestColumn2, Player, TestBoard2),

    update_coords(Move, TestRow2, TestColumn2, TestRow3, TestColumn3),
    replaceInMatrix(TestBoard2, TestRow3, TestColumn3, Player, TestBoard3),

    invertPlayer(Player, InvertedPlayer),
    update_coords(Move, TestRow3, TestColumn3, TestRow4, TestColumn4),
    replaceInMatrix(TestBoard3, TestRow4, TestColumn4, InvertedPlayer, FinalBoard).


replaceLineInMatrix(Board, Move, OldRow, OldColumn, Player, 2, FinalBoard, 0):-
    write('2v0 \n'),
    replaceInMatrix(Board, OldRow, OldColumn, empty, NewBoard),

    update_coords(Move, OldRow, OldColumn, TestRow1, TestColumn1),
    replaceInMatrix(NewBoard, TestRow1, TestColumn1, Player, TestBoard1),

    update_coords(Move, TestRow1, TestColumn1, TestRow2, TestColumn2),
    replaceInMatrix(TestBoard1, TestRow2, TestColumn2, Player, FinalBoard).


replaceLineInMatrix(Board, Move, OldRow, OldColumn, Player, 3, FinalBoard, 0):-
    write('3v0 \n'),
    replaceInMatrix(Board, OldRow, OldColumn, empty, NewBoard),

    update_coords(Move, OldRow, OldColumn, TestRow1, TestColumn1),
    replaceInMatrix(NewBoard, TestRow1, TestColumn1, Player, TestBoard1),

    update_coords(Move, TestRow1, TestColumn1, TestRow2, TestColumn2),
    replaceInMatrix(TestBoard1, TestRow2, TestColumn2, Player, TestBoard2),

    update_coords(Move, TestRow2, TestColumn2, TestRow3, TestColumn3),
    replaceInMatrix(TestBoard2, TestRow3, TestColumn3, Player, FinalBoard).





% Checks if the selected piece's color is correct, taking into account the Player
piece_color(Board, Player, Row, Column, FinalRow, FinalColumn) :-
    getValueFromMatrix(Board, Row, Column, Value),
    Value == Player,
    write('Correct cell selected\n'),
    FinalRow is Row,
    FinalColumn is Column.


% If the selected piece is not the right color, asks for another piece to be selected
piece_color(Board, Player, Row, Column, FinalRow, FinalColumn) :-
    % write(Row), write(Column),
    getValueFromMatrix(Board, Row, Column, Value),
    not(Player == Value),
    write('Selected cell does not contain a piece of the correct color.\n'),
    write('Choose the coords for the cell to move.\n'),
    false.
    % manageRow(CurrentRow), write(CurrentRow),
    % manageColumn(CurrentColumn), write(CurrentColumn),
    % piece_color(Board, Player, CurrentRow, CurrentColumn, FinalRow, FinalColumn).
    

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
validate_boundaries(Board, 'U', 1, CurrentColumn):-
    write('ERROR: That move is not valid! UP\n\n'),
    % write('Row: '), write('1\n'), write('Column: '), write(CurrentColumn), 
    % write('\n'),
    % get_move(M),
    % validate_boundaries(Board, M, 1, CurrentColumn, NewMove).
    false.

validate_boundaries(Board, 'D', 5, CurrentColumn):-
    write('ERROR: That move is not valid! DOWN\n\n'),
    % write('Row: '), write('5\n'), write('Column: '), write(CurrentColumn), 
    % write('\n'),
    % get_move(M),
    % validate_boundaries(Board, M, 5, CurrentColumn, NewMove).
    false.

validate_boundaries(Board, 'R', CurrentRow, 5):-
    write('ERROR: That move is not valid! RIGHT\n\n'),
    % get_move(M),
    % validate_boundaries(Board, M, CurrentRow, 5, NewMove).
    false.

validate_boundaries(Board, 'L', CurrentRow, 1):-
    write('ERROR: That move is not valid! LEFT\n\n'),
    % get_move(M),
    % validate_boundaries(Board, M, CurrentRow, 1, NewMove).
    false.



validate_boundaries_suicide(Board, 'U', 0, CurrentColumn):-
    write('ERROR: That move is not valid! SUICIDE UP\n\n'),
    % write('Row: '), write('1\n'), write('Column: '), write(CurrentColumn), 
    % write('\n'),
    % get_move(M),
    % validate_boundaries(Board, M, 1, CurrentColumn, NewMove).
    false.

validate_boundaries_suicide(Board, 'D', 6, CurrentColumn):-
    write('ERROR: That move is not valid! SUICIDE DOWN\n\n'),
    % write('Row: '), write('5\n'), write('Column: '), write(CurrentColumn), 
    % write('\n'),
    % get_move(M),
    % validate_boundaries(Board, M, 5, CurrentColumn, NewMove).
    false.

validate_boundaries_suicide(Board, 'R', CurrentRow, 6):-
    write('ERROR: That move is not valid! SUICIDE RIGHT\n\n'),
    % get_move(M),
    % validate_boundaries(Board, M, CurrentRow, 5, NewMove).
    false.

validate_boundaries_suicide(Board, 'L', CurrentRow, 0):-
    write('ERROR: That move is not valid! SUICIDE LEFT\n\n'),
    % get_move(M),
    % validate_boundaries(Board, M, CurrentRow, 1, NewMove).
    false.


validate_boundaries(Board, 'U', CurrentRow, CurrentColumn):-
    CurrentRow > 1,
    write('\nACCEPTED MOVE BOUNDARIES\n\n').

validate_boundaries(Board, 'D', CurrentRow, CurrentColumn):-
    CurrentRow < 5,
    write('\nACCEPTED MOVE BOUNDARIES\n\n').

validate_boundaries(Board, 'R', CurrentRow, CurrentColumn):-
    CurrentColumn < 5,
    write('\nACCEPTED MOVE BOUNDARIES\n\n').

validate_boundaries(Board, 'L', CurrentRow, CurrentColumn):-
    CurrentColumn > 1,
    write('\nACCEPTED MOVE BOUNDARIES\n\n').



validate_boundaries_suicide(Board, 'U', CurrentRow, CurrentColumn):-
    CurrentRow > 0,
    write('\nACCEPTED MOVE BOUNDARIES SUICIDE\n\n').

validate_boundaries_suicide(Board, 'D', CurrentRow, CurrentColumn):-
    CurrentRow < 6,
    write('\nACCEPTED MOVE BOUNDARIES SUICIDE\n\n').

validate_boundaries_suicide(Board, 'R', CurrentRow, CurrentColumn):-
    CurrentColumn < 6,
    write('\nACCEPTED MOVE BOUNDARIES SUICIDE\n\n').

validate_boundaries_suicide(Board, 'L', CurrentRow, CurrentColumn):-
    CurrentColumn > 0,
    write('\nACCEPTED MOVE BOUNDARIES SUICIDE\n\n').
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

