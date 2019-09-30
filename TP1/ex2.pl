pilot(lamb).
pilot(besenyei).
pilot(chambliss).
pilot(maclean).
pilot(mangold).
pilot(jones).
pilot(bonhomme).

pilot_team(lamb, breitling).
pilot_team(besenyei, red_bull).
pilot_team(chambliss, red_bull).
pilot_team(maclean, mediterranian_racing).
pilot_team(mangold, cobra).
pilot_team(jones, matador).
pilot_team(bonhomme, matador).

pilot_plane(lamb, mx2).
pilot_plane(besenyei, edge540).
pilot_plane(chambliss, edge540).
pilot_plane(maclean, edge540).
pilot_plane(mangold, edge540).
pilot_plane(jones, edge540).
pilot_plane(bonhomme, edge540).

circuit(instambul).
circuit(budapest).
circuit(porto).

pilot_won(jones, porto).
pilot_won(mangold, instambul).
pilot_won(mangold, budapest).

gates(instambul, 9).
gates(budapest, 6).
gates(porto, 5).

team_won(Team, Track) :-
    pilot_team(Pilot, Team),
    pilot_won(Pilot, Track).

pilot_won_two_tracks(Pilot) :-
    pilot_won(Pilot, Track1),
    pilot_won(Pilot, Track2),
    Track1 \= Track2.

track_has_at_least_8_gates(Track) :-
    gates(Track, NrGates),
    NrGates >= 8.

pilot_doesnt_have_edge540(Pilot) :-
    pilot_plane(Pilot, Plane),
    Plane \= edge540.