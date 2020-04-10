function w = geragrafo(corte)
    
    corte = im2bw(corte);
    [y x] = find(corte==0);
    n = size(x);
    m = size(y);

    n = n(1);
    m = m(1);
    
    w = zeros(n,m);
    
    for i=1:n
        for j=1:m
            
                w(i,j) = sqrt((x(i)-x(j))^2 + (y(i)-y(j))^2);            
        end
    end
    
    maior = max(w(:));
    
    w = w/maior;
end


