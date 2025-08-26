%% - - - - - - - - - - - - - - -
% Método de la secante
% Simón Vélez                 
% Análisis Numérico           
% 2025 08 25
% - - - - - - - - - - - - - -

function y = f(x) % función
    y = exp(x)*cos(x)-x^2-3*x;
end

function e = err(a,b) % función error
    e = abs((a-b)/b) * 100;
end

p0 = 0.5; % estimado inicial
p1 = 1; % otro estimado inicial
Er = 10^-5; % error relativo
oldP = 1;
temp = 100;
intentos = 0;

while temp > Er
    f_eval0 = f(p0);
    f_eval1 = f(p1);

    p_new = p1 - ((f_eval1*(p1-p0))/(f_eval1-f_eval0));
    
    temp = err(p_new, oldP);
    oldP = p_new;
    p0 = p1;
    p1 = p_new;
    intentos = intentos + 1;
    
    if intentos > 100
        disp("100 iteraciones y nada. Yo de ti me rindo :(");
        break;
    end
end

fprintf("Raíz en x = %.30f con error = %.10f%% (%.0f intentos)\n", ...
    p_new, temp, intentos);