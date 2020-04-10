function [acertos erros] = crossvalidation3(carac,t0, tinc, tq)
    t=t0:tinc:tq;
    acertos =0;
    erros = 0;
    total = 1700;
    nc=length(t)
    ob=0;
    
    conf = zeros(2,2);
    for p=1:10
        p
        if(carac==1)
            [x1 x2 u1 u2] = normalizanew(p,t,1:1000,1:700);
            nc=nc*3;
        else
            [x1 x2 u1 u2] = normalizaant(p,t,1:1000,1:700);
            nc=nc*2;
        end
        c1 = cov(x1);
        c2 = cov(x2);
        [l1 c] = size(x1);
        [l2 c] = size(x2);
        for i=1:170

            if(i<=70)
                imname = (p-1)*70 + i;
                classe = 'coleoptero';
                input = ['coleoptero/coleoptero'];
            else
                imname = (p-1)*100+(i-70);
                classe = 'lagarta';
                input = ['lagarta/lagarta'];
            end
            input = [input int2str(imname) '.bmp'];

            img =imread(input);
            if(carac==1)
                resposta = discfunctionnew(img, c1, c2, l1, l2, u1, u2, t);
            else
                resposta = discfunctionant(img, c1, c2, l1, l2, u1, u2, t);
            end
            if(strcmp(classe,resposta))
                conf()
                acertos = acertos +1;
            else
                erros = erros +1;
            end
            imname
            acertos
            erros
        end
    end
    arq = fopen('results.csv','a');
    fprintf(arq,'%f;%f;%f;%d;%d;%f',t0,tinc,tq,nc,acertos,(acertos/total));
    fclose(arq);
    
    arq = fopen('confM.csv','a');
end