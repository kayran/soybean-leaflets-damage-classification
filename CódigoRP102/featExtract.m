function featExtract(carac,t0, tinc, tq)
    t=t0:tinc:tq;
    total = 1700;
    nc=length(t);
    labels = zeros(1700,1);
    labels(701:1700) =1;
    filename = 	['features/features_' int2str(t0*1000) ':' int2str(tinc*1000) ':' int2str(tq*1000) '_' int2str(carac)];
    
    if(carac==1)
        feat = zeros([1700 length(t)*3]);
        for i=1:1700;
            if(i<=700)
                imname =  i;
                input = ['coleoptero/coleoptero'];
            else
                imname = i-700;
                input = ['lagarta/lagarta'];
            end
            input = [input int2str(imname) '.bmp'];

            img =imread(input);
            vaux = probvector(img,t);
            matrix(i,:) = vaux';
            i
        end
    else
        feat = zeros([1700 length(t)*2]);
        for i=1:1700;
            if(i<=700)
                imname =  i;
                input = ['coleoptero/coleoptero'];
            else
                imname = i-700;
                input = ['lagarta/lagarta'];
            end
            input = [input int2str(imname) '.bmp'];

            img =imread(input);
            vaux = degreevector(img,t);
            matrix(i,:) = vaux;
            i
        end
    end
    save (filename,'matrix');
    save 'labels';
end