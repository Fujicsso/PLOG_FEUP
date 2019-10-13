livro(os_maias).
livro(memorial_do_convento).

autor(eca).

nacionalidade(portugues).
nacionalidade(ingles).

tipo(romance).
tipo(ficcao).


tem_nacionalidade(eca, portugues).

escreveu(eca, os_maias).
escreveu(eca, memorial_do_convento).

tipo_livro(os_maias, romance).
tipo_livro(memorial_do_convento, ficcao).


portugues_ecreve_romance(Autor) :-
    autor(Autor),
    escreveu(Autor, Livro),
    tipo_livro(Livro, Tipo),
    Tipo = romance.

autor_ecreve_ficcao(Autor) :-
    autor(Autor),
    escreveu(Autor, Livro),
    tipo_livro(Livro, Tipo),
    Tipo = ficcao.

autor_escreve_nao_ficcao(Autor) :-
    escreveu(Autor, Livro2),
    tipo_livro(Livro2, Tipo2),
    Tipo2 \= ficcao.

autor_ficcao_e_outro_tipo(Autor) :-
    autor_ecreve_ficcao(Autor),
    autor_escreve_nao_ficcao(Autor).


% Exercicios:
% a - escreveu(X, os_maias).
% b - portugues_ecreve_romance(Autor).
% c - autor_ficcao_e_outro_tipo(Autor).
