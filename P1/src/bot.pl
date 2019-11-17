gamePvC(Board, Player1, Player2) :-
    write('Starting Game!\n'),
	game_loop(Board, Player1, Player2, 'P', 'C').


gameCvC(Board, Player1, Player2) :-
    write('Starting Game!\n'),
	game_loop(Board, Player1, Player2, 'C', 'C').

game_loop(Board, Player1, Player2, 'C', 'C') :-
    bot_move(Board, Player1, PlayerOneBoard_1, 1),
    bot_move(PlayerOneBoard_1, Player1, PlayerOneBoard_2, 1),
    bot_move(PlayerOneBoard_2, Player2, PlayerTwoBoard_1, 1),
    bot_move(PlayerTwoBoard_1, Player2, PlayerTwoBoard_2, 1),
    game_loop(PlayerTwoBoard_2, Player1, Player2, 'C', 'C').

%easy bot
bot_move(Board, Player, NewBoard, 1) :-
    write('\nPlayer '), write(Player), write(' Turn!\n'),
    display_game(Board),
    sleep(1),
    check_game_over(Board, Winner),
    repeat,
    get_valid_plays(Board, Player, Plays, R, C),
    choose_random_move(Move, Plays),
    validate_push(Board, Player, Move, R, C, Move, NewBoard),
    bot_set_cell(Move, Player, R, C, NewRow, NewCol, Board, NewBoard).


%hard bot
% bot_move(Board, Player, NewBoard, 2) :-
%     display_game(Board),
%     repeat,
%     get_valid_plays(Board, Player, Plays, R, C).

% check_end_game(Board, [], R, C).

% check_end_game(Board, [H|T], R, C) :-
%     checkmate(Board, H, R, C).


% checkmate(Board, H, R, C) :-
    




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



get_valid_plays(Board, Player, Plays, R, C) :-
    getValidCoords(Board, R, C, Player),
    findall(Move, validate_play(Board, Move, Player, R, C, Move, _, _), Plays).
    % show_records(Plays), write('\n').


validate_play(Board, Move, Player, ValidatedRow, ValidatedColumn, NewMove, NewerMove, FinalBoard) :-
    validate_boundaries(Board, Move, ValidatedRow, ValidatedColumn),
    validate_push(Board, Player, NewMove, ValidatedRow, ValidatedColumn, NewerMove, FinalBoard).



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



choose_random_move(Member, Plays) :-
    random_member(Member, Plays).


check_game_over(Board) :-
    check_row(Board, 0),
    check_column(Board).


check_column([]) :-
    true.

check_column([H|T]) :-
    check_vertical(H),
    check_column(T).

%TRUE IF GAMEOVER. Looks for black cell
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



% First row
check_row([H|T], Index) :-
    Index == 0,
    write(Index),
    check_horizontal(H),
    get_last_row([H|T], 0, Row).


% White cell. Game Over!
check_horizontal(List) :-
    member(white, List),
    write('Game Over!!!'),   %TRUE IF GAME OVER
    halt(0).   
    
    % Black cell. Game Over!
check_horizontal(List) :-
    member(black, List),   %TRUE IF GAME OVER
    write('Game Over!!!'),   %TRUE IF GAME OVER
    halt(0).   

% Black cell. Game Over!
check_horizontal(List) :-
    \+ member(black, List),   %TRUE IF GAME OVER
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


show_records([]).

show_records([A|B]) :-
    write(A), write(' . '),
    show_records(B).
