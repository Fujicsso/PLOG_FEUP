:- consult('info.pl').

made_it_through(Participant) :-
    performance(Participant, Times),
    \+ button_pressed(Times).

button_pressed([]).

button_pressed([H|T]) :-
    H < 120,
    button_pressed(T).


% juriTimes(Participants, JuriMember, Times, Total) :-
%     jTimes(Participants, JuriMember, Times), 
%     getTotal(Times, Total).

% jTimes([], _, _).

% jTimes([P|T], JuriMember, Time) :-
%     performance(P, Performance), 
%     getValue(Performance, JuriMember, T2),
%     jTimes(T, JuriMember, T1),
%     append([T2], T1, Time).
    
% getValue([P|_], 1, P).

% getValue([_|T], JuriMember, Value):-
%     NextJuri is JuriMember-1,
%     getValue(T, NextJuri, V1),
%     Value is V1.

% getTotal([], 0).

% getTotal([T|T1], Total) :-
%     getTotal(T1, Tot),
%     Total is Tot + T.


% patientJuri(JuriMember) :-
%     aux(JuriMember).

% aux(JuriMember) :-
%     performance(Id, ButtonTimes),



nSuccessfulParticipants(T) :-
    setof(X, aux(X), L),
    length(L, T).
    

aux(Participant) :-
    performance(Participant, ButtonPressedTimes),
    check_button_presses(ButtonPressedTimes, 0, Final),
    Final == 4.

check_button_presses([], Number, Final) :-
    Final is Number.

check_button_presses([120|T], Number, Final) :-
    NewNumber is Number + 1,
    check_button_presses(T, NewNumber, Final).

check_button_presses([_|T], Number, Final) :-
    check_button_presses(T, Number, Final).


