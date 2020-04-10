function [acertos erros] = crossvalidation2(carac,t0,tinc,tq)
%     nc=12;
%     if(carac == 1)
%         nc=nc*3;
%     else
%         nc=nc*2;
%     end
    nc=60;
    arq = fopen('results_nl.csv','w');
    fprintf(arq,'%f;%f;%f;%d;',t0,tinc,tq,nc);
    fprintf('%f;%f;%f;%d;',t0,tinc,tq,nc);
    acertoste = 0;
    acertostr = 0;
    erroste = 0;
    errostr = 0;

    matriz = zeros(1700,nc);
    totalte=1700;
    totaltr=15300;
    filename = ['features/features_' int2str(t0*1000) ':' int2str(tinc*1000) ':' int2str(tq*1000) '_' int2str(1)];
    load(filename);
    matriz(:,1:36) = matrix(:,:);
%    load('areas');

    load labels;
    filename = ['features/features_' int2str(t0*1000) ':' int2str(tinc*1000) ':' int2str(tq*1000) '_' int2str(2)];
    load(filename);
    matriz(:,37:60) =  matrix(:,:);
%    matriz(:,nc+1) = areas(:);
    matrix = matriz;
     i = crossvalind('kfold',1700,10);

    conf=zeros(2,2);
    conftr=zeros(2,2);
    

    for p=1:10
        train = i~=p;
        test = i ==p;
        
        [x1 x2 u1 u2] = normaliza2(matrix,labels,train);
        
        c1 = cov(x1);
        c2 = cov(x2);
        [l1 c] = size(x1);
        [l2 c] = size(x2);
        
        laval = labels(test);
        aval = matrix(test,:);
        

        
        for j=1:170

            vaux = aval(j,:);
            
            resposta = discfunction2(vaux, c1, c2, l1, l2, u1, u2);

            if(resposta == laval(j))
                acertoste = acertoste +1;
            else
                erroste = erroste +1;
            end
            
            conf(resposta+1,laval(j)+1) = conf(resposta+1,laval(j)+1)+1;
        end

        laval = labels(train);
        aval = matrix(train,:);
        
        for j=1:1530

            vaux = aval(j,:);

            resposta = discfunction2(vaux, c1, c2, l1, l2, u1, u2);

            if(resposta == laval(j))
                acertostr = acertostr +1;
            else
                errostr = errostr +1;
            end
            
            conftr(resposta+1,laval(j)+1) = conftr(resposta+1,laval(j)+1)+1;
        end
    end
    fprintf(arq,'%d;%f;%d;%f\n',acertoste,(acertoste/totalte),acertostr,(acertostr/totaltr));
    fprintf('%d;%f;%d;%f\n',acertoste,(acertoste/totalte),acertostr,(acertostr/totaltr));
    fclose(arq);
    
    arq = fopen('conf_nl.csv','w');
    fprintf(arq,'Teste:\n');
    fprintf(arq,';Col;Lag\nCol;%d;%d\nLag;%d;%d\n\n',conf(1,1),conf(1,2),conf(2,1),conf(2,2));
    conf(:,1) = conf(:,1)/(conf(1,1)+conf(2,1));
    conf(:,2) = conf(:,2)/(conf(1,2)+conf(2,2));
    fprintf(arq,'%f;%f\n%f;%f\n\n',conf(1,1),conf(1,2),conf(2,1),conf(2,2));
    fprintf(arq,'Treino:\n');
    fprintf(arq,';Col;Lag\nCol;%d;%d\nLag;%d;%d\n\n',conftr(1,1),conftr(1,2),conftr(2,1),conftr(2,2));
    conftr(:,1) = conftr(:,1)/(conftr(1,1)+conftr(2,1));
    conftr(:,2) = conftr(:,2)/(conftr(1,2)+conftr(2,2));
    fprintf(arq,'%f;%f\n%f;%f\n\n',conftr(1,1),conftr(1,2),conftr(2,1),conftr(2,2));
    fclose(arq);
end
   