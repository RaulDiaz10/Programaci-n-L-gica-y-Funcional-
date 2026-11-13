% ==========================================
% ESTUDIANTES Y MATERIAS
% ==========================================

% estudiante(Nombre).
estudiante(ana).
estudiante(luis).
estudiante(carlos).
estudiante(sofia).

% materia(NombreMateria).
materia(programacion).
materia(matematicas).
materia(estructuras_datos).
materia(base_datos).
materia(ia).

% aprobo(Estudiante, Materia).
% Consulta de prueba: ¿Qué materias ha aprobado Carlos? 
% ?- aprobo(carlos, Materia).
aprobo(ana, programacion).
aprobo(ana, matematicas).
aprobo(ana, estructuras_datos).
aprobo(luis, programacion).
aprobo(carlos, programacion).
aprobo(carlos, matematicas).

% prerrequisito(Materia, PrerrequisitoDirecto).
% Consulta de prueba: ¿Cuáles son los prerrequisitos directos de IA?
% ?- prerrequisito(ia, Prereq).
prerrequisito(estructuras_datos, programacion).
prerrequisito(base_datos, estructuras_datos).
prerrequisito(ia, programacion).
prerrequisito(ia, matematicas).
prerrequisito(ia, estructuras_datos).


% ==========================================
% REGLAS Y ESTRUCTURAS RECURSIVAS
% ==========================================

% 1. Prerrequisito Recursivo (Cadena de prerrequisitos indirectos)
% Consulta de prueba: ¿Cuáles son todos los prerrequisitos (cadena recursiva) de Base de Datos?
% ?- prerrequisito_cadena(base_datos, Prereq).
% ?- prerrequisito_cadena(base_datos, programacion).

% Caso Base: P es prerrequisito directo de M.
prerrequisito_cadena(M, P) :-
    prerrequisito(M, P).

% Caso Recursivo: P es prerrequisito indirecto a través de una materia intermedia Z.
prerrequisito_cadena(M, P) :-
    prerrequisito(M, Z),
    prerrequisito_cadena(Z, P).


% 2. Materias que un alumno puede cursar
% Cumple TODOS los prerrequisitos directos y no ha cursado la materia aún.
% Consultas de prueba:
% ¿Puede Ana cursar Inteligencia Artificial? -> ?- puede_cursar(ana, ia).
% ¿Puede Luis cursar Inteligencia Artificial? -> ?- puede_cursar(luis, ia).
% ¿Qué materias puede cursar Ana actualmente? -> ?- puede_cursar(ana, Materia).
% ¿Qué materias puede cursar Luis actualmente? -> ?- puede_cursar(luis, Materia).

puede_cursar(Estudiante, Materia) :-
    estudiante(Estudiante),
    materia(Materia),
    \+ aprobo(Estudiante, Materia),
    forall(prerrequisito(Materia, R), aprobo(Estudiante, R)).


% 3. Materias faltantes directas para inscribir una asignatura
% Consulta de prueba: ¿Qué materias le faltan a Luis para cursar IA?
% ?- prerrequisito_faltante(luis, ia, Faltante).

prerrequisito_faltante(Estudiante, Materia, Faltante) :-
    prerrequisito(Materia, Faltante),
    \+ aprobo(Estudiante, Faltante).


% 4. Avance académico (Conteo recursivo de lista)
% Consulta de prueba: ¿Cuántas materias ha aprobado Ana en total (conteo recursivo)?
% ?- total_aprobadas(ana, Total).

contar_elementos([], 0).
contar_elementos([_ | Cola], Total) :-
    contar_elementos(Cola, SubTotal),
    Total is SubTotal + 1.

total_aprobadas(Estudiante, Total) :-
    findall(M, aprobo(Estudiante, M), Lista),
    contar_elementos(Lista, Total).


% 5. PRIORIDAD DE INSCRIPCIÓN CON CORTE (!)
% 5.1. Si tiene 3 o más materias aprobadas -> Prioridad ALTA
% prioridad_inscripcion(ana, P).
prioridad_inscripcion(Estudiante, alta) :-
    total_aprobadas(Estudiante, Total),
    Total >= 3,
    !.

% 5.2. Si tiene al menos 1 materia aprobada -> Prioridad MEDIA
% prioridad_inscripcion(luis, P).
prioridad_inscripcion(Estudiante, media) :-
    total_aprobadas(Estudiante, Total),
    Total >= 1,
    !.

% 5.3. Si no cumple ninguna anterior (0 materias) -> Prioridad BAJA
% prioridad_inscripcion(sofia, P).
prioridad_inscripcion(_, baja).


% ==========================================
% CONSULTAS ADICIONALES (Mundo cerrado y fallos)
% ==========================================

% Negación por fallo
% Consulta de prueba: ¿Existe algún estudiante que no haya aprobado ninguna materia?
% ?- estudiante(X), \+ aprobo(X, _).