member(X,[X|_]).

member(X, [_|L]) :-
    member(X, L).