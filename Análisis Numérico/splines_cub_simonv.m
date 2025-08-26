%% - - - - - - - - - - - - - - -
% Interpolación por Splines Cúbicos
% Simón Vélez                 
% Análisis Numérico           
% 2025 08 25
% - - - - - - - - - - - - - -

function [coef, x_puntos] = splinear(x, y) % calcular los coeficientes del spline :3

    n = length(x) - 1; % Número de intervalos (que es # puntos -1)
    x_puntos = x(:); % vector columna momento
    coef = zeros(n, 4); % coeficientes

    % Pasos 4,5,6 del algoritmo

    h = diff(x); % intervalo

    % diagonales de la matriz
    main_diag = 2 * (h(1:n-1) + h(2:n));
    off_diag = h(2:n-1);
    A = diag(main_diag) + diag(off_diag, 1) + diag(off_diag, -1);

    % Vector b
    b = (6 ./ h(2:n)) .* (y(3:n+1) - y(2:n)) - ...
        (6 ./ h(1:n-1)) .* (y(2:n) - y(1:n-1));

    % Segundas derivadas interiores
    M_interior = A \ b(:);

    % Paso 6 del algoritmo
    M = [0; M_interior; 0];

    % Pasos 1,2,5 del algoritmo
    for j = 1:n
        % a_j = y_j
        coef(j, 1) = y(j);
        
        % b_j = (y_{j+1}-y_j)/h_j - h_j/6*(2*M_j + M_{j+1})
        coef(j, 2) = (y(j+1) - y(j)) / h(j) - (h(j)/6) * (2*M(j) + M(j+1));

        % c_j = M_j / 2
        coef(j, 3) = M(j) / 2;

        % d_j = (M_{j+1} - M_j) / (6*h_j)
        coef(j, 4) = (M(j+1) - M(j)) / (6 * h(j));
    end
end

function y_eval = evalSpline(coeffs, x_knots, x_eval) % evaluar el spline
    n = size(coeffs, 1);
    y_eval = zeros(size(x_eval));

    for i = 1:length(x_eval)
        x_val = x_eval(i);

        % Encontrar el intervalo de x_eval
        j = find(x_val >= x_knots, 1, 'last');
        if j == n + 1
            j = n;
        end

        % coeficientes del intervalo relevante
        a = coeffs(j, 1);
        b = coeffs(j, 2);
        c = coeffs(j, 3);
        d = coeffs(j, 4);

        % Evaluar S_j(x)
        dx = x_val - x_knots(j);
        y_eval(i) = a + b*dx + c*dx^2 + d*dx^3;
    end
end

% Puntos del polinomio
x_datos = [1.6, 2, 2.5, 3.2, 4, 4.5]; 
y_datos = [2, 8, 14, 15, 8, 2];


[coeffs, x_puntos] = splinear(x_datos, y_datos);

fprintf('Coeficientes calculados (a, b, c, d) para cada intervalo:\n');
disp(coeffs);

x_eval = 3;
y_punto = evalSpline(coeffs, x_puntos, x_eval);
fprintf('\nValor interpolado en x = %.2f es y = %.30f\n', x_eval, y_punto);

