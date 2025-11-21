%% - - - - - - - - - - - - - - -
% Métodos iterativos para solucionar
% Sistemas Lineales
% Simón Vélez                 
% Análisis Numérico           
% 2025 11 04
% - - - - - - - - - - - - - -

%% Jacobi

function [x, iterations] = jacobiMethod(A, b, x0, error_goal)
    
    % --- 1. Preparación de Matrices ---
    
    d = diag(A);                 % Vector columna de la diagonal
    L_plus_U = diag(diag(A)) - A;    % Matriz L + U (A sin la diagonal)
    
    % Tj = D^-1 * (L + U)
    D_inv = diag(1./d);
    Tj = D_inv * L_plus_U;
    
    % cj = D^-1 * b. Usamos división elemento a elemento para mayor robustez
    b = b(:); 
    d = d(:);
    cj = b ./ d; 
    
    % --- 2. Inicialización ---
    
    x = x0(:); % Asegurar que x0 sea un vector columna n x 1
    x_prev = x;
    
    max_iter = 1000;
    tol_error = 1e-4; 
    
    if nargin == 4
        tol_error = error_goal;
    end
    
    % --- 3. Bucle de Iteración ---
    
    for k = 1:max_iter
        
        % Fórmula de Jacobi: x(k) = Tj * x(k-1) + cj
        % Tj (n x n) * x_prev (n x 1) + cj (n x 1) = x (n x 1)
        x = Tj * x_prev + cj;
        
        % Criterio de parada (error relativo)
        if all(abs(x_prev) > eps)
            error_relativo = max(abs(x - x_prev) ./ abs(x));
            
            if error_relativo < tol_error
                iterations = k;
                return;
            end
        end
        
        x_prev = x;
    end
    
    iterations = max_iter;
    warning('No convergió en %d iteraciones.', max_iter);
end

% Ejemplo 

A =[15 -3 -1; -3 18 -6; -4 -1 12];
b = [3800, 1200, 2350];
x0 = zeros(3, 1); % respuesta inicial

error_meta = 0.001;
[x_goal, k_goal] = jacobiMethod(A, b, x0, error_meta);
disp(['Meta de Error: ' num2str(error_meta)]);
disp(['Iteraciones: ' num2str(k_goal)]);
disp('Solución x:');
disp(x_goal);

%% Gauss-Siedel

function [x, iterations] = gaussSeidelMethod(A, b, x0, error_goal)
    
    % ASEGURAR DIMENSIONES DE COLUMNA para vectores
    b = b(:); 
    x0 = x0(:);
    
    % --- 1. Descomposición de la Matriz (A = D + L + U) ---
    
    D = diag(diag(A));        % Matriz Diagonal
    L = tril(A, -1);          % Triangular Inferior Estricta
    U = triu(A, 1);           % Triangular Superior Estricta
    
    D_plus_L = D + L;
    
    % Verificar invertibilidad (singularidad)
    if rcond(D_plus_L) < eps
        error('La matriz (D + L) es singular o casi singular.');
    end
    
    % --- 2. Cálculo de las Matrices de Iteración ---
    
    % Tg = - (D + L) \ U
    Tg = - (D_plus_L \ U);
    
    % cg = (D + L) \ b
    % ¡CORRECCIÓN APLICADA: b está garantizado a ser columna!
    cg = D_plus_L \ b; 
    
    % --- 3. Inicialización y Criterios de Parada ---
    
    x = x0; 
    x_prev = x;
    
    max_iter = 1000;
    tol_error = 1e-4; 
    
    if nargin == 4
        tol_error = error_goal;
    end
    
    % --- 4. Bucle de Iteración ---
    
    for k = 1:max_iter
        
        % Fórmula de Gauss-Seidel: x(k) = Tg * x(k-1) + cg
        x = Tg * x_prev + cg;
        
        % Criterio de parada (error relativo)
        if all(abs(x_prev) > eps)
            error_relativo = max(abs(x - x_prev) ./ abs(x));
            
            if error_relativo < tol_error
                iterations = k;
                return;
            end
        end
        
        x_prev = x;
    end
    
    iterations = max_iter;
    warning('No convergió en %d iteraciones.', max_iter);
end

% Ejemplo 

A =[15 -3 -1; -3 18 -6; -4 -1 12];
b = [3800, 1200, 2350];
x0 = zeros(3, 1); % respuesta inicial

error_meta = 0.001;
[x_goal, k_goal] = gaussSeidelMethod(A, b, x0, error_meta);
disp(['Meta de Error: ' num2str(error_meta)]);
disp(['Iteraciones: ' num2str(k_goal)]);
disp('Solución x:');
disp(x_goal);


%% Refinamiento iterativo

% Para las iteraciones usare una version modificada de LU

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

function y_intermedia = LUSolveForward(L, b, n)
% Resuelve Ly = b para obtener y_intermedia.

    b = b(:);
    y_intermedia = zeros(n, 1);
    
    % La division por L(1, 1)=1 se omite.
    y_intermedia(1) = b(1); 
    
    for i = 2:n
        sum_Ly = L(i, 1:i-1) * y_intermedia(1:i-1);
        % mitir la division por L(i, i)=1
        y_intermedia(i) = (b(i) - sum_Ly); 
    end
end

function x = LUSolveBackward(U, y_intermedia, n)
% Resuelve Ux = y_intermedia para obtener x.

    y_intermedia = y_intermedia(:);
    x = zeros(n, 1);
    
    x(n) = y_intermedia(n) / U(n, n);
    
    for i = n - 1:-1:1
        sum_Ux = U(i, i+1:n) * x(i+1:n);
        x(i) = (y_intermedia(i) - sum_Ux) / U(i, i);
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

function [x, iterations] = iterativeRefinement(A, b, x0, error_goal)

    [n, ~] = size(A);

    % --- 1. Factorización LU (Se hace solo una vez) ---
    try
        [L, U] = LUFactorization(A);
    catch
        error('La factorización LU falló. No se puede proceder con el refinamiento.');
    end
    
    % --- 2. Inicialización ---
    
    x = x0(:);              % Solución actual (x_tilde)
    max_iter = 100;         % Límite de seguridad
    tol_error = error_goal; % Tolerancia
    
    % --- 3.refinamiento ---
    
    for k = 1:max_iter
        
        % 3.1. Calcular el Residual (r = b - A*x_tilde)
        r = b - (A * x);
        
        % 3.2. Resolver el Sistema Residual (A*y = r)
        y_intermedia = LUSolveForward(L, r, n); 
        
        % b) U*y = y_intermedia (Sustitución hacia Atrás)
        y = LUSolveBackward(U, y_intermedia, n);
        
        % 3.3. Refinar la Solución (x_nuevo = x_viejo + y)
        x_new = x + y;
        
        % 3.4. Criterio de Parada
        if all(abs(x) > eps)
            % Error relativo: max(|x_nuevo - x_viejo| / |x_nuevo|)
            error_relativo = max(abs(x_new - x) ./ abs(x_new));
            
            if error_relativo < tol_error
                iterations = k;
                x = x_new;
                return; % Convergencia exitosa
            end
        end
        
        % Actualizar para la siguiente iteración
        x = x_new;
    end
    
    iterations = max_iter;
    warning('El método no convergió en %d iteraciones.', max_iter);
end

% Ejemplo de uso con una matriz simple
A = [3 -0.1 -0.2;
        0.1 7 -0.3;
        0.3 -0.2 10];
b = [7.85, -19.3, 71.4];
% Solución inicial A*x0 = b (usando la función LUSolve que ya tienes)
[L, U] = LUFactorization(A);
x_inicial = LUSolve(L, U, b); 

error_meta = 1e-6; % Meta de error muy pequeña (0.0001%)

% Aplicar el Refinamiento Iterativo
[x_refinado, k_refinado] = iterativeRefinement(A, b, x_inicial, error_meta);

disp('--- Resultados del Refinamiento Iterativo ---');
disp(['Iteraciones de Refinamiento: ' num2str(k_refinado)]);
disp('Solución Inicial (LU):');
disp(x_inicial);
disp('Solución Refinada:');
disp(x_refinado);