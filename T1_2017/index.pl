:- consult('info.pl').

achievedALot(Player) :-
    played(Player, _,_,Percentage),
    Percentage > 80.

isAgeAppropriate(Name, Game) :-
    player(Name, _, PlayerAge),
    game(Game, _, GameAge),
    PlayerAge > GameAge.

% timePlayingGames(Player, Games, ListOfTimes, SumTimes) :-
%     aux(Player, Games, ListOfTimes)
    
    
% aux(Player, [Game|Rest], ListOfTimes) :-
%     played(Player, Game, HoursPlayed,_),
%     aux(Player, Rest, NewList),
%     append()
    
    
% aux(Player, [Game|Rest], ListOfTimes) :-

listGamesOfCategory(Cat) :-
    game(Name, Category, MinAge),
    member(Cat, Category),
    write(Name), write(' ('), write(MinAge), write(')'), nl.

listGamesOfCategory(_).

updatePlayer(Player, Game, Hours, Percentage) :-
    played(Player, Game, OldHours, OldPercentage),
    retract(played(Player, Game, OldHours, OldPercentage)),
    NewHours is OldHours + Hours,
    NewPercentage is OldPercentage + Percentage,
    assert(played(Player, Game, NewHours, NewPercentage)).

updatePlayer(Player, Game, Hours, Percentage) :-
    assert(played(Player, Game, Hours, Percentage)).



fewHours(Player, Games) :-
    aux(Player, [], Games).


aux(Player, L, Games) :-
    played(Player, Game, Hours,_),
    Hours < 10,
    \+ member(Game, L),
    aux(Player, [Game|L], Games).

aux(Player, L, Games) :-
    Games = L.


ageRange(MinAge, MaxAge, Players) :-
    findall(Player, checkAge(MinAge, MaxAge, Player), Players).

checkAge(MinAge, MaxAge, Player) :-
    player(Player, _, Age),
    Age =< MaxAge,
    Age >= MinAge.

averageAge(Game, AverageAge) :-
    findall(Age, getAge(Game, Age), Result),
    aux(Result, SumOfHours),
    length(Result, Len),
    AverageAge is SumOfHours / Len.


getAge(Game, Age) :-
    played(Player, Game,_,_),
    player(_, Player, Age).
    
aux([], 0).
    
aux([H|T], Sum) :- 
    aux(T, NewSum),
    Sum is NewSum + H.

