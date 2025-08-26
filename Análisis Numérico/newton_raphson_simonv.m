%% - - - - - - - - - - - - - - -
% Método de Newton-Raphson
% Simón Vélez                 
% Análisis Numérico           
% 2025 08 25
% - - - - - - - - - - - - - -

% Bueno, no se pudo escapar más. va a tocar sacar el symbolic expression

syms x 
f_sym = exp(x) * cos(x) - x^2 - 3*x; % f simbólica, con x como variable
fprime_sym = diff(f_sym); % se hace simbólico para calcular fácil f'(x)

f = matlabFunction(f_sym); % pasarla a función handle para poder hacer todo
fprime = matlabFunction(fprime_sym);

function e = err(a,b) % función error
    e = abs((a-b)/b) * 100;
end

p0 = 0.5; % estimado inicial
Er = 10^-5; % error relativo
oldP = 1;
temp = 100;
intentos = 0;

while temp > Er
    f_eval = f(p0);
    fprime_eval = fprime(p0);
    
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