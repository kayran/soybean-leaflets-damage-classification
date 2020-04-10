function [matriz centroide] = centroidelocalnew(classe,n,t,set)

%     if(strcmp(classe,'lagarta'))
%         size = 1000;
%     elseif(strcmp(classe,'coleoptero') )
%         size = 700;
%     end    
    size = length(set);
    matriz = zeros([uint32(size*0.9) length(t)*3]);
    aux =1;
    ex = (size/10)*(n-1)+1:(size/10)*(n);
    
    for i =1:size    
        input = [classe '/' classe int2str(set(i)) '.bmp'];
        if(exist(input,'file') && sum(i==ex)==0)
            img = imread(input);            
            vetor = probvector(img,t);
            matriz(aux,:)=vetor;
            aux= aux+1;
        end
     end    
     centroide = mean(matriz);
end