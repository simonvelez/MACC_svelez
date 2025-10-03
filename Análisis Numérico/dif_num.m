%% - - - - - - - - - - - - - - -
% Diferenciación Numérica
% Simón Vélez                 
% Análisis Numérico           
% 2025 08 29
% - - - - - - - - - - - - - -

% Valores iniciales

X = [1.8, 1.9, 2.0, 2.1, 2.2];
fX = [10.889365, 12.703199, 14.778112, 17.148957, 19.855030];
h = 0.1;
x0 = 2;

%% Tres puntos por extremos

function  fprime_x0 = dTresEx(X, fX, x0, h)
    if length(X) < 3
        fprintf("Inserte mas datos :(")
    end
    
    x_step = X(2) - X(1);
    i_0 = int8((x0 - X(1))/(x_step) + 1); % Definir donde esta x0
    i = int8(h/x_step); % los pasos que hay que dar en la funcion segun el h
    
    fprime_x0 = (1/(2*h))*(-3*fX(i_0) + 4*fX(i_0+i) - fX(i_0+2*i));
end

fprintf("Con h = %.2f, f'(%.2f) = %.10f\n",...
    h, x0, dTresEx(X, fX, x0, h))

%% Tres puntos por medios

function  fprime_x0 = dTresMed(X, fX, x0, h)
    if length(X) < 3
        fprintf("Inserte mas datos :(")
    end
    
    x_step = X(2) - X(1);
    i_0 = round((x0 - X(1))/(x_step) + 1); % Definir donde esta x0
    i = round(h/x_step); % los pasos que hay que dar en la funcion segun el h
    
    fprime_x0 = (1/(2*h))*(fX(i_0 + i) - fX(i_0 - i));
end

fprintf("Con h = %.2f, f'(%.2f) = %.10f\n",...
    h, x0, dTresMed(X, fX, x0, h))


%% Cinco puntos por extremos

function  fprime_x0 = dCincoEx(X, fX, x0, h)
    if length(X) < 5
        fprintf("Inserte mas datos :(")
    end
    
    x_step = X(2) - X(1);
    i_0 = int8((x0 - X(1))/(x_step) + 1); % Definir donde esta x0
    i = int8(h/x_step); % los pasos que hay que dar en la funcion segun el h
    
    fprime_x0 = (1/(12*h))*(-25*fX(i_0) + 48*fX(i_0+i) - 36*fX(i_0+2*i) + 16*fX(i_0+3*i) - 3*fX(i_0+4*i));
end

fprintf("Con h = %.2f, f'(%.2f) = %.10f\n",...
    h, x0, dCincoEx(X, fX, x0, h))


%% Cinco puntos por medios

function  fprime_x0 = dCincoMed(X, fX, x0, h)
    if length(X) < 5
        fprintf("Inserte mas datos :(")
    end
    
    x_step = X(2) - X(1);
    i_0 = int8((x0 - X(1))/(x_step) + 1); % Definir donde esta x0
    i = int8(h/x_step); % los pasos que hay que dar en la funcion segun el h
    
    fprime_x0 = (1/(12*h))*(fX(i_0-2*i) - 8*fX(i_0-i) + 8*fX(i_0+i) - fX(i_0+2*i));
end

fprintf("Con h = %.2f, f'(%.2f) = %.10f\n",...
    h, x0, dCincoMed(X, fX, x0, h))


%% Segunda derivada

function  fdprime_x0 = d2Med(X, fX, x0, h)
    if length(X) < 3
        fprintf("Inserte mas datos :(")
    end
    
    x_step = X(2) - X(1);
    i_0 = int8((x0 - X(1))/(x_step) + 1); % Definir donde esta x0
    i = int8(h/x_step); % los pasos que hay que dar en la funcion segun el h
    
    fdprime_x0 = (1/(h^2))*(fX(i_0-i) - 2*fX(i_0) + fX(i_0+i));
end

fprintf("Con h = %.2f, f''(%.2f) = %.10f\n",...
    h, x0, d2Med(X, fX, x0, h))

%% Extrapolación de Richardson 

function R = richardson(X, fX, x0, h, m)
    R = zeros(m,m);
    
    % Primera columna: aproximaciones base con pasos h, h/2, h/4, ...
    for k = 1:m
        R(k,1) = dTresMed(X, fX, x0, h/2^(k-1));
    end
    
    % Tabla con los resultados
    for j = 2:m
        for k = j:m
            R(k,j) = R(k,j-1) + (R(k,j-1) - R(k-1,j-1))/(4^(j-1)-1);
        end
    end
end

% Ejemplo del taller 2

f = @(x) cos(x);

X = 0:0.01:2.0;  
fX = f(X);
x0 = pi/4;
h1 = pi/3;
% h2 = pi/6; % (está implícito en la función)

% Richardson 
R = richardson(X, fX, x0, h1, 2);

fprintf("N1(h=pi/3)   = %.6f\n", R(1,1));
fprintf("N1(h/2=pi/6)= %.6f\n", R(2,1));
fprintf('N2 (Richardson)= %.15f\n', R(2,2));