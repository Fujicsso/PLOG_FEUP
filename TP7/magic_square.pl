:-use_module(library(clpfd)).


% magic_square :-
%     V=[A,B,C,
%        D,E,F,
%        G,H,I],
%     all_distinc(V),
%     domain(V, 1, 9),
%     A+B+C #= S,
%     D+E+F #= S,
%     G+H+I #= S,
%     A,D,G #= S,
%     B,E,H #= S,
%     C,F,I #= S,
%     A,E,I #= S,
%     C,E,G #= S,
%     labeling([], V),
%     write(V).

% turkey_price :-
%     domain(A,1,9),
%     domain(B,0,9),
%     T #= A*1000 + 670 + B,
%     T #= 72*PPP,
%     labeling([], [A,B,PPP]).

% criptogram(Values) :-
%     Values = [S,E,N,D,M,O,R,Y],
%     domain(Values, 0, 9),
%     all_distinct(Values),
%     S*1000 + E*100 + N*10 + D + M*1000 + O*100 + R*10 + E #= M*10000 + O*1000 + N*100 + E*10 + Y,
%     labeling([], Values).


guardas(Values) :-
    Values = [A,B,C,D,E,F,G,H,I,J,K,L],
    A+B+C+D #= 5,
    D,E,F,G #= 5,
    G+H+I+J #= 5,
    J+K+L+A #= 5,
    A+B+C+D+E+F+G+H+I+J+K+L #= 12,
    labeling([], Values).


