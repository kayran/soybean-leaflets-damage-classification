function [x1 x2 u1 u2] = normaliza2(matriz,labels,train)
    

    mpart = matriz(train,:);
    plabels = labels(train);
    
    
    x1=mpart(plabels==0,:);    

    x2=mpart(plabels==1,:);

    u1 = centroidelocal2(x1);
    u2 = centroidelocal2(x2);
    
    [l1 c1] =size(x1);
    [l2 c2] =size(x2);
    
    
    for i=1:l1
        
        x1(i,:) = x1(i,:)-u1;
        
    end    
    
    for i=1:l2
        
        x2(i,:) = x2(i,:)-u2;
        
    end      

end       