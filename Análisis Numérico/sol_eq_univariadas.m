% Funciones generales

function y = f(x) % funcion 
    y = x^3+4*x^2-10;
end

function e = err(a,b)
    e = abs((a-b)/b) * 100;
end


%% - - - - - - - - - - - - - - -
% Metodo de Biseccion  
% Simon Velez                 
% Analisis Numerico           
% 2025 08 05
% - - - - - - - - - - - - - -

A = 1;
B = 2;
Er = 10^-5; % error relativo objetivo

oldC = 1;
temp = 100;
intentos = 0;
while temp > Er 
    C = (A + B) / 2;
    fA = f(A);
    fB = f(B);
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

fprintf("Raiz en x = %.10f con error = %.10f%% (%.0f intentos)\n", ...
    C, temp, intentos)



%% - - - - - - - - - - - - - - -
% Metodo de falsa posicion
% Simon Velez                 
% Analisis Numerico           
% 2025 08 08
% - - - - - - - - - - - - - -

A = 1;
B = 2;
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

fprintf("Raiz en x = %.30f con error = %.10f%% (%.0f intentos)\n", ...
    C, temp, intentos)