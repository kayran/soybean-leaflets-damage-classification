function [setsc setsl] = generatesets(qcol,qlag,ncol,nlag,niter,qtdset)
    setsc = zeros([niter qtdset uint32(qcol)]);
    setsl = zeros([niter qtdset uint32(qlag)]);
    for i=1:niter
        [lixo,xc] = sort(rand([1 ncol]));
        [lixo,xl] = sort(rand([1 nlag]));
        for j=1:qtdset
            setsc(i,j,:) = xc(1,((j-1)*qcol+1):((j-1)*qcol+qcol));
            setsl(i,j,:) = xl(1,((j-1)*qlag+1):((j-1)*qlag+qlag));
        end
    end
end