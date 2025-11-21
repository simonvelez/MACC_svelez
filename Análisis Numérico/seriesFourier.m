%% - - - - - - - - - - - - - - -
% Series de Fourier
% Simón Vélez                 
% Análisis Numérico           
% - - - - - - - - - - - - - -


%% Usando nube de puntos

function [a, b, fourier_approx] = fourierSeriesData(x, y, N)
% N - max de armonicos

    x = x(:);
    y = y(:);
    n = length(x);
    
    if n < 2*N + 1
        warning('El número de puntos (n) es insuficiente para el número de armónicos (N). Reduzca N.');
        N = floor((n - 1) / 2); % Ajuste N al máximo posible
        if N < 0; N = 0; end
    end
    
    % Calcular el Período T (asumiendo que los datos cubren un período)
    T = max(x) - min(x);
    
    a = zeros(N + 1, 1);
    b = zeros(N + 1, 1);
    
    % Si el período es cero (un solo punto), retornamos una constante
    if T == 0
        a(1) = 2 * mean(y); % a0 = 2 * y_bar
        fourier_approx = @(x_val) a(1) / 2;
        return;
    end
    
    % --- 1. Cálculo de Coeficientes (k=0 a N) ---
    for k = 0:N
        % Cálculo de a_k (Incluye a0, que es el doble de la media)
        if k == 0
            % a0 = 2/n * Sum(y_i * cos(0)) = 2/n * Sum(y_i)
            a(k + 1) = 2 * sum(y) / n;
        else
            % a_k = 2/n * Sum(y_i * cos(2*pi*k*xi / T))
            a(k + 1) = 2 * sum(y .* cos(2*pi*k*x / T)) / n;
        end
        
        % Cálculo de b_k (Solo para k > 0)
        if k > 0
            % b_k = 2/n * Sum(y_i * sin(2*pi*k*xi / T))
            b(k + 1) = 2 * sum(y .* sin(2*pi*k*x / T)) / n;
        end
    end
    
    % --- 2. Función Anónima de la Aproximación ---
    fourier_approx = @(x_val) calculateFourierSum(x_val, a, b, N, T);

end

% Función auxiliar para calcular la suma de Fourier en un valor x_val
function f_sum = calculateFourierSum(x_val, a, b, N, T)
    x_val = x_val(:);
    f_sum = a(1) / 2 * ones(size(x_val)); % Inicializar con a0/2
    
    for k = 1:N
        % f(x) += a_k * cos(...) + b_k * sin(...)
        f_sum = f_sum + a(k + 1) * cos(2*pi*k*x_val / T) + b(k + 1) * sin(2*pi*k*x_val / T);
    end
end



%% Usando una funcion

function [a, b, fourier_approx] = fourierSeriesFunc(f, L, N)
%   L - La mitad del período del intervalo (el intervalo es [-L, L]).
%   N - Número máximo de armónicos a usar.

    a = zeros(N + 1, 1);
    b = zeros(N + 1, 1);
    
    disp('Calculando coeficientes de Fourier por integración...');

    % --- 1. Cálculo de Coeficientes (k=0 a N) ---
    for k = 0:N
        
        % 1.1. Coeficiente a_k
        integrand_a = @(x) f(x) .* cos(k*pi*x / L);
        
        % a_k = 1/L * Integral[-L, L] de f(x) * cos(k*pi*x/L) dx
        integral_a = integral(integrand_a, -L, L);
        a(k + 1) = (1 / L) * integral_a;
        
        % 1.2. Coeficiente b_k (Solo para k > 0)
        if k > 0
            integrand_b = @(x) f(x) .* sin(k*pi*x / L);
            
            % b_k = 1/L * Integral[-L, L] de f(x) * sin(k*pi*x/L) dx
            integral_b = integral(integrand_b, -L, L);
            b(k + 1) = (1 / L) * integral_b;
        end
    end
    
    % --- 2. Función Anónima de la Aproximación ---
    fourier_approx = @(x_val) calculateFourierSumFunc(x_val, a, b, N, L);

end

% Función auxiliar para calcular la suma de Fourier en un valor x_val
function f_sum = calculateFourierSumFunc(x_val, a, b, N, L)
    x_val = x_val(:);
    f_sum = a(1) / 2 * ones(size(x_val)); % Inicializar con a0/2
    
    for k = 1:N
        % f(x) += a_k * cos(...) + b_k * sin(...)
        f_sum = f_sum + a(k + 1) * cos(k*pi*x_val / L) + b(k + 1) * sin(k*pi*x_val / L);
    end
end

% Ejemplo de uso de fourierSeriesFunc

L = pi; % Periodo 2*L = 2*pi
N = 5;  % Usar 5 armónicos

% Definición de la función Onda Cuadrada en [-L, L]
f_square_wave = @(x) sign(x); 

[a_sw, b_sw, func_sw] = fourierSeriesFunc(f_square_wave, L, N);

disp('--- Coeficientes de Onda Cuadrada (N=5) ---');
disp(['a_k (esperado: [0; 0; ...]): ' num2str(a_sw')]);
disp(['b_k (esperado: [0; 4/pi; 0; 4/(3pi); 0; 4/(5pi); ...]): ' num2str(b_sw')]);

% Graficar la aproximación
x_plot = linspace(-L, L, 500);
y_true = f_square_wave(x_plot);
y_approx = func_sw(x_plot);

figure;
plot(x_plot, y_true, 'k--', 'LineWidth', 1);
hold on;
plot(x_plot, y_approx, 'r-', 'LineWidth', 2);
title(['Aproximación de Onda Cuadrada con N=' num2str(N)]);
xlabel('x');
ylabel('f(x)');
legend('Función Verdadera', ['Aprox. Fourier N=' num2str(N)], 'Location', 'best');
grid on;