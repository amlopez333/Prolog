% -- cabeza/2(+X,-Z): retorna la cabeza de la lista
%	X: Lista
%	Z: variable libre
cabeza([H|_],H).
% -- indexOf/3(+X,+Y,-Z): Retorna el indice del elemento Y en X
%	X: Lista
%	Y: atomo
%	Z: variable libre
indexOf([Elemento|_], Elemento, 0):- !.
indexOf([_|Cola], Elemento, Index):-
  indexOf(Cola, Elemento, Index1),
  !,
  Index is Index1+1.

% -- girar/3(+X,+Y,-Z): gira la lista X una cantidad Y de veces
%	X: lista
%	Y: atomo
%	Z: variable libre
girar(List,0,List) :-
!.

girar([H|T],X,R) :-
	X > 0,
	Y is X-1,
	append(T,[H], Nlist),
	girar(Nlist, Y, R).

% -- girarEngranajes/5(+X,+Y,+C,-W,-Z): Gira la lista X hasta que su cabeza sea C. 
% -- Gira la lista Y la cantidad de veces que giró X.
%	X: Lista
%	Y: Lista 
%   C: atomo
%   W: atomo
%	Z: variable libre
girarEngranajes(L1, L2, Cabeza, R1, R2) :-
	indexOf(L1, Cabeza, I),
	girar(L1, I, R1),
	girar(L2, I, R2).

% -- encr/7(+X,+Y,+C,+W,-Z,+O,-P): Auxiliar para encriptacion. 
% -- 
%	X: Lista
%	Y: Lista 
%   C: Lista
%   W: Lista
%	Z: variable libre
%   O: Lista
%   P: variable libre
encr([], _, _, Enc, Enc, Pares, Pares) :- 
!.

encr([He|Hz], Ae, As, Enc2, Enc, _, Pares) :-
	girarEngranajes(Ae, As, He, [R1|R1z], [R2|R2z]),
	append(R1z, [R1], Aen),
	append(R2z, [R2], Asn),
	salida(R2, Enc2, Enc3),
	encr(Hz, Aen, Asn, Enc3, Enc, [R1,R2], Pares).

% -- salida/3(+X,+Y,-Z): Crea una lista X de valores Y. 
% -- Gira la lista Y la cantidad de veces que giró X.
%	X: Atomo
%	Y: Lista 
%	Z: variable libre
salida(V, L, L2) :-
	append(L, [V], L2).


% -- encripta/5(+X,+Y,+C,-W,-Z): Encripta la hilera X. 
%	X: Lista
%	Y: Lista 
%   C: Lista
%   W: Variable Libre
%	Z: variable libre
encriptar(He, Ae, As, Enc, Par) :-
	encr(He, Ae, As, [], Enc, [], Par).

% -- decripta/5(+X,+Y,+C,+W,-Z): Decripta la hilera X. 
%	X: Lista
%	Y: Lista 
%   C: Lista
%   W: Lista
%	Z: variable libre
decriptar(He, Ae, As, [Ef|Efz], Es) :-
    indexOf(Ae, Ef, I1),
    girar(Ae, I1, R1),
    cabeza(Efz, Efz2),
    indexOf(As, Efz2, I2),
    girar(As, I2, R2),
    decr(He, R1, R2, [], Es).

% -- decr/5(+X,+Y,+C,+W,-Z): Auxiliar para decriptar. 
%	X: Lista
%	Y: Lista 
%   C: Lista
%   W: Lista
%	Z: variable libre
decr([], _, _, Es, Es) :- 
!.

decr([He|Hz], Ae, As, Es2, Es) :-
	girarEngranajes(Ae, As, He, [R1|R1z], [R2|R2z]),
    append(R1z, [R1], Aen),
	append(R2z, [R2], Asn),
	salida(R2, Es2, Es3),
	decr(Hz, Aen, Asn, Es3, Es).
	
	
/*producto cartesiano*/
% -- pares/3(+A,+C,Z): Z corresponde los pares ordenados formados con elementos de A con elementos de C
%	A, C: listas
%	Z: variable libre
pares([A|_],[C|_],Z):- Z=[A,C].
pares([A|B],[_|D],Z):- pares([A|B],D,Z).

% -- cartesiano/3(+X,+Y,-Z): Z son los productos cartesianos de X con Y
%	X, Y: listas
%	Z: variable libre
cartesiano([],_,_).
cartesiano([A|B],[C|D],Z):-   pares([A|B],[C|D],Z);
                            cartesiano(B,[C|D],Z).


/*potencia*/
% -- potencia/2(+X,-Z): Z son los elementos del conjunto potencia de la lista X
%	X: lista
%	Z: variable libre
potencia([],[]).
potencia([_|T], P):- potencia(T,P).
potencia([H|T], [H|P]):- potencia(T,P).


/*bpp*/
% -- bpp/3(+X,+Y,-Z): realiza la busqueda del subarbol "Z" de Y cuya raíz es X
%	X: atomo
%	Y: lista con sublistas (arbol)
%	Z: variable libre
bpp(_,[],S):- S=[],!.
bpp(X,[H|T],S):- (
    X==H -> write(H), write('\n'), S=[H|T],!;
            pr(X,[H|T],S)
).

% -- pr/3(+X,+Y,-Z): auxiliar para encontrar el subarbol de Y cuya raíz es X ( busqueda a partir del segundo elemento de la lista)
%	X: atomo
%	Y: lista (con sublistas)
%	Z: variable libre
pr(_,[],_).
pr(X,[H|T],S):-
    atom(H),(nonvar(S) -> 
                true,!;
                write(H), write(' ')
            ),
            (X==H -> 
                S=H,write('\n'),true;
                pr(X,T,S),!
            ),!;
    compound(H),(primero(X,H) ->
                    write(X),
                    S=H;
                    pr(X,H,S),
                    pr(X,T,S),
                    (nonvar(S) -> true,!;
                                    S=[]
                    )
                ).

% -- primero/2(+X,+Y): chequea si el primer elemento de Y es igual (unificable) a X
%	X: atomo
%	Y: lista
primero(X,[H|_]):-
    (
        X==H -> true;
                false
    ).
	

listaP([]).
listaP([_|Y]):-
	listaP(Y).

bapAux(N, [N|_], N, Cola) :-
    append(Cola, [N], Cola2),
	print(Cola2), !.
bapAux(N, [A|C], S, Cola):-
	listaP(A),
	bapAux(N, A, S, Cola).
bapAux(N, [A|C], S, [Cola|_]):-
    print(Cola),
	bapAux(N, C, S, [A]).
bap(N, [A|C], S):-
	bapAux(N, C, S, [A]).
