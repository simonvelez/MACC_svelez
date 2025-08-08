% - - - - - - - - - - - - - - -
% Metodo de Biseccion 250805  
% Simon Velez                 
% Analisis Numerico           
% 2025 08 05
% - - - - - - - - - - - - - -

A = 1;
B = 2;
Er = 0.02; %10^-5; % error relativo objetivo


function y = f(x) % funcion 
    y = x^3+4*x^2-10;
end

function e = err(a,b)
    e = abs((a-b)/b) * 100;
end

oldC = 1;
temp = 100;
while temp > Er 
    C = (A + B) / 2;
    fA = f(A);
    fB = f(B);
    fC = f(C);
    
    if fA * fC < 0
        B = C;
    elseif fB * fC < 0
        A = C;
    else
        disp("Raiz exacta o error")
        break;
    end

    temp = err(C, oldC);
    oldC = C;

end

fprintf("Raiz en x = %.10f con error relativo = %.10f\n%%", C, temp)



