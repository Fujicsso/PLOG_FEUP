:- use_module(library(clpfd)).


% count_equals(Val, [H|T], Count) :-
%     aux(Val, [H|T], C).
    
    
% aux(Val, [H|T], C) :-
%     (Val #= H) #<=> B,
%     aux(V, T, C2), C #= C2+B.

first_car :-
    length(Tam, 4), domain(Tam, 1, 4), all_distinct(Tam),    
    length(Pos, 4), domain(Pos, 1, 4), all_distinct(Pos),
    element(3, Tam, 1),
    element(3, Pos, PV), element(1, Pos, PA), PV #> PA,    
    element(2, Pos, PAm), element(4, Pos, PP), PAm #> PP,    
    PAA #= PA-1, PDA #= PD+1, element(CAA, Pos, PAA), element(CDA, Pos, PDA),
    element(CAA, Tam, TAA), element(CDA, Tam, TDA), TAA #< TDA,
    append(Tam, Pos, Vars), labeling([], Vars), write(Pos).

% car_list :-
%     % [Amarelo1, Amarelo2, Amarelo3, Amarelo4, Verde1, Verde2, Vermelho1, Vermelho2, Vermelho3, Azul1, Azul2, Azul3]
%     length(L, 12), domain(L,1,12),
%     global_cardinality(L, [1-3,2-4,3-2,4-3]),
%     element(1,L,CPU), element(12,L,CPU),
%     element(2,L,CSP), element(11,L,CSP),
%     element(5, L, 1),
%     tres(L), quatro(L, 1),
%     labeling([], L).


% tres([_,_]).

% tres([A,B,C|T]) :-
%     all_distinct([A,B,C]),
%     tres([B,C|T]).    

% quatro([_,_,_], 0).

% quatro([A,B,C,D|T], N) :-
%     quatro([B,C,D|T], N2),
%     N #= N2+V,
%     (A #= 2 #/\ B #= 3 #/\ C#= 4 #/\ D #= 1) #<=> V.

