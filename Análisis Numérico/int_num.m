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
    
function integ = iRegSimp38(f, a, b)
    h = (b-a)/3;
    x0 = a;
    x1 = x0 + h;
    x2 = x0 + 2*h;
    x3 = x0 + 3*h;

    integ = ((3*h)/8)*(f(x0) + 3*f(x1) + 3*f(x2) + f(x3));
end

fprintf("Res: %.10f\n", iRegSimp38(f, a, b))
%% Regla de Boole

function integ = iRegBoole(f, a, b)
    h = (b-a)/4;
    x0 = a;
    x1 = x0 + h;
    x2 = x0 + 2*h;
    x3 = x0 + 3*h;
    x4 = x0 + 4*h;

    integ = ((2*h)/45)*(7*f(x0) + 32*f(x1) + 12*f(x2) + 32*f(x3) + 7*f(x4));
end

fprintf("Res: %.10f\n", iRegBoole(f, a, b))
%% Regla de Punto Medio de Newton Cotes abierta

function integ = iRegPMed(f, a, b)
    h = (b-a)/(2+0);
    x0 = a + h;

    integ = 2*h*f(x0);
end

fprintf("Res: %.10f\n", iRegPMed(f, a, b))
%% Regla de Newton Cotes abierta con N=1,..,3

function integ = iNCotesAb1(f, a, b)
    h = (b-a)/(2+1);
    x0 = a + h;
    x1 = a + 2*h;

    integ = ((3*h)/2)*(f(x0) + f(x1));
end

function integ = iNCotesAb2(f, a, b)
    h = (b-a)/(2+2);
    x0 = a + h;
    x1 = a + 2*h;
    x2 = a + 3*h;

    integ = ((4*h)/3)*(2*f(x0) - f(x1) + 2*f(x2));
end

function integ = iNCotesAb3(f, a, b)
    h = (b-a)/(2+3);
    x0 = a + h;
    x1 = a + 2*h;
    x2 = a + 3*h;
    x3 = a + 4*h;

    integ = ((5*h)/24)*(11*f(x0) + f(x1) + f(x2) + 11*f(x3));
end

fprintf("Abierta con n = 1. Res: %.10f\n", iNCotesAb1(f, a, b))
fprintf("Abierta con n = 2. Res: %.10f\n", iNCotesAb2(f, a, b))
fprintf("Abierta con n = 3. Res: %.10f\n", iNCotesAb3(f, a, b))

%% Integración compuesta de Simpson

function integ = iRegSimpComp(f, a, b, n)
    h = (b-a)/n;
    x = a:h:b; % crear un vector con todos los x_j
    
    integ = (h / 3) * (f(a) + f(b) + 2 * sum(f(x(2:2:n))) + 4 * sum(f(x(3:2:n-1))));
end

n = 4;
fprintf("Res: %.10f\n", iRegSimpComp(f, a, b, n))

%% Integración compuesta de trapecio

function integ = iRegTrapComp(f, a, b, n)
    h = (b - a) / n;   
    x = a:h:b;      
    
    integ = (h / 2) * (f(a) + f(b) + 2 * sum(f(x(2:end-1))));
end

n = 4;
fprintf("Res: %.10f\n", iRegTrapComp(f, a, b, n))

%% Regla de Romberg

