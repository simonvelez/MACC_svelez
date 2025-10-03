%% - - - - - - - - - - - - - - -
% Integración Numérica
% Simón Vélez                 
% Análisis Numérico           
% Septiembre 2025
% - - - - - - - - - - - - - -

%% Valores

a = 0;
b = pi/2;

f = @(x) 6 + 3*cos(x);

%% Regla del trapecio

function integ = iRegTrap(f, a, b)
    x0 = a;
    x1 = b;
    h = x1 - x0;
    integ = (h/2)*(f(x0) + f(x1));
end

fprintf("Con h = %.2f, Res: %.10f\n",...
    b-a, iRegTrap(f, a, b))

%% Regla de Simpson

function integ = iRegSimp(f, a, b)
    h = (b-a)/2;
    x0 = a;
    x1 = x0 + h;
    x2 = b; 

    integ = (h/3)*(f(x0) + 4*f(x1) + f(x2));
end

fprintf("Res: %.10f\n", iRegSimp(f, a, b))

%% Regla de 3/8 de Simpson
    

%% Regla de Boole


%% Regla de Punto Medio de Newton Cotes abierta


%% Regla de Newton Cotes abierta con N=1,..,4


%% Integración compuesta de Simpson


%% ntegración compuesta de trapecio


%% Regla de Romberg

