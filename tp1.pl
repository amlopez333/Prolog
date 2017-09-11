cabeza([H|_],H).
indexOf([Elemento|_], Elemento, 0):- !.
indexOf([_|Cola], Elemento, Index):-
  indexOf(Cola, Elemento, Index1),
  !,
  Index is Index1+1.

girar(List,0,List) :-
!.

girar([H|T],X,R) :-
	X > 0,
	Y is X-1,
	append(T,[H], Nlist),
	girar(Nlist, Y, R).

girarEngranajes(L1, L2, Cabeza, R1, R2) :-
	indexOf(L1, Cabeza, I),
	girar(L1, I, R1),
	girar(L2, I, R2).

encr([], _, _, Enc, Enc, Pares, Pares) :- 
!.

encr([He|Hz], Ae, As, Enc2, Enc, ParN, Pares) :-
	girarEngranajes(Ae, As, He, [R1|R1z], [R2|R2z]),
	append(R1z, [R1], Aen),
	append(R2z, [R2], Asn),
	salida(R2, Enc2, Enc3),
	encr(Hz, Aen, Asn, Enc3, Enc, [R1,R2], Pares).

salida(V, L, L2) :-
	append(L, [V], L2).

creaPar(V1, V2, L1, L2) :-
	append(L1, [V1, V2], L2).


encriptar(He, Ae, As, Enc, Par) :-
	encr(He, Ae, As, [], Enc, [], Par).

decriptar(He, Ae, As, [Ef|Efz], Es) :-
    indexOf(Ae, Ef, I1),
    girar(Ae, I1, R1),
    print(R1),
    cabeza(Efz, Efz2),
    indexOf(As, Efz2, I2),
    girar(As, I2, R2),
    print(R2),
    decr(He, R1, R2, [], Es).
    
decr([], _, _, Es, Es) :- 
!.

decr([He|Hz], Ae, As, Es2, Es) :-
	girarEngranajes(Ae, As, He, [R1|R1z], [R2|R2z]),
    append(R1z, [R1], Aen),
	append(R2z, [R2], Asn),
	salida(R2, Es2, Es3),
	decr(Hz, Aen, Asn, Es3, Es).