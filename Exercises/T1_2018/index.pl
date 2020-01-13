:- consult('info.pl').


short(Flight) :-
    flight(Flight,_,_,_, Duration,_),
    Duration < 90.

shorter(Flight1, Flight2, Result) :-
    flight(Flight1,_,_,_, Duration1,_),
    flight(Flight2,_,_,_, Duration2,_),
    Duration1 < Duration2,
    Result = Flight1.

shorter(Flight1, Flight2, Result) :-
    flight(Flight1,_,_,_, Duration1,_),
    flight(Flight2,_,_,_, Duration2,_),
    Duration1 > Duration2,
    Result = Flight2.


arrivalTime(Flight, ArrivalTime, Extra) :-
    flight(Flight, _, _, DepartureTime, Duration, _),
    OriginalHours is DepartureTime // 100,
    OriginalMinutes is DepartureTime mod 100,
    NewMinutes is OriginalMinutes + Duration,
    NewHours is OriginalHours + NewMinutes // 60,
    FinalMinutes is NewMinutes mod 60,
    ArrivalTime is NewHours * 100 + FinalMinutes.


operates(Company, Country) :-
    company(Company,_,_,_),
    flight(_, Id, _, _, _, Company),
    airport(_,Id, Country).


operates(Company, Country) :-
    company(Company,_,_,_),
    flight(_, _, Id, _, _, Company),
    airport(_,Id, Country).

countries(Company, List) :-
    aux(Company, [], List).


aux(Company, U, List) :-
    operates(Company, Country),
    \+ (member(Country, U)),
    aux(Company, [Country|U], List).

aux(_, List, List).
    



% pairableFlights :-
%     flight(Id1,_, Airport, DepartureTime1, Duration, _),
%     flight(Id2, Airport,_, DepartureTime2, _, _),
%     arrivalTime90(Id1, T90),
%     arrivalTime30(Id1, T30),
%     DepartureTime2 < T90,
%     DepartureTime1 < T30,
%     write(Airport), write(' - '), write(Id1), write(' / '), write(Id2), nl.

