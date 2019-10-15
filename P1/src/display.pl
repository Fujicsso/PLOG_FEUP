% create cell atoms

cell(whiteDisc).
cell(blackDisc).
cell(empty).

displayGameName :-
    write('     / $$    $$                | $$                          '), nl,  
    write('     | $$$ | $$                | $$                          '), nl,
    write('     | $$$$| $$  $$  / $$   $$$$$$$  $$$$$$    $$$$$$        '), nl,
    write('     | $$ $$ $$| $$  | $$ |$$__  $$ |$$__  $$ |$$__  $$      '), nl,
    write('     | $$  $$$$| $$  | $$| $$  | $$| $$  | $$| $$$$$$$$      '), nl,
    write('     | $$|  $$$| $$  | $$| $$  | $$| $$  | $$| $$_____|      '), nl,
    write('     | $$ |  $$|  $$$$$$||  $$$$$$$|  $$$$$$$|  $$$$$$$      '), nl,
    write('     |__|  |__| |______|  |_______| |____  $$ |_______|      '), nl,
    write('                                    |$$  | $$                '), nl,
    write('                                   |  $$$$$$|                '), nl,
    write('                                    |______|                 '), nl, nl.