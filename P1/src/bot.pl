
% Game loop for Computer v Computer game mode.
% Board - current game board
% Player1 - color of player 1's disk
% Player2 - color of player 2's disk
game_loop(Board, Player1, Player2, 'C', 'C') :-
    bot_move(Board, Player1, PlayerOneBoard_1, 1),
    bot_move(PlayerOneBoard_1, Player1, PlayerOneBoard_2, 1),
    bot_move(PlayerOneBoard_2, Player2, PlayerTwoBoard_1, 1),
    bot_move(PlayerTwoBoard_1, Player2, PlayerTwoBoard_2, 1),
    game_loop(PlayerTwoBoard_2, Player1, Player2, 'C', 'C').


% Game loop for Player v Computer game mode.
% Board - current game board
% Player1 - color of player 1's disk
% Player2 - color of player 2's disk
game_loop(Board, Player1, Player2, 'P', 'C') :-
    choose_move(Board, Player1, PlayerOneBoard, 'P'),
    bot_move(PlayerOneBoard, Player2, PlayerTwoBoard_1, 1),
    bot_move(PlayerTwoBoard_1, Player2, PlayerTwoBoard_2, 1),
    game_loop(PlayerTwoBoard_2, Player1, Player2, 'P', 'C').

% Bot move. Checks for Game Over, selects a random disk of it's color to move,
% generates random move that is valid for those coordinates and, if it contins a push,
% checks if the push is valid.
% Board - current game state board
% Player - Player which the move belongs to
% NewBoard - New Board, updates after move is executed
bot_move(Board, Player, NewBoard, 1) :-
    display_game(Board),
    sleep(1),
    check_game_over(Board, Winner),
    repeat,
    get_valid_plays(Board, Player, Plays, R, C),
    choose_random_move(Move, Plays),
    validate_push(Board, Player, Move, R, C, Move, NewBoard),
    bot_set_cell(Move, Player, R, C, NewRow, NewCol, Board, NewBoard).


% Executes move and replaces disks after a move is made
% Move - Move to be made
% Player - Player which the move belongs to
% Row - Row of the cell to be changed
% Col - Column of the cell to be changed
% NewRow - Row of the cell to be changed into
% NewCol - Column of the cell to be changed into
% Board - Board previous to move
% NewBoard - Board updated after move
bot_set_cell('U', Player, Row, Col, NewRow, NewCol, Board, NewBoard) :-
    NewRow is Row - 1,
    NewCol is Col,
    replaceInMatrix(Board, Row, Col, empty, TempBoard),
    replaceInMatrix(TempBoard, NewRow, NewCol, Player, NewBoard).

bot_set_cell('D', Player, Row, Col, NewRow, NewCol, Board, NewBoard) :-
    NewRow is Row + 1,
    NewCol is Col,
    replaceInMatrix(Board, Row, Col, empty, TempBoard),
    replaceInMatrix(TempBoard, NewRow, NewCol, Player, NewBoard).

bot_set_cell('R', Player, Row, Col, NewRow, NewCol, Board, NewBoard) :-
    NewRow is Row,
    NewCol is Col + 1,
    replaceInMatrix(Board, Row, Col, empty, TempBoard),
    replaceInMatrix(TempBoard, NewRow, NewCol, Player, NewBoard).

bot_set_cell('L', Player, Row, Col, NewRow, NewCol, Board, NewBoard) :-
    NewRow is Row,
    NewCol is Col - 1,
    replaceInMatrix(Board, Row, Col, empty, TempBoard),
    replaceInMatrix(TempBoard, NewRow, NewCol, Player, NewBoard).


% Returns valid plays in variable Plays, for a given player in a given position
% Board - current board
% Player - current player
% Plays - possible plays to be made
% R - row of current disk
% C - column of current disk
get_valid_plays(Board, Player, Plays, R, C) :-
    getValidCoords(Board, R, C, Player),
    findall(Move, validate_play(Board, Move, Player, R, C, Move, _, _), Plays).


% Validates a play for a bot. Checks if boundaries are not directly passed,
% and checks if it can push a row of disks, it they are aligned.
% Board - current board
% Move - move to be made
% Player - current player
% ValidatedRow - row that has been validated after a valid move has beem picked
% ValidatedColumn - column that has been validated after a valid move has beem picked
% FinalBoard - Board to be returned, with updated cells
validate_play(Board, Move, Player, ValidatedRow, ValidatedColumn, NewMove, NewerMove, FinalBoard) :-
    validate_boundaries(Board, Move, ValidatedRow, ValidatedColumn),
    validate_push(Board, Player, NewMove, ValidatedRow, ValidatedColumn, NewerMove, FinalBoard).


% Gets valid coordinates for a disk of a player
% Board - current board
% R - row of cell to be returned
% C - column of cell to be returned
% Player - current player
getValidCoords(Board, R, C, Player):-
    random(1,7,Row),
    random(1,7,Col),
    getValueFromMatrix(Board, Row, Col, Val),
    R is Row,
    C is Col,
    Val == Player.


getValidCoords(Board, R, C, Player):-
    random(1,7,Row),
    random(1,7,Col),
    getValueFromMatrix(Board, Row, Col, Val),
    not(Val == Player),
    getValidCoords(Board, R, C, Player).



% Chooses random move from valid plays
% Member - chosem move
% Plays - list of valid plays
choose_random_move(Member, Plays) :-
    random_member(Member, Plays).


% Checks if game is over for a given state board
% Board - current state board
check_game_over(Board) :-
    check_row(Board, 0),
    check_column(Board).


check_column([]) :-
    true.

check_column([H|T]) :-
    check_vertical(H),
    check_column(T).

check_vertical(List) :-
    \+ nth0(0, List, black),
    \+ nth0(0, List, white),
    \+ nth0(6, List, black),
    \+ nth0(6, List, white).

check_vertical(List) :-
    nth0(0, List, black),
    write('GAME OVER\n'),
    halt(0).  
    
check_vertical(List) :-
    nth0(0, List, white),
    write('GAME OVER\n'),    
    halt(0).  

check_vertical(List) :-
    nth0(6, List, black),
    write('GAME OVER\n'),
    halt(0).    

check_vertical(List) :-
    nth0(6, List, white),
    write('GAME OVER\n'),
    halt(0).



check_row([H|T], Index) :-
    Index == 0,
    check_horizontal(H),
    get_last_row([H|T], 0, Row).


check_horizontal(List) :-
    member(white, List),
    write('Game Over!!!'), 
    halt(0).   
    
check_horizontal(List) :-
    member(black, List),   
    write('Game Over!!!'),  
    halt(0).   

% Black cell. Game Over!
check_horizontal(List) :-
    \+ member(black, List),  
    \+ member(white, List).

get_last_row([H|T], Index, Row) :-
    Index < 6,
    NewIndex is Index + 1,
    get_last_row(T, NewIndex, Row).

get_last_row([H|T], Index, Row) :-
    Index == 6,
    Row = H,
    check_horizontal(Row).


get_last_row([], Index, Row).

