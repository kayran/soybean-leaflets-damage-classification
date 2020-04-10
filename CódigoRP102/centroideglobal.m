function centroide = centroideglobal()


matriz = zeros([200 24]);

     for i =1:100     

            input = ['cortes/coleoptero/coleoptero' int2str(i) '.bmp'];

            if(exist(input,'file'))
                img = imread(input);            
                vetor = degreevector(img); 
                matriz(i,:)=vetor;
            end
            
     end    
     
     for i =1:100     

            input = ['cortes/lagarta/lagarta' int2str(i) '.bmp'];

            if(exist(input,'file'))
                img = imread(input);            
                vetor = degreevector(img); 
                matriz(i+100,:)=vetor;
            end
     end
    
     centroide = mean(matriz);
    
end