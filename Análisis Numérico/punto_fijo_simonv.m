%% - - - - - - - - - - - - - - -
% Método de punto fijo
% Simón Vélez                 
% Análisis Numérico           
% 2025 08 25
% - - - - - - - - - - - - - -

function e = err(a,b) % función error
    e = abs((a-b)/b) * 100;
end

function y = f(x) % función
    y = exp(x)-4+x; %exp(x)*cos(x)-x^2-3*x;
end

function y = g(x) % función de iteración de punto fijo
    % Reordenar f(x) = 0 a un x = g(x) que funcione :)
    y = log(4-x); %(exp(x)*cos(x)-x^2)/3;
end

x0 = 0.5; % primer intento
Er = 10^-5; % error relativo
oldX = 1;
temp = 100;
intentos = 0;

while temp > Er 
    x_new = g(x0);
    temp = err(x_new, oldX);
    oldX = x_new;
    x0 = x_new;
    intentos = intentos + 1;
    if intentos > 1000
        disp("1000 iteraciones y nada. Yo de ti me rindo :(")
        break;
    end
end
fprintf("Raíz en x = %.30f con error = %.10f%% (%.0f intentos)\n", ...
    x_new, temp, intentos)