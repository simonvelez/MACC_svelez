%% - - - - - - - - - - - - - - -
% Regresiones
% Simón Vélez                 
% Análisis Numérico           
% 2025 11 04
% - - - - - - - - - - - - - -

%% Regresion Lineal por minimos cuadrados

function [a0, a1, r2, r, regression_line] = linearRegression(x, y)

    % Asegurar que x e y sean vectores columna para operaciones consistentes
    x = x(:);
    y = y(:);
    
    % n: Número de puntos de datos
    n = length(x);

    % --- 1. Cálculo de las Sumatorias (Componentes de las Ecuaciones Normales) ---
    
    % Suma de x_i
    sum_x = sum(x);
    
    % Suma de y_i
    sum_y = sum(y);
    
    % Suma de x_i^2
    sum_x2 = sum(x.^2);
    
    % Suma de x_i * y_i
    sum_xy = sum(x .* y);
    
    % --- 2. Cálculo de los Coeficientes (a1 y a0) ---
    
    % Denominador (el mismo para a1 y a0)
    % Den = n * sum(x^2) - (sum(x))^2
    Den = n * sum_x2 - sum_x^2;
    
    % Verificar el denominador (Evitar división por cero si todos los x son iguales)
    if Den == 0
        error('El denominador es cero. Todos los valores de x son idénticos. :(');
    end
    
    % Coeficiente a1 (Pendiente)
    % a1 = (n * sum(xi*yi) - sum(xi) * sum(yi)) / Den
    a1 = (n * sum_xy - sum_x * sum_y) / Den;
    
    % Promedios
    x_bar = sum_x / n;
    y_bar = sum_y / n;
    
    % Coeficiente a0 (Intercepto)
    % a0 = y_bar - a1 * x_bar
    a0 = y_bar - a1 * x_bar;
    
    % Bondad de Ajuste (r^2) 
    
    y_hat = a0 + a1 * x;
    
    % Suma Total de los Cuadrados (St)
    St = sum((y - y_bar).^2);
    
    % Suma de los Cuadrados de los Residuales (Sr)
    Sr = sum((y - y_hat).^2);
    % r2 = 1 - (Sr / St)
    if St == 0
        r2 = 1; % Si St es 0, todos los y son iguales y el ajuste es perfecto (r2=1).
    else
        r2 = 1 - (Sr / St);
    end
    
    % Coeficiente de Correlación (r)
    r = sign(a1) * sqrt(r2);

   
    regression_line = @(val_x) a0 + a1 * val_x;
end

% Ejemplo

x_data = [5; 10; 15; 20; 25; 30; 35; 40; 45; 50];
y_data = [17; 24; 31; 33; 37; 37; 40; 40; 42; 41];

% Calcular los coeficientes
[a0, a1, r2, r, line_func] = linearRegression(x_data, y_data);

disp(['Intercepto (a0): ' num2str(a0)]);
disp(['Pendiente (a1): ' num2str(a1)]);
disp(['r: ' num2str(r)])
disp(['Ecuación de la Regresión: y = ' num2str(a0) ' + ' num2str(a1) ' * x']);

% Trazar la Regresión (Código de visualización)

figure;
scatter(x_data, y_data, 'filled'); % Dibujar los puntos originales
hold on;
plot_x = linspace(min(x_data), max(x_data), 100); % Rango para la línea
plot(plot_x, line_func(plot_x), 'r-', 'LineWidth', 2); % Dibujar la línea de regresión
title('Regresión Lineal por Mínimos Cuadrados');
xlabel('Variable Independiente (x)');
ylabel('Variable Dependiente (y)');
legend('Datos Originales', 'Línea de Regresión', 'Location', 'northwest');
grid on;

%% Metodos de linealizacion

function [alpha1, beta1, r2,r, regression_func] = exponentialModel(x, y)
% EXPONENTIALMODEL Ajusta datos al modelo y = alpha1 * exp(beta1 * x).

    x = x(:);
    y = y(:);
    
    % --- 1. Linealización: Y = ln(y), X = x ---
    Y = log(y); % ln(y)
    X = x;
    
    % Verificar si hay valores de y <= 0 (ln no definido)
    if any(y <= 0)
        error('El modelo exponencial requiere y > 0.');
    end

    % --- 2. Regresión Lineal (Y = A0 + A1 * X) ---
    [A0, A1, r2, r, ~] = linearRegression(X, Y); % Reutilizar la función de regresión

    % --- 3. Conversión a Parámetros No Lineales ---
    beta1 = A1;
    alpha1 = exp(A0);

    % --- 4. Función de Regresión (Original) ---
    regression_func = @(val_x) alpha1 * exp(beta1 * val_x);
end

function [alpha2, beta2, r2, r, regression_func] = powerLawModel(x, y)
% POWERLAWMODEL Ajusta datos al modelo y = alpha2 * x^(beta2).

    x = x(:);
    y = y(:);
    
    % Verificar si hay valores de x o y <= 0
    if any(x <= 0) || any(y <= 0)
        error('El modelo potencial requiere x > 0 y y > 0.');
    end
    
    % --- 1. Linealización: Y = ln(y), X = ln(x) ---
    Y = log(y); % ln(y)
    X = log(x); % ln(x)

    % --- 2. Regresión Lineal (Y = A0 + A1 * X) ---
    [A0, A1, r2, r, ~] = linearRegression(X, Y); 

    % --- 3. Conversión a Parámetros No Lineales ---
    beta2 = A1;
    alpha2 = exp(A0); % alpha2 = e^A0

    % --- 4. Función de Regresión (Original) ---
    regression_func = @(val_x) alpha2 * (val_x .^ beta2);
end

function [alpha3, beta3, r2, r, regression_func] = growthRateModel(x, y)
% GROWTHMODEL Ajusta datos al modelo y = alpha3 * x / (beta3 + x) (Saturación).

    x = x(:);
    y = y(:);
    
    % Verificar si hay valores de x o y <= 0
    if any(x <= 0) || any(y <= 0)
        error('El modelo de razón de crecimiento requiere x > 0 y y > 0.');
    end
    
    % --- 1. Linealización: Y = 1/y, X = 1/x ---
    Y = 1 ./ y;
    X = 1 ./ x;

    % --- 2. Regresión Lineal (Y = A0 + A1 * X) ---
    [A0, A1, r2, r, ~] = linearRegression(X, Y); 

    % Verificar A0 para evitar división por cero
    if abs(A0) < eps
        error('El intercepto lineal (A0) es cero, lo que implica que alpha3 es infinito.');
    end
    
    % --- 3. Conversión a Parámetros No Lineales ---
    alpha3 = 1 / A0;
    beta3 = A1 * alpha3; % beta3 = A1 / A0

    % --- 4. Función de Regresión (Original) ---
    regression_func = @(val_x) (alpha3 * val_x) ./ (beta3 + val_x);
end

% Ejemplo

x_data = [5; 10; 15; 20; 25; 30; 35; 40; 45; 50];
y_data = [17; 24; 31; 33; 37; 37; 40; 40; 42; 41];

[a0_lin, a1_lin, ~, r_lin, func_lin] = linearRegression(x_data, y_data);
[alpha1_exp, beta1_exp, ~, r_exp, func_exp] = exponentialModel(x_data, y_data);
[alpha2_pow, beta2_pow, ~, r_pow, func_pow] = powerLawModel(x_data, y_data);
[alpha3_growth, beta3_growth, ~, r_growth, func_growth] = growthRateModel(x_data, y_data);

disp('A. MODELO LINEAL:');
disp(['   Ecuación: y = ' num2str(a0_lin, 4) ' + ' num2str(a1_lin, 4) ' * x']);
disp(['   r = ' num2str(r_lin, 4)]);
disp('B. MODELO EXPONENCIAL:');
disp(['   Ecuación: y = ' num2str(alpha1_exp, 4) ' * exp(' num2str(beta1_exp, 4) ' * x)']);
disp(['   r = ' num2str(r_exp, 4)]);
disp('C. MODELO POTENCIAL:');
disp(['   Ecuación: y = ' num2str(alpha2_pow, 4) ' * x^(' num2str(beta2_pow, 4) ')']);
disp(['   r = ' num2str(r_pow, 4)]);
disp('D. MODELO SATURACIÓN (Crecimiento):');
disp(['   Ecuación: y = ' num2str(alpha3_growth, 4) '*x / (' num2str(beta3_growth, 4) ' + x)']);
disp(['   r = ' num2str(r_growth, 4)]);

figure;
scatter(x_data, y_data, 70, 'filled', 'MarkerEdgeColor', [0 .5 .5], 'MarkerFaceColor', [0 .7 .7]); % Puntos originales
hold on;

plot_x = linspace(min(x_data), max(x_data), 100); 

% Trazar las cuatro curvas
plot(plot_x, func_lin(plot_x), 'r-', 'LineWidth', 2, 'DisplayName', ['Lineal (r=' num2str(r_lin, 3) ')']);
plot(plot_x, func_exp(plot_x), 'g--', 'LineWidth', 2, 'DisplayName', ['Exponencial (r=' num2str(r_exp, 3) ')']);
plot(plot_x, func_pow(plot_x), 'b:', 'LineWidth', 2, 'DisplayName', ['Potencial (r=' num2str(r_pow, 3) ')']);
plot(plot_x, func_growth(plot_x), 'm-', 'LineWidth', 3, 'DisplayName', ['Saturación (r=' num2str(r_growth, 3) ')']);

title('Comparación de Modelos de Regresión Linealizados');
xlabel('Variable Independiente (x)');
ylabel('Variable Dependiente (y)');
legend('Location', 'southeast');
grid on;
hold off;


%% Regresion Polinomial

function [a, r2, Sx_y, regression_func] = polynomialRegression(x, y, m)
% POLYNOMIALREGRESSION Ajusta los datos a un polinomio de grado m.

    x = x(:);
    y = y(:);
    n = length(x);
    
    if m >= n
        error('El grado del polinomio (m) debe ser menor que el número de puntos (n).');
    end
    
    Z = zeros(m + 1, m + 1);
    b_vec = zeros(m + 1, 1);
    
    % Calcular las sumas necesarias (hasta S(2m) y S(m))
    
    % Llenar la Matriz Z (la matriz de la izquierda)
    for i = 0:m % Fila
        for j = 0:m % Columna
            % Z(i+1, j+1) es Sum(x^(i+j))
            sum_x_pow = sum(x.^(i + j));
            Z(i + 1, j + 1) = sum_x_pow;
        end
    end
    
    % Llenar el Vector b (el lado derecho)
    for i = 0:m % Fila
        % b_vec(i+1) es Sum(y * x^i)
        sum_y_x_pow = sum(y .* (x.^i));
        b_vec(i + 1) = sum_y_x_pow;
    end
    
    a = Z \ b_vec; % Vector de coeficientes: a = [a0; a1; ...; am]
    
    % Bondad de ajuste
    
    % Predicciones del polinomio: y_hat = a0 + a1*x + ... + am*x^m
    
    X_vand = zeros(n, m + 1);
    for j = 0:m
        X_vand(:, j + 1) = x.^j;
    end
    
    y_hat = X_vand * a; % Multiplicación matricial para obtener y_hat
    
    % Promedio de y
    y_bar = mean(y);
    
    % Suma Total de los Cuadrados (St)
    St = sum((y - y_bar).^2);
    
    % Suma de los Cuadrados de los Residuales (Sr)
    Sr = sum((y - y_hat).^2);
   
    if St == 0
        r2 = 1;
    else
        r2 = 1 - (Sr / St);
    end
    
    % Error Estándar del Estimado (Sx/y)
    % Sx/y = sqrt(Sr / (n - (m + 1)))
    % n - (m + 1) = grados de libertad. Debe ser >= 0.
    degrees_of_freedom = n - (m + 1);
    if degrees_of_freedom <= 0
        % Esto solo ocurre si se viola la condición m < n
        Sx_y = NaN; 
    else
        Sx_y = sqrt(Sr / degrees_of_freedom);
    end

    regression_func = @(val_x) sum(a .* (val_x.^(0:m)'), 1);
    
end


% Ejemplo
x_data = [5; 10; 15; 20; 25; 30; 35; 40; 45; 50];
y_data = [17; 24; 31; 33; 37; 37; 40; 40; 42; 41];

m = 2; % Polinomio de grado 2

[a_poly, r2_poly, Sx_y_poly, func_poly] = polynomialRegression(x_data, y_data, m);

disp('--- Regresión Polinomial (Grado 2) ---');
disp('Coeficientes a = [a0; a1; a2; a3]:');
disp(a_poly');
disp(['r^2: ' num2str(r2_poly, 6)]);
disp(['Error Estándar (Sx/y): ' num2str(Sx_y_poly, 6)]);
function [a, r2, Sx_y, regression_func] = multipleLinearRegression(X_data, y)
% MULTIPLELINEARREGRESSION Ajusta los datos al modelo lineal múltiple.

    y = y(:);
    [n, m] = size(X_data);

    % COFRECCIÓN: El número de puntos debe ser ESTRICTAMENTE mayor que el número de coeficientes.
    if n <= m + 1
        % En este caso, el modelo está sobre-especificado o es un ajuste perfecto forzado
        warning('Pocos puntos de datos (n <= m + 1). Los grados de libertad son <= 0. La precisión del modelo es cuestionable.');
        % Devolvemos NaN para los parámetros de ajuste que requieren grados de libertad
        a = NaN(m + 1, 1);
        r2 = NaN;
        Sx_y = NaN;
        regression_func = @(x_pred) NaN;
        return;
    end

    % ... (Pasos 1 y 2: Construcción de X, Z, b_vec) ...
    X = [ones(n, 1), X_data]; 
    Z = X' * X; 
    b_vec = X' * y; 
    
    % ... (Paso 3: Solución) ...
    a = Z \ b_vec; 
    
    % ... (Paso 4: Cálculo de r^2 y Sx/y) ...
    y_hat = X * a; 
    y_bar = mean(y);
    St = sum((y - y_bar).^2);
    Sr = sum((y - y_hat).^2);
    
    % Coeficiente de Determinación (r2)
    if St == 0
        r2 = 1;
    else
        r2 = 1 - (Sr / St);
    end
    
    % Error Estándar del Estimado (Sx/y)
    degrees_of_freedom = n - (m + 1);
    
    % Garantizamos que degrees_of_freedom > 0 por la comprobación inicial
    Sx_y = sqrt(Sr / degrees_of_freedom);

    % ... (Paso 5: Función de Regresión) ...
    regression_func = @(x_pred) [1, x_pred(:)'] * a;
end

% Ejemplo

% Datos de ejemplo (n=5 puntos, m=2 variables)
X1 = [1; 2; 3; 4; 5]; % Variable x1
X2 = [0.5; 1.5; 3.0; 4.0; 6.0]; % Variable x2
Y  = [10; 13; 17; 21; 24]; % Variable dependiente y

% Matriz de datos de entrada X_data (n x m)
X_data = [X1, X2]; 

[a_mult, r2_mult, Sx_y_mult, func_mult] = multipleLinearRegression(X_data, Y);

disp('--- Regresión Lineal Múltiple (m=2) ---');
disp('Coeficientes a = [a0; a1; a2]:');
disp(a_mult');
disp(['Coeficiente de Determinación (r^2): ' num2str(r2_mult, 6)]);
disp(['Error Estándar (Sx/y): ' num2str(Sx_y_mult, 6)]);



%% Regresion no lineal

function [A_final, iterations, r2] = gaussNewton(x, y, A0, error_goal, max_iter)

    x = x(:);
    y = y(:);
    n = length(x);
    A_current = A0(:); % Coeficientes actuales [alpha1; beta1]
    
    disp('Iniciando Método Gauss-Newton (Modelo Exponencial)...');

    for j = 1:max_iter
        
        % Extraer coeficientes actuales
        alpha1 = A_current(1);
        beta1 = A_current(2);
        
        % --- A. Calcular el Vector de Diferencias (D) y la Matriz Jacobiana (Z) ---
        
        % 1. Predicciones (y_hat)
        % f(x) = alpha1 * exp(beta1 * x)
        y_hat = alpha1 * exp(beta1 * x);
        
        % 2. Vector de Diferencias (Residuales)
        % D = y_observado - y_estimado
        D = y - y_hat;
        
        % 3. Matriz Jacobiana (Z, de tamaño n x 2)
        Z = zeros(n, 2);
        
        % Columna 1: d(f)/d(alpha1) = exp(beta1 * x)
        Z(:, 1) = exp(beta1 * x);
        
        % Columna 2: d(f)/d(beta1) = alpha1 * x * exp(beta1 * x)
        Z(:, 2) = alpha1 * x .* exp(beta1 * x);
        
        % --- B. Resolver el Sistema Lineal Z' * Z * DeltaA = Z' * D ---
        
        % Lado izquierdo (LHS)
        LHS = Z' * Z;
        
        % Lado derecho (RHS)
        RHS = Z' * D;
        
        % Solución del sistema lineal para obtener el vector de correcciones (DeltaA)
        DeltaA = LHS \ RHS;
        
        % --- C. Criterio de Parada y Actualización ---
        
        % 1. Criterio de Parada (Error basado en la norma de DeltaA)
        error_norm = norm(DeltaA);
        
        % fprintf('Iteración %d: Error de corrección = %.6f\n', j, error_norm);

        if error_norm < error_goal
            A_final = A_current;
            iterations = j;
            break; % Convergencia exitosa
        end
        
        % 2. Actualización de los coeficientes
        A_current = A_current + DeltaA;
    end

    % Si el bucle termina sin convergencia
    if j == max_iter
        warning('Gauss-Newton no convergió después de %d iteraciones.', max_iter);
        A_final = A_current;
        iterations = max_iter;
    end
    
    % --- D. Cálculo del r^2 Final ---
    y_final_hat = A_final(1) * exp(A_final(2) * x);
    y_bar = mean(y);
    St = sum((y - y_bar).^2);
    Sr = sum((y - y_final_hat).^2);
    
    if St == 0
        r2 = 1;
    else
        r2 = 1 - (Sr / St);
    end
end

% Datos de Ejemplo
x_data = [5; 10; 15; 20; 25; 30; 35; 40; 45; 50];
y_data = [17; 24; 31; 33; 37; 37; 40; 40; 42; 41];

% --- 1. Obtener la Estimación Inicial A0 (de la regresión linealizada) ---
% Usamos la función exponentialModel que ya implementamos (retorna alpha1, beta1)
[alpha1_init, beta1_init, ~, ~] = exponentialModel(x_data, y_data);

A_initial = [alpha1_init; beta1_init]; % [alpha1; beta1]

% --- 2. Parámetros del Método ---
TOLERANCE = 1e-6; % 0.000001
MAX_ITERS = 50;

% --- 3. Ejecución del Método Gauss-Newton ---
[A_final_gn, iters_gn, r2_gn] = gaussNewton(x_data, y_data, A_initial, TOLERANCE, MAX_ITERS);

disp(' ');
disp('--- Resultados Finales de Gauss-Newton ---');
disp('Coeficientes Finales [alpha1; beta1]:');
disp(A_final_gn');
disp(['Iteraciones: ' num2str(iters_gn)]);
disp(['R^2 Final: ' num2str(r2_gn)]);

%% Polinomios de Legendre

function Pj = legendrePoly(x_bar, j)
% LEGENDREPOLY Calcula el valor del polinomio de Legendre de grado j en x_bar.
% x_bar debe estar en el rango [-1, 1].

    if j == 0
        Pj = ones(size(x_bar));
        return;
    elseif j == 1
        Pj = x_bar;
        return;
    end
    
    % Inicializar P(j-1) y P(j-2)
    P_prev = x_bar; % P1(x_bar)
    P_prev_prev = ones(size(x_bar)); % P0(x_bar)
    Pj = zeros(size(x_bar));
    
    % Aplicar la relación de recurrencia para j = 2 hasta el grado deseado
    for k = 1:j-1
        % (k+1) P_{k+1}(x) = (2k+1) x P_k(x) - k P_{k-1}(x)
        Pj = ((2*k + 1) * x_bar .* P_prev - k * P_prev_prev) / (k + 1);
        
        % Actualizar para la siguiente iteración
        P_prev_prev = P_prev;
        P_prev = Pj;
    end
end

function [c, r2, Sx_y, regression_func] = legendreRegression(x, y, m)
% LEGENDEREREGRESSION Ajusta datos a una suma de polinomios de Legendre de grado m.
%
% Entradas:
%   x, y - Vectores de datos.
%   m    - Grado máximo del polinomio.

    x = x(:);
    y = y(:);
    n = length(x);
    
    % --- 1. Escalamiento de Datos ---
    x_min = min(x);
    x_max = max(x);
    
    if x_max == x_min
         error('Los valores de x son idénticos; no se puede escalar.');
    end
    
    % x_bar = (2x - (xmax + xmin)) / (xmax - xmin)
    x_bar = (2 * x - (x_max + x_min)) / (x_max - x_min);
    
    % --- 2. Cálculo Directo de los Coeficientes (c_j) ---
    c = zeros(m + 1, 1); % Vector de coeficientes [c0, c1, ..., cm]
    y_hat = zeros(n, 1); % Vector de predicciones
    
    for j = 0:m
        % 2.1. Calcular P_j(x_bar) para todos los puntos
        Pj_values = legendrePoly(x_bar, j);
        
        % 2.2. Calcular el numerador: Sum(y_i * P_j(x_bar_i))
        numerator = sum(y .* Pj_values);
        
        % 2.3. Calcular el denominador: Sum([P_j(x_bar_i)]^2)
        denominator = sum(Pj_values.^2);
        
        if denominator == 0
             warning('El denominador es cero para el coeficiente c%d.', j);
             c(j + 1) = 0;
        else
             % 2.4. Calcular el coeficiente c_j
             c(j + 1) = numerator / denominator;
        end
        
        % 2.5. Acumular la predicción
        y_hat = y_hat + c(j + 1) * Pj_values;
    end
    
    % --- 3. Cálculo de la Bondad de Ajuste (r^2) y Error Estándar ---
    
    y_bar = mean(y);
    St = sum((y - y_bar).^2);
    Sr = sum((y - y_hat).^2);
    
    if St == 0
        r2 = 1;
    else
        r2 = 1 - (Sr / St);
    end
    
    % Error Estándar (Sx/y)
    degrees_of_freedom = n - (m + 1);
    if degrees_of_freedom <= 0
        Sx_y = NaN; 
    else
        Sx_y = sqrt(Sr / degrees_of_freedom);
    end
    
    % --- 4. Función de Regresión (Polinomio de Legendre) ---
    regression_func = @(x_val) LegendreRegressionPredict(x_val, c, x_min, x_max);
end

% Función auxiliar para la predicción, ya que requiere escalamiento
function y_pred = LegendreRegressionPredict(x_val, c, x_min, x_max)
    m = length(c) - 1;
    
    % Escalamiento del nuevo valor x_val
    x_bar_val = (2 * x_val - (x_max + x_min)) / (x_max - x_min);
    
    % Calcular la predicción
    y_pred = zeros(size(x_val));
    for j = 0:m
        Pj_values = legendrePoly(x_bar_val, j);
        y_pred = y_pred + c(j + 1) * Pj_values;
    end
end

% Ejemplo

x_data = [5; 10; 15; 20; 25; 30; 35; 40; 45; 50];
y_data = [17; 24; 31; 33; 37; 37; 40; 40; 42; 41];

m = 10; % Grado del polinomio de Legendre

[c_legendre, r2_legendre, ~, func_legendre] = legendreRegression(x_data, y_data, m);

disp(['Coeficientes Legendre (c_j): ' num2str(c_legendre')]);
disp(['R^2: ' num2str(r2_legendre)]);

figure;
scatter(x_data, y_data, 'filled');
hold on;
plot_x = linspace(min(x_data), max(x_data), 100);
plot(plot_x, func_legendre(plot_x), 'm-', 'LineWidth', 2.5);
title(['Regresión Legendre (m=' num2str(m) ', R^2=' num2str(r2_legendre, 3) ')']);
xlabel('x');
ylabel('y');
legend('Datos Originales', 'Curva de Regresión', 'Location', 'south');
grid on;
hold off;