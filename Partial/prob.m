function [matriz,graus] = prob(a)
    
    graus = sum(a);
    [l c] = size(a);
    nvert = c;
    ngraus = nvert;   
    
    matriz = zeros([ngraus ngraus]);
    
    for i=1:l
        for j=1:c
            if(a(i,j) == 1)
                matriz(graus(i),graus(j)) = matriz(graus(i),graus(j))+1;
            end        
        end        
    end

    nedges = sum(a(:));
    
    matriz = matriz/nedges;
end