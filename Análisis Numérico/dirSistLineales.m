%% - - - - - - - - - - - - - - -
% Métodos directos para solucionar
% Sistemas Lineales
% Simón Vélez                 
% Análisis Numérico           
% 2025 11 04
% - - - - - - - - - - - - - -


% Ejemplo a resolver (con el sistema en forma de matriz aumentada)

Aug = [2 -6 -1 -38; 
       -3 -1 7 -34; 
       -8 1 -2 -20];
Aug2 = [3 -0.1 -0.2 7.85;
        0.1 7 -0.3 -19.3;
        0.3 -0.2 10 71.4];

% Resolver el sistema
[vector_solucion, matriz_triangular_superior] = elimGauss_pivEscalado(Aug2);

disp('Vector Solución x:');
disp(vector_solucion);

% Ejemplo a resolver 2 (Para fact LU)

A2 = [3 -0.1 -0.2;
        0.1 7 -0.3;
        0.3 -0.2 10];
b = [7.85, -19.3, 71.4];

Aug2 = [3 -0.1 -0.2 7.85;
        0.1 7 -0.3 -19.3;
        0.3 -0.2 10 71.4];

[L, U] = LUFactorization(A2);
x = LUSolve(L, U, b);

disp('Vector Solución x (usando LU):');
disp(x);

A_inversa_LU = LUInverse(A2);
disp(A_inversa_LU);

%% Eliminacion Gaussiana

function [x, A_triangular] = elimGauss(Aug)
% Aug: la matriz aumentada [A | b]

    % Tamaño de la matriz de coef A (n x n)
    [n, m] = size(Aug);
    
    % Verificar si la matriz es una matriz aumentada válida (A debe ser cuadrada)
    if n ~= (m - 1)
        error('La matriz de entrada no es una matriz aumentada válida [A|b] donde A es cuadrada.');
    end
    
    % Inicializar la matriz de trabajo para la eliminación hacia adelante
    A_triangular = Aug;
    
    % Eliminación hacia Adelante (Creando una Matriz Triangular Superior
    
    % Iterar a través de cada columna (posición del pivote i)
    for i = 1:n 
        
        % Verificar si el elemento pivote (A_ii) es cero, lo que evitaría la división.
        if A_triangular(i, i) == 0
            error('Se encontró un pivote cero en la fila %d. Se requiere pivotear :(.', i);
        end
        
        % Iterar a través de las filas debajo de la fila del pivote actual
        for j = i + 1:n
            % Calcular el factor (multiplicador) necesario para hacer A_ji cero
            % Fórmula: factor = A_ji / A_ii
            factor = A_triangular(j, i) / A_triangular(i, i);
            
            % Aplicar la operación de eliminación a la fila j: 
            % E_j = E_j - (factor * E_i)
            A_triangular(j, :) = A_triangular(j, :) - factor * A_triangular(i, :);
        end
    end
    
    % Sustitución hacia Atrás (Resolviendo para las variables)
    
    % Inicializar el vector solución x
    x = zeros(n, 1);
    
    % Separar la matriz de coeficientes (A) y el vector constante (b)
    A_coeff = A_triangular(:, 1:n);
    b_vec = A_triangular(:, end);
    
    % Resolver para la última variable (x_n)
    % x_n = b_n / A_nn
    x(n) = b_vec(n) / A_coeff(n, n);
    
    % Iterar hacia arriba desde la penúltima fila (n-1) hasta la primera fila (1)
    for i = n - 1:-1:1
        % Calcular la suma de términos que involucran variables ya resueltas (x_k donde k > i)
        sum_of_solved = 0;
        for k = i + 1:n
            sum_of_solved = sum_of_solved + A_coeff(i, k) * x(k);
        end
        
        % Resolver para x_i usando la fórmula despejada:
        % x_i = (b_i - sum(A_ik * x_k)) / A_ii
        x(i) = (b_vec(i) - sum_of_solved) / A_coeff(i, i);
    end

end

%% Pivoteo Parcial

function [x, A_triangular] = elimGauss_pivParcial(Aug)
% Aug: la matriz aumentada [A | b]

    % Tamaño de la matriz de coef A (n x n)
    [n, m] = size(Aug);
    
    % Verificar si la matriz es una matriz aumentada válida (A debe ser cuadrada)
    if n ~= (m - 1)
        error('La matriz de entrada no es una matriz aumentada válida [A|b] donde A es cuadrada.');
    end
    
    % Inicializar la matriz de trabajo para la eliminación hacia adelante
    A_triangular = Aug;
    
    % Eliminación hacia Adelante (Creando una Matriz Triangular Superior
    
    % Iterar a través de cada columna (posición del pivote i)
    for i = 1:n % Encontrar el pivote mas grande 
        
        % Encontrar el valor máximo absoluto en la subcolumna actual (desde la fila i hasta n)
        [~, max_idx] = max(abs(A_triangular(i:n, i)));
        
        % Calcular la fila pivote real (p) en toda la matriz
        p = (i - 1) + max_idx; 
        
        % Verificar si es necesario el intercambio de filas (si p es diferente de i)
        if p ~= i
            % Intercambiar la fila actual (E_i) con la fila del máximo (E_p)
            temp_row = A_triangular(i, :);
            A_triangular(i, :) = A_triangular(p, :);
            A_triangular(p, :) = temp_row;
        end
        
        % Si es cero, la matriz es singular y el sistema no tiene solución única.
        if A_triangular(i, i) == 0
            error('El sistema es singular (se encontro pivote 0) :(');
        end
        
        % Eliminacion: Aplicar la fórmula E_j - (factor * E_i) -> E_j
        
        % Iterar a través de las filas debajo de la fila del pivote
        for j = i + 1:n
            % Calcular el factor (multiplicador)
            factor = A_triangular(j, i) / A_triangular(i, i);
            
            % Aplicar la operación de eliminación a toda la fila
            A_triangular(j, :) = A_triangular(j, :) - factor * A_triangular(i, :);
        end
    end
    
    % Sustitución hacia Atrás (Sin cambios respecot a sin pivote)
    
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

%% Pivoteo Escalado

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

%% Factorizacion LU

function [L, U] = LUFactorization(A)
% Descompone la matriz A en LU sin pivoteo.

    [n, ~] = size(A);
    
    % Inicializar L como la matriz identidad y U como la matriz A
    L = eye(n);
    U = A;
    
    % Eliminación hacia adelante
    for i = 1:n % Columna pivote
        
        % Verificar pivote cero
        if U(i, i) == 0
            error('Pivote cero encontrado. Se requiere pivoteo para la factorización.');
        end
        
        for j = i + 1:n % Fila a eliminar (debajo del pivote)
            
            % Calcular el multiplicador (factor)
            factor = U(j, i) / U(i, i);
            
            % Almacenar el factor en L
            L(j, i) = factor;
            
            % Aplicar la operación de eliminación a la fila U(j, :)
            U(j, :) = U(j, :) - factor * U(i, :);
        end
    end
end

function x = LUSolve(L, U, b)
% Resuelve Ax=b usando las matrices L y U pre-calculadas.

    n = length(b);
    
    % --- Paso 1: Resolver Ly = b (Sustitución hacia Adelante) ---
    y = zeros(n, 1);
    
    % Resuelve y(1)
    y(1) = b(1) / L(1, 1); % L(1,1) siempre es 1 en unitaria
    
    % Iterar hacia abajo para el resto de y
    for i = 2:n
        sum_Ly = L(i, 1:i-1) * y(1:i-1); % Suma de L_ik * y_k (k < i)
        y(i) = (b(i) - sum_Ly) / L(i, i); % L(i,i) siempre es 1 en unitaria
    end
    
    % --- Paso 2: Resolver Ux = y (Sustitución hacia Atrás) ---
    x = zeros(n, 1);
    
    % Resuelve x(n)
    x(n) = y(n) / U(n, n);
    
    % Iterar hacia arriba para el resto de x
    for i = n - 1:-1:1
        sum_Ux = U(i, i+1:n) * x(i+1:n); % Suma de U_ik * x_k (k > i)
        x(i) = (y(i) - sum_Ux) / U(i, i);
    end
end

function A_inv = LUInverse(A)
% Calcula la inversa de la matriz A usando la Factorización LU.

    [n, ~] = size(A);

    % Paso 1: Factorizar A = LU (se asume que LUFactorization existe)
    try
        [L, U] = LUFactorization(A);
    catch
        error('Error en la factorización LU. La matriz puede ser singular o requerir pivoteo.');
    end
    
    % Inicializar la matriz inversa
    A_inv = zeros(n, n);
    
    % La matriz identidad I, cuyas columnas usaremos como vector b
    I = eye(n);
    
    % Iterar sobre cada columna j de la matriz identidad I
    for j = 1:n
        
        % El vector del lado derecho para este sistema es la columna j de I
        b_j = I(:, j);
        
        % --- Paso 2: Resolver Ly = b_j (Sustitución hacia Adelante) ---
        y_j = zeros(n, 1);
        y_j(1) = b_j(1) / L(1, 1);
        
        for i = 2:n
            sum_Ly = L(i, 1:i-1) * y_j(1:i-1);
            y_j(i) = (b_j(i) - sum_Ly) / L(i, i);
        end
        
        % --- Paso 3: Resolver U x^(j) = y^(j) (Sustitución hacia Atrás) ---
        x_j = zeros(n, 1);
        
        % Resuelve x_j(n)
        x_j(n) = y_j(n) / U(n, n);
        
        % Iterar hacia arriba
        for i = n - 1:-1:1
            sum_Ux = U(i, i+1:n) * x_j(i+1:n);
            x_j(i) = (y_j(i) - sum_Ux) / U(i, i);
        end
        
        % La solución x_j es la columna j de la matriz inversa A_inv
        A_inv(:, j) = x_j;
    end
end