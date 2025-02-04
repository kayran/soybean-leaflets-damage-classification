function [acertos erros] = crossvalidationant(t0,tinc,tq,nf)
    nimgs = 1700; %Total de imagens
    ncol = 700;
    nlag=1000;
    t = t0:tinc:tq;
    ncar = length(t)*2; %qtd caracteristicas = tam conj teste
    tamset = 10*ncar; %Tamanho do conjunto de validação
    qtdset = nimgs/tamset; %numero de conjuntos por iter
    niter = ceil(30/qtdset); %qtd de iterações
    qcol = ceil((ncol/nimgs)*tamset); %coleopteros por conjunto
    qlag = tamset - qcol; %lagartas por conjunto
    modc = mod(qcol,10);
    modl = mod(qlag,10);
    if(modc>=modl)
        qcol = qcol+modl;
        qlag = qlag-modl;
    end
    [setsc setsl] = generatesets(qcol,qlag,ncol,nlag,niter,qtdset);
    acertos = zeros(niter,qtdset);
    erros = zeros(niter,qtdset);
    tcol = floor(qcol/10);
    tlag = uint32(tamset/10) - tcol;
    
    max = 0;
    arq = fopen(['results' int2str(nf) '.txt'],'w');
    for i=1:niter
        for j=1:qtdset
            acertos(i,j) = 0;
            erros(i,j) = 0;
            conf = zeros(2,2);
            for p=1:10
                p
                [x1 x2 u1 u2] = normalizaant(p,t,setsc(i,j,:),setsl(i,j,:));
                c1 = cov(x1);
                c2 = cov(x2);
                [l1 c] = size(x1);
                [l2 c] = size(x2);
                for k=1:ncar

                    if(k<=tcol)
                        imname = (p-1)*tcol + k;
                        classe = 'coleoptero';
                        input = ['coleoptero/coleoptero'];
                        csup = 1;
                        cerr = 2;
                        input = [input int2str(setsc(i,j,imname)) '.bmp'];
                    else
                        imname = (p-1)*tlag + (k-tcol);
                        classe = 'lagarta';
                        input = ['lagarta/lagarta'];
                        csup = 2;
                        cerr = 1;
                        input = [input int2str(setsl(i,j,imname)) '.bmp'];
                    end
                    %fprintf('i=%d j=%d im=%d\n',i,j,imname);
                    img =imread(input);
                    resposta = discfunctionant(img, c1, c2, l1, l2, u1, u2,t);

                    if(strcmp(classe,resposta))
                        acertos(i,j) = acertos(i,j) +1;
                        conf(csup,csup) = conf(csup,csup)+1;
                        max = max+1;
                    else
                        erros(i,j) = erros(i,j) +1;
                        conf(csup,cerr) = conf(csup,cerr)+1;
                        max=max+1;
                    end
                    
                end
                ac=acertos(i,j);
                er=erros(i,j);
                fprintf('ac=%d er=%d\n',ac,er);
            end
            fprintf(arq,'\nMatriz de Confusão: \n');
            fprintf(arq,'|     ||  1  ||  2  |\n');
            fprintf(arq,'|%d|',conf(1,:));
            fprintf(arq,'\n');
            fprintf(arq,'|%d|',conf(2,:));
            fprintf(arq,'\n');
            conf = conf/max;
            fprintf(arq,'\nMatriz de Confusão: \n');
            fprintf(arq,'|     ||  1  ||  2  |\n');
            fprintf(arq,'|%.2f|',conf(1,:));
            fprintf(arq,'\n');
            fprintf(arq,'|%.2f|',conf(2,:));
            fprintf(arq,'\n');
            
        end
    end
    fprintf(arq,'erro: %d acerto: %d\n',erros,acertos);
    fprintf(arq,'\n');
    acertos = (acertos/tamset)*100;
    erros = (erros/tamset)*100;    
    fprintf(arq,'erro: %.2f acerto: %.2f\n',erros,acertos);
    fprintf(arq,'\n');
    fprintf(arq,'\nmedia erros: %.2f\n',mean2(erros));
    fprintf(arq,'media acertos: %.2f\n\n',mean2(acertos));
    fprintf(arq,'\nstd erros: %.2f\n',std(erros(:)));
    fprintf(arq,'std acertos: %.2f\n\n',std(acertos(:)));
    fclose(arq);
end