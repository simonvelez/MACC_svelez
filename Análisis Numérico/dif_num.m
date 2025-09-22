%% - - - - - - - - - - - - - - -
% Diferenciación Numérica
% Simón Vélez                 
% Análisis Numérico           
% 2025 08 29
% - - - - - - - - - - - - - -

% Valores iniciales

X = [1.8, 1.9, 2.0, 2.1, 2.2];
fX = [10.889365, 12.703199, 14.778112, 17.148957, 19.855030];
h = 0.1;

%% Tres puntos por extremos

function y = dTresEx(X, fX, x0, h)
    if length(X) < 3
        fprintf("Inserte mas datos :(")
    end
    
    % Definir donde esta x0
    i = (x0 - i)/(X);

end

dTresEx(X, fX)

%% Tres puntos por medios



%% Cinco puntos por extremos



%% Cinco puntos por medios



%% Segunda derivada

