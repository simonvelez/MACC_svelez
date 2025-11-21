%% - - - - - - - - - - - - - - -
% Diferencias finitas - Ecuacion de conduccion de calor
% Simón Vélez                 
% Análisis Numérico           
% - - - - - - - - - - - - - -

% Necesitamos en cierto punto solucionar un sistema matricial


function [x, A_triangular] = elimGauss_pivEscalado(Aug)
% Aug: la matriz aumentada [A | b]

    % Tamaño de la matriz de coef A (n x n)
    [n, m] = size(Aug);
    
    % Verificar si la matriz es una matriz aumentada válida (A debe ser cuadrada)
    if n ~= (m - 1)
        error('La matriz de entrada no es una matriz aumentada válida [A|b] donde A es cuadrada.');
    end

    % Inicializar la matriz de trabajo
    A_triangular = Aug;
    
    % Extraer solo la matriz de coeficientes A para el cálculo de escalas
    A_coeff = A_triangular(:, 1:n);
    
    % Determinar el vector de factores de escala (s) 

    % si = max |aij| para i <= j <= n (máximo absoluto de la fila)
    s = zeros(n, 1);
    for i = 1:n
        % Calcular el máximo absoluto de los coeficientes de la fila i
        s(i) = max(abs(A_coeff(i, :)));
    end
    
    % Vector para mantener el orden original de las filas.
    row_order = 1:n; 

    % Eliminación hacia Adelante con Pivoteo Escalado
    
    % Iterar a través de cada columna (posición del pivote i)
    for i = 1:n 
        
        % 1. Calcular la razón de pivote escalada (cociente) para la subcolumna actual
        pivot_ratios = zeros(n - i + 1, 1);
        
        % Calcular la razón para cada fila candidata (desde i hasta n)
        for k_idx = 1:(n - i + 1)
            k = i - 1 + k_idx; % Índice de fila absoluto
            
            % El índice del factor de escala (s_idx) corresponde a la fila original de la fila actual k.
            s_idx = row_order(k); 
            
            % Verificar si el factor de escala es cero (fila de ceros)
            if s(s_idx) == 0
                % Si toda la fila es cero, la razón es 0.
                pivot_ratios(k_idx) = 0; 
            else
                % Razón: |a_ki| / s_k
                pivot_ratios(k_idx) = abs(A_triangular(k, i)) / s(s_idx);
            end
        end
        
        % 2. Encontrar el índice del máximo cociente (max_ratio)
        [~, max_idx_relativo] = max(pivot_ratios);
        
        % 3. Determinar la fila pivote real (p) en toda la matriz
        p = (i - 1) + max_idx_relativo;
        
        % 4. Realizar el intercambio de filas si es necesario
        if p ~= i
            % Intercambiar la fila actual (E_i) con la fila del máximo (E_p)
            temp_row = A_triangular(i, :);
            A_triangular(i, :) = A_triangular(p, :);
            A_triangular(p, :) = temp_row;
            
            % Intercambiar también el orden de las filas
            temp_order = row_order(i);
            row_order(i) = row_order(p);
            row_order(p) = temp_order;
        end
        
        % Verificar si el nuevo pivote es cero después del intercambio
        if A_triangular(i, i) == 0
            error('El sistema es singular (se encontro un pivote 0) :(');
        end
        
        % Eliminacion Aplicar la fórmula E_j - (factor * E_i) -> E_j
        
        % Iterar a través de las filas debajo de la fila del pivote
        for j = i + 1:n
            % Calcular el factor (multiplicador)
            factor = A_triangular(j, i) / A_triangular(i, i);
            
            % Aplicar la operación de eliminación a toda la fila
            A_triangular(j, :) = A_triangular(j, :) - factor * A_triangular(i, :);
        end
    end
    
    % Sustitución hacia Atrás (Sin cambios)
    
    % Inicializar el vector solución x
    x = zeros(n, 1);
    
    % Separar la matriz de coeficientes (A) y el vector constante (b)
    A_coeff = A_triangular(:, 1:n);
    b_vec = A_triangular(:, end);
    
    % Resolver para la última variable (x_n)
    x(n) = b_vec(n) / A_coeff(n, n);
    
    % Iterar hacia arriba
    for i = n - 1:-1:1
        % Calcular la suma de términos que involucran variables ya resueltas
        sum_of_solved = 0;
        for k = i + 1:n
            sum_of_solved = sum_of_solved + A_coeff(i, k) * x(k);
        end
        
        % Resolver para x_i
        x(i) = (b_vec(i) - sum_of_solved) / A_coeff(i, i);
    end

end


function [T_full] = heatConductionFD(x_nodes, h_prime, Ta, T1, T2)
% Ecuación: d^2T/dx^2 + h'(Ta - T) = 0
%
% Entradas:
%   x_nodes - Vector con las coordenadas de los nodos [x0, x1, ..., xn, xn+1].
%   h_prime - Coeficiente de transferencia de calor modificado (h').
%   Ta      - Temperatura ambiente.
%   T1      - Temperatura en la frontera izquierda (x = x0).
%   T2      - Temperatura en la frontera derecha (x = xL).
%
% Salida:
%   T_full  - Vector con las temperaturas calculadas en todos los nodos.

    % 1. Determinar parámetros de la malla
    n_total = length(x_nodes);
    n_internal = n_total - 2; % Número de incógnitas (nodos internos)
    
    % Asumimos paso constante dx basado en los dos primeros nodos
    dx = x_nodes(2) - x_nodes(1);
    
    % 2. Pre-cálculo de constantes del método
    % Basado en la ecuación discretizada: -T_{i-1} + (2 + h'dx^2)T_i - T_{i+1} = h'dx^2Ta
    K = h_prime * (dx^2);       % Término h' * delta_x^2
    diag_val = 2 + K;           % Valor de la diagonal principal
    rhs_base = K * Ta;          % Valor base del lado derecho (h' * delta_x^2 * Ta)
    
    % 3. Inicialización de Matriz A y Vector b
    A = zeros(n_internal, n_internal);
    b = zeros(n_internal, 1);
    
    % 4. Construcción del Sistema Lineal (Filas 1 a n)
    for i = 1:n_internal
        % Elemento de la diagonal principal
        A(i, i) = diag_val;
        
        % Término del lado derecho (RHS)
        b(i) = rhs_base;
        
        % Conexión con nodo izquierdo (T_{i-1})
        if i == 1
            % Si es el primer nodo interno, T_{i-1} es la frontera T1.
            % Pasa al lado derecho sumando.
            b(i) = b(i) + T1;
        else
            % Si es un nodo interior normal, colocar -1 en la diagonal inferior
            A(i, i-1) = -1;
        end
        
        % Conexión con nodo derecho (T_{i+1})
        if i == n_internal
            % Si es el último nodo interno, T_{i+1} es la frontera T2.
            % Pasa al lado derecho sumando.
            b(i) = b(i) + T2;
        else
            % Si es un nodo interior normal, colocar -1 en la diagonal superior
            A(i, i+1) = -1;
        end
    end
    
    % Mostrar la matriz y el vector b para verificar con tu imagen
    disp('--- Matriz del Sistema (A) ---');
    disp(A);
    disp('--- Vector del Lado Derecho (b) ---');
    disp(b);
    
    Aug = [A, b];
    [T_internal, ~] = elimGauss_pivEscalado(Aug);
    
    % 6. Combinar con fronteras para el resultado final
    T_full = [T1; T_internal; T2];
end

% Definición de los nodos (5 segmentos = 6 nodos en total)
% L = 10, dx = 2 -> Nodos en 0, 2, 4, 6, 8, 10
x_nodos = 0:2:10;

% Parámetros deducidos de tu imagen
h_prima = 0.01; 
Ta = 20;        % Temperatura ambiente
T1 = 40;        % Frontera izquierda
T2 = 200;       % Frontera derecha

% Llamada a la función
fprintf('Resolviendo para %d nodos internos...\n', length(x_nodos)-2);
T_resultado = heatConductionFD(x_nodos, h_prima, Ta, T1, T2);

% Mostrar resultados
disp('--- Vector de Temperaturas Final (T) ---');
disp(table(x_nodos', T_resultado, 'VariableNames', {'Posicion_x', 'Temperatura_T'}));

