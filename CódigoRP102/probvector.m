function vprob = probvector(img,t)

%    t0 = 0.025;
%    tinc = 0.075;
%    tq = 0.875;
%    t = t0:tinc:tq;
    
    n = size(t);
    n = n(2);
    
    vprob = zeros([1 3*n]);
    
    for i=1:n
        
        w = geragrafo(img);
        a = removearestas(w,t(i));
        
        [H,E,P] = jd(a);
        
        vprob((3*i)-2)= H;
        vprob((3*i)-1)= E;
        vprob((3*i))  = P;
    end
end