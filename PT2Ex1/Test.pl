:-use_module(library(clpfd)).

quadradoMagico(Size):-
    Size == 3,
    Quadrantes = [Q11, Q12, Q13, Q21, Q22, Q23, Q31, Q32, Q33],
    domain(Quadrantes, 1, 9),
    all_distinct(Quadrantes),
    Q11 + Q12 + Q13 #= Sum,
    Q21 + Q22 + Q23 #= Sum,
    Q31 + Q32 + Q33 #= Sum,
    Q11 + Q21 + Q31 #= Sum,
    Q12 + Q22 + Q32 #= Sum,
    Q13 + Q23 + Q33 #= Sum,
    Q11 + Q22 + Q33 #= Sum,
    Q13 + Q22 + Q31 #= Sum,
    Q11 #< Q13, Q11 #< Q31, Q11 #< Q33, Q13 #< Q31,  %Restricoes a simetrias
    labeling([],Quadrantes),
    write(Quadrantes),
    false.


peru:-
    Integers = [I1, I2],
    I1 in 1..9,
    I2 in 0..9,
    (I1 * 1000) + 670 + I2 #= 72 * Num,
    labeling([],Integers),
    write(Integers),
    write(Num).



puzzleSimples(Int, Word1, Word2, Word3):-
    Letras = [S,E,N,D,M,O,R,Y],
    domain(Letras,0,9),
    all_different(Letras),
    S #\= 0, M #\= 0,
    S*1000 + E*100 + N*10 + D + M*1000 + O*100 + R*10 + E #=
    M*10000 + O*1000 + N*100 + E*10 + Y,
    labeling([],Letras),
    write(Letras).

puzzleEficiente(Int, Word1, Word2, Word3):-
 Vars=[S,E,N,D,M,O,R,Y],
 domain(Vars,0,9),
 domain([C1,C2,C3,C4],0,1),
 all_distinct(Vars),
 S #\= 0, M #\= 0,
 D + E #= Y+ C1*10,
 N + R + C1 #= E+ C2*10,
 E + O + C2 #= N+ C3*10,
 S + M + C3 #= O+ C4*10,
 C4 #= M,
 labeling([ff],Vars).


guardas:-
    Vars = [C1,C2,C3,C4,L1,L2,L3,L4,L5,L6,L7,L8],
    domain(Vars, 0, 9),
    C1 + C2 + C3 + C4 + L1 + L2 + L3 + L4 + L5 + L6 + L7 + L8 #= 12,
    C1 + C2 + L1 + L2 #= 5,
    C2 + C3 + L3 + L4 #= 5,
    C3 + C4 + L5 + L6 #= 5,
    C4 + C1 + L7 + L8 #= 5,
    labeling([],Vars),
    write(Vars),
    false.
    