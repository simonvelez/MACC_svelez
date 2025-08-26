%% - - - - - - - - - - - - - - -
% Método de falsa posición
% Simón Vélez                 
% Análisis Numérico           
% 2025 08 08
% - - - - - - - - - - - - - -

function y = f(x) % función
    y = exp(x)*cos(x)-x^2-3*x;
end

function e = err(a,b) % función error
    e = abs((a-b)/b) * 100;
end

A = 0;
B = 1;
Er = 10^-5; % error relativo objetivo

oldC = 1;
temp = 100;
intentos = 0;
while temp > Er 
    fA = f(A);
    fB = f(B);
    
    C = B - ((f(B)*(B-A))/(f(B)-f(A)));
    fC = f(C);
    
    if fA * fC < 0
        B = C;
    elseif fB * fC < 0
        A = C;
    else
        disp("Raiz exacta o error")
        break;
    end

    temp = err(C, oldC);
    oldC = C;
    intentos = intentos + 1;

end

fprintf("Raíz en x = %.30f con error = %.10f%% (%.0f intentos)\n", ...
    C, temp, intentos)