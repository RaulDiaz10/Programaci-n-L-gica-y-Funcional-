% ------ BASE DE CONOCIMIENTO (HECHOS)

% juega_en(jugador, equipo).
juega_en(vinicius, real_madrid).
juega_en(mbappe, real_madrid).
juega_en(bellingham, real_madrid).
juega_en(courtois, real_madrid).
juega_en(lewandowski, barcelona).
juega_en(lamine_yamal, barcelona).
juega_en(haaland, man_city).
juega_en(de_bruyne, man_city).
juega_en(foden, man_city).
juega_en(messi, inter_miami).
juega_en(cristiano, al_nassr).

% nacionalidad(jugador, pais).
nacionalidad(vinicius, brasil).
nacionalidad(mbappe, francia).
nacionalidad(bellingham, inglaterra).
nacionalidad(courtois, belgica).
nacionalidad(lewandowski, polonia).
nacionalidad(lamine_yamal, espana).
nacionalidad(haaland, noruega).
nacionalidad(de_bruyne, belgica).
nacionalidad(foden, inglaterra).
nacionalidad(messi, argentina).
nacionalidad(cristiano, portugal).

% posicion(jugador, posicion_campo).
posicion(vinicius, delantero).
posicion(mbappe, delantero).
posicion(haaland, delantero).
posicion(messi, delantero).
posicion(cristiano, delantero).
posicion(lewandowski, delantero).
posicion(lamine_yamal, delantero).
posicion(bellingham, mediocampista).
posicion(de_bruyne, mediocampista).
posicion(foden, mediocampista).
posicion(courtois, portero).

% compite_en(equipo, liga).
compite_en(real_madrid, la_liga).
compite_en(barcelona, la_liga).
compite_en(man_city, premier_league).
compite_en(inter_miami, mls).
compite_en(al_nassr, saudi_pro_league).


% ==========================================
% REGLAS LÓGICAS
% En Prolog: 
% La coma ( , ) significa AND.
% El punto y coma ( ; ) significa OR.
% ==========================================

% 1. Compañeros de equipo (juegan en el mismo equipo y no son la misma persona)
% TIPO: Regla con AND (Conjunción) y operador de Desigualdad (\=)
% Ej. companero_equipo(vinicius, Quien).
companero_equipo(X, Y) :- 
    juega_en(X, Equipo), 
    juega_en(Y, Equipo), 
    X \= Y.

% 2. Compatriotas (tienen la misma nacionalidad)
% TIPO: Regla con AND (Conjunción) y operador de Desigualdad (\=)
% Ej. compatriota(de_bruyne, courtois)
compatriota(X, Y) :- 
    nacionalidad(X, Pais), 
    nacionalidad(Y, Pais), 
    X \= Y.

% 3. Juegan en la misma liga
% TIPO: Regla encadenada con multiples AND (Conjunción multiple)
% Ej. misma_liga(vinicius, lewandowski)
misma_liga(X, Y) :- 
    juega_en(X, Equipo1), 
    juega_en(Y, Equipo2), 
    compite_en(Equipo1, Liga), 
    compite_en(Equipo2, Liga), 
    X \= Y.

% 4. Rivales directos (juegan en la misma liga pero en distintos equipos)
% TIPO: Regla Compuesta (Llama a otra regla que ya creamos "misma_liga") usando AND
% Ej. rival_directo(vinicius, lewandowski)
rival_directo(X, Y) :- 
    misma_liga(X, Y), 
    juega_en(X, Equipo1), 
    juega_en(Y, Equipo2), 
    Equipo1 \= Equipo2.

% 5. Es delantero de un equipo específico
% TIPO: Regla con AND (Conjunción básica)
% Ej. delantero_de(vinicius, real_madrid)
delantero_de(Jugador, Equipo) :- 
    juega_en(Jugador, Equipo), 
    posicion(Jugador, delantero).

% 6. Es mediocampista de un equipo específico
% TIPO: Regla con AND (Conjunción básica)
% Ej. mediocampista_de(bellingham, real_madrid).
mediocampista_de(Jugador, Equipo) :- 
    juega_en(Jugador, Equipo), 
    posicion(Jugador, mediocampista).

% 7. Es sudamericano (según los países registrados en esta base)
% TIPO: Regla con OR (Disyunción)
% Ej. sudamericano(vinicius).
sudamericano(Jugador) :- 
    nacionalidad(Jugador, brasil) ; 
    nacionalidad(Jugador, argentina).

% 8. Es europeo (según los países registrados en esta base)
% TIPO: Regla con multiples OR (Disyunción encadenada)
% Ej. europeo(mbappe).
europeo(Jugador) :- 
    nacionalidad(Jugador, francia) ; 
    nacionalidad(Jugador, inglaterra) ; 
    nacionalidad(Jugador, belgica) ; 
    nacionalidad(Jugador, noruega) ; 
    nacionalidad(Jugador, portugal) ; 
    nacionalidad(Jugador, polonia) ; 
    nacionalidad(Jugador, espana).

% 9. Juega en Europa (su equipo compite en una liga europea de esta base)
% TIPO: Regla Combinada (Usa AND y agrupa varios OR entre paréntesis)
% Ej. juega_en_europa(vinicius).
juega_en_europa(Jugador) :- 
    juega_en(Jugador, Equipo), 
    (compite_en(Equipo, la_liga) ; compite_en(Equipo, premier_league)).

% 10. Conexión total (son compañeros de club Y también de selección/país)
% TIPO: Regla Compuesta con AND (Une dos reglas definidas previamente)
% Ej. conexion_total(vinicius, mbappe).
conexion_total(X, Y) :- 
    companero_equipo(X, Y), 
    compatriota(X, Y).

% ==========================================
% REGLA RECURSIVA

% 11. Red de conocidos en el fútbol (Un jugador conoce a otro si juegan juntos, 
%     o si conoce a alguien que juega con ese otro jugador).
% TIPO: Regla RECURSIVA (La regla se llama a sí misma dentro de su definición)

% Caso Base (Condición de salida): Se conocen porque son compañeros directos.
conoce_a(X, Y) :- 
    companero_equipo(X, Y).

% Caso Recursivo: X conoce a Y si X es compañero de Z, y Z "conoce_a" Y.
conoce_a(X, Y) :- 
    companero_equipo(X, Z), 
    conoce_a(Z, Y).

% Ej. conoce_a(vinicius, lewandowski). 