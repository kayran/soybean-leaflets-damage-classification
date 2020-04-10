function classe = classifica(img)
    [x1 x2 u1 u2 u] = normaliza;
    c1 = cov(x1);
    c2 = cov(x2);
    C = 0.5*c1+0.5*c2;
    Cinv = inv(C);
    
    xt = degreevector(img)';
    
    f1 = u1*Cinv*xt-0.5*u1*Cinv*u1'+log(0.5);
    f2 = u2*Cinv*xt-0.5*u2*Cinv*u2'+log(0.5);
    
    if(f1>f2)
        classe = 'coleoptero';
    else
        classe = 'lagarta';
    end
end