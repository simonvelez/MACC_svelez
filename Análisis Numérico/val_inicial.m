%% - - - - - - - - - - - - - - -
% Problemas de Valor Inicial
% Simón Vélez                 
% Análisis Numérico           
% Octubre 2025
% - - - - - - - - - - - - - -


% Valores problema

k = 0.06; 
y0 = 3; % Valor inicial

f = @(t, y) -k * sqrt(y); % ODE a resolver

a = 0;      % tiempo inicial
b = 100;    % tiempo final
paso = 0.001;
N = (b-a)/paso; % numero de pasos

%% Valores sistema de ecuaciones (ej)

f = @(x, y) [ -0.5 * y(1); 
               4 - 0.3 * y(2) - 0.1 * y(1) ];

a = 0;              % Start of interval
b = 2;              % End of interval
y0 = [4; 6];        % [y1(0); y2(0)]
h = 0.5;            
N = (b - a) / h;    

[x, y] = metPMedio_sist(f, a, b, y0, N);


results_table = [x; y]';

fprintf('   x      y1         y2\n');
fprintf('-----------------------------\n');
disp(results_table);

%% Método de Euler

function [t, y] = metEuler(f, a, b, y0, N)

%   t: puntos de tiempo
%   y: solucion aproximada y(t)

h = (b - a) / N;
t = a:h:b;
y = zeros(1, N + 1); 
y(1) = y0;      

    for i = 1:N
        y(i+1) = y(i) + h * f(t(i), y(i));
    end
end

[t, y] = metEuler(f, a, b, y0, N);
empty_index = find(y <= 0, 1); % Encontrar elindice donde la ec llega a 0

fprintf("Res: %.10f\n", t(empty_index))

%% Método de punto medio


function [t, y] = metPMedio(f, a, b, y0, N)

%   t: puntos de tiempo
%   y: solucion aproximada y(t)

h = (b - a) / N;
t = a:h:b;
y = zeros(1, N + 1); 
y(1) = y0;      

    for i = 1:N
        y(i+1) = y(i) + h * f(t(i) + h/2, y(i) + (h/2) * f(t(i), y(i)));
    end
end

[t, y] = metPMedio(f, a, b, y0, N);
empty_index = find(y <= 0, 1); % Encontrar el indice donde la ec llega a 0

fprintf("Res: %.10f\n", t(empty_index))

%% Método de Euler modificado


function [t, y] = metEulerMod(f, a, b, y0, N)

%   t: puntos de tiempo
%   y: solucion aproximada y(t)

h = (b - a) / N;
t = a:h:b;
y = zeros(1, N + 1); 
y(1) = y0;      

    for i = 1:N
        y(i+1) = y(i) + (h/2) * (f(t(i), y(i)) + f(t(i+1), y(i) + h * f(t(i), y(i))));
    end
end

[t, y] = metEulerMod(f, a, b, y0, N);
empty_index = find(y <= 0, 1); % Encontrar el indice donde la ec llega a 0

fprintf("Res: %.10f\n", t(empty_index))


%% RK4

function [t, y] = RK4(f, a, b, y0, N)

%   t: puntos de tiempo
%   y: solucion aproximada y(t)

h = (b - a) / N;
t = a:h:b;
y = zeros(1, N + 1); 
y(1) = y0;      

    for i = 1:N
        k1 = h * f(t(i), y(i));                      % k1 = h * f(t_i, w_i)
        k2 = h * f(t(i) + h/2, y(i) + k1/2);         % k2 = h * f(t_i + h/2, w_i + k1/2)
        k3 = h * f(t(i) + h/2, y(i) + k2/2);         % k3 = h * f(t_i + h/2, w_i + k2/2)
        k4 = h * f(t(i) + h, y(i) + k3);             % k4 = h * f(t_i + h, w_i + k3)

        y(i+1) = y(i) + (1/6) * (k1 + 2*k2 + 2*k3 + k4); % RK4
    end
end

[t, y] = RK4(f, a, b, y0, N);
empty_index = find(y <= 0, 1); % Encontrar el indice donde la ec llega a 0

fprintf("Res: %.10f\n", t(empty_index))

%% Runge Kutta Fehlberg

function [t, y] = RKF(f, a, b, y0, TOL, h_init, h_min, h_max) % TOL: tolerancia al error (epsilon)
    
    t(1) = a;
    y(1) = y0;
    h = h_init;
    i = 1;

    while t(i) < b
        if t(i) + h > b % el que se pase de b pierde
            h = b - t(i);
        end

        k1 = h * f(t(i), y(i));
        k2 = h * f(t(i) + (1/4)*h, y(i) + (1/4)*k1);
        k3 = h * f(t(i) + (3/8)*h, y(i) + (3/32)*k1 + (9/32)*k2);
        k4 = h * f(t(i) + (12/13)*h, y(i) + (1932/2197)*k1 - (7200/2197)*k2 + (7296/2197)*k3);
        k5 = h * f(t(i) + h, y(i) + (439/216)*k1 - 8*k2 + (3680/513)*k3 - (845/4104)*k4);
        k6 = h * f(t(i) + (1/2)*h, y(i) - (8/27)*k1 + 2*k2 - (3544/2565)*k3 + (1859/4104)*k4 - (11/40)*k5);

        % |w_i+1 - w_hat_i+1|
        error_est = abs((1/360)*k1 - (128/4275)*k3 - (2197/75240)*k4 + (1/50)*k5 - (2/55)*k6);

        q = ( (TOL * h) / (2 * error_est + 1e-10) )^(1/4); % 1e-10 se suma porque a veces daba error de div por 0
        

        if error_est <= TOL
            % Acepto el paso :D (me duele no poder poner tildes)
            y(i+1) = y(i) + (25/216)*k1 + (1408/2565)*k3 + (2197/4104)*k4 - (1/5)*k5;
            t(i+1) = t(i) + h;
            i = i + 1;
        end

        h = 0.84 * q * h;

        % min y max step
        h = min(h_max, max(h_min, h));
    end
end

TOL = 1e-5;
h_init = 0.2;  
h_min = 0.01;   
h_max = 0.25;    

empty_index = find(y <= 0, 1); % Encontrar el indice donde la ec llega a 0

fprintf("Res: %.10f\n", t(empty_index))

figure;
plot(t, y, 'o-', 'LineWidth', 1.5, 'MarkerSize', 4);
title('Solucion');
xlabel('t');
ylabel('y(t)');
grid on;
legend('RKF')

%% Sistemas de ecuaciones

% Euler

function [t, y] = metEuler_sist(f, a, b, y0, N)
    
    h = (b - a) / N;
    t = a:h:b;
    
    % Asegurar que y0 sea un vector columna
    if size(y0, 2) > 1
        y0 = y0';
    end
    
    num_eqs = length(y0);
    y = zeros(num_eqs, N + 1);    
    y(:, 1) = y0; 
    
    for i = 1:N
        y(:, i+1) = y(:, i) + h * f(t(i), y(:, i));
    end
end

% Punto Medio

function [t, y] = metPMedio_sist(f, a, b, y0, N)
    % Calcula la solución de un sistema de EDOs y' = f(t,y)
    % usando el método del Punto Medio.
    
    h = (b - a) / N;
    t = a:h:b;
    
    % Asegurar que y0 sea un vector columna
    if size(y0, 2) > 1
        y0 = y0';
    end
    
    num_eqs = length(y0);
    y = zeros(num_eqs, N + 1);    
    y(:, 1) = y0;
    
    for i = 1:N % dividi en k1 y k2 para que y no quede tan largo
        k1 = f(t(i), y(:, i));
        k2 = f(t(i) + h/2, y(:, i) + (h/2) * k1);
        y(:, i+1) = y(:, i) + h * k2;
    end
end

% Euler Modificado

function [t, y] = metEulerMod_sist(f, a, b, y0, N)
    
    h = (b - a) / N;
    t = a:h:b;
    
    if size(y0, 2) > 1
        y0 = y0';
    end
    
    num_eqs = length(y0);
    y = zeros(num_eqs, N + 1);    
    y(:, 1) = y0; 
   
    for i = 1:N
        y(:, i+1) = y(:, i) + (h/2) * (f(t(i), y(:, i)) + f(t(i+1), y(:, i) + h * f(t(i), y(:, i))));
    end
end

% RK4 

function [t, y] = RK4_sist(f, a, b, y0, N) % y_0 vector columna

    h = (b - a) / N;
    t = a:h:b;
    
    if size(y0, 2) > 1
        y0 = y0';
    end
    
    num_eqs = length(y0);
    y = zeros(num_eqs, N + 1);    
    y(:, 1) = y0; 
    
    for i = 1:N
        k1 = h * f(t(i), y(:, i));
        k2 = h * f(t(i) + h/2, y(:, i) + k1/2);
        k3 = h * f(t(i) + h/2, y(:, i) + k2/2);
        k4 = h * f(t(i) + h, y(:, i) + k3);
        
        y(:, i+1) = y(:, i) + (1/6) * (k1 + 2*k2 + 2*k3 + k4);
    end
end