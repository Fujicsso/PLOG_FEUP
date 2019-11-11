% -----------CHANGES CURRENT PLAYER------------ 

changePlayer('O ', 'X ').
changePlayer('X ', 'O ').

% ------- 

play(Position, Player, Result):-
    getMovePlayer(Move1,Again),