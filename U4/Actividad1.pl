% ==========================================
% HECHOS DE LA ACTIVIDAD 1
% ==========================================

estudiante(ana).
estudiante(luis).

estudia(ana, sistemas).
estudia(luis, sistemas).

aprobo(ana, programacion).
aprobo(ana, matematicas).
aprobo(luis, programacion).

% ==========================================

% ¿Qué estudiantes pertenecen a Sistemas?  
% - Consulta: 
%     estudia(X, sistemas).   
% - Resultado: 
%     X = ana ; X = luis.   
%
% ¿Quiénes aprobaron Programación?   
% - Consulta: 
%     aprobo(X, programacion).   
% - Resultado: 
%     X = ana ; X = luis. 
%  
% ¿Qué materias aprobó Ana?   
% - Consulta: 
%     aprobo(ana, Materia).   
% - Resultado: 
%     Materia = programacion ; Materia = matematicas.  
% 
% ¿Quiénes estudian Sistemas Y aprobaron Programación?   
% - Consulta:     
%     estudia(X, sistemas), aprobo(X, programacion).   
% - Resultado: 
%     X = ana.   

% ==========================================