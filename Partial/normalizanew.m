function [x1 x2 u1 u2] = normalizanew(n,t,setl,setc)
    qtdl = length(setl);
    qtdc = length(setc);
    [x1 u1] = centroidelocalnew('coleoptero',n,t,setc);
    [x2 u2] = centroidelocalnew('lagarta',n,t,setl);
    
    [l1 c1] =size(x1);
    [l2 c2] =size(x2);
    
    for i=1:l1
        
        x1(i,:) = x1(i,:)-u1;
        
    end    
    
    for i=1:l2
        
        x2(i,:) = x2(i,:)-u2;
        
    end      

end