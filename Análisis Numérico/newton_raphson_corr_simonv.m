%% - - - - - - - - - - - - - - -
% Método de Newton-Raphson Corregido
% Simón Vélez                 
% Análisis Numérico           
% Septiembre 2025
% - - - - - - - - - - - - - -


syms x 
f_sym = exp(x) * cos(x) - x^2 - 3*x; % f simbólica, con x como variable
f = matlabFunction(f_sym);

function e = err(a,b) % función error
    e = abs((a-b)/b) * 100;
end

function  fprime_x0 = dTresMed(X, fX, x0, h) % Dif. Tres puntos por medios
    if length(X) < 3
        fprintf("Inserte mas datos :(")
    end
    
    x_step = X(2) - X(1);
    i_0 = round((x0 - X(1))/(x_step) + 1); % Definir donde esta x0
    i = round(h/x_step); % los pasos que hay que dar en la funcion segun el h
    
    fprime_x0 = (1/(2*h))*(fX(i_0 + i) - fX(i_0 - i));
end

% Discretización de la función
X = -5:0.001:5; 
fX = f(X);      
h = 0.001;

% Parámetros Newton-Raphson
p0 = 0.5; % estimado inicial
Er = 10^-5; % error relativo
oldP = 1;
temp = 100;
intentos = 0;

while temp > Er
    f_eval = f(p0);
    fprime_eval = dTresMed(X, fX, p0, h);
    
    if fprime_eval == 0
        disp("La derivada dio 0, pailas :(");
        break;
    end
    
    p_new = p0 - (f_eval/ fprime_eval);
    
    temp = err(p_new, oldP);
    oldP = p_new;
    p0 = p_new;
    intentos = intentos + 1;
    
    if intentos > 100
        disp("100 iteraciones y nada. Yo de ti me rindo :(");
        break;
    end
end

fprintf("Raíz en x = %.30f con error = %.10f%% (%.0f intentos)\n", ...
    p_new, temp, intentos);