% ==========================================
% 1. Factorial Recursivo
% ==========================================
factorial(0, 1) :- !.
factorial(N, R) :-
    N > 0,
    N1 is N - 1,
    factorial(N1, R1),
    R is N * R1.

% ==========================================
% 2. Suma de Elementos de una Lista
% ==========================================
suma_lista([], 0).
suma_lista([Cabeza | Cola], Suma) :-
    suma_lista(Cola, Resto),
    Suma is Cabeza + Resto.

% ==========================================
% 3. Representación y Pertenencia en Árboles
% Estructura: arbol(Valor, Izquierda, Derecha)
% ==========================================
en_arbol(X, arbol(X, _, _)).
en_arbol(X, arbol(_, I, _)) :- en_arbol(X, I).
en_arbol(X, arbol(_, _, D)) :- en_arbol(X, D).

% ==========================================

% Factorial recursivo (factorial/2)   
% - Consulta: 
%     factorial(5, X).   
% - Resultado: 
%     X = 120.   
%
% Suma de elementos de una lista (suma_lista/2)   
% - Consulta:
%      suma_lista([1, 2, 3, 4, 5], X).   
% - Resultado:    
%      X = 15.   
%
% Generación de elementos con member/2   
% - Consulta:
%      member(X, [rojo, verde, azul]).   
% - Resultado:
%      X = rojo ; X = verde ; X = azul.   
%
% Búsqueda en un árbol binario (en_arbol/2)   
% - Consulta: 
%     T = arbol(10, arbol(5, vacio, vacio), arbol(15, vacio, vacio)), en_arbol(5, T).  
% - Resultado: 
%     true.  

% ==========================================--