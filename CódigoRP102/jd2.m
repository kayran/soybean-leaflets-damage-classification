function [H,E,P] = jd2(a)
    
    [matriz,graus] = prob(a);
    
    N  = length(graus);
    
    
    i = 1:length(matriz);
    size(matriz)
    i2 = (i-1).*length(matriz) + i;
    
    
    pk = matriz(i2);    
    H = -sum(pk.*log2(pk+eps));
    E = sum(pk.^2);
    P = mean(pk);
%    H = 0;
%    E = 0;
%    P = 0;
%    for i=1:N
%        pk = matriz(graus(i),graus(i));
%        H = H+pk*log2(pk+eps);
%        E = E + pk^2;
%        P = P + pk;        
%    end
%    H = -H;
%    P = P/N;
    endP = jd2(a)
    
    [matriz,graus] = prob(a);
    
    N  = length(graus);
    
    
    i = 1:length(matriz);
    size(matriz)
    i2 = (i-1).*length(matriz) + i;
    
    
    pk = matriz(i2);    
    H = -sum(pk.*log2(pk+eps));
    E = sum(pk.^2);
    P = mean(pk);
%    H = 0;
%    E = 0;
%    P = 0;
%    for i=1:N
%        pk = matriz(graus(i),graus(i));
%        H = H+pk*log2(pk+eps);
%        E = E + pk^2;
%        P = P + pk;        
%    end
%    H = -H;
%   