function  preprocess()
    areas = zeros(1700,1);
    for i =1:700
        input = ['coleoptero/coleoptero' int2str(i) '.bmp'];
        area=0;
        if(exist(input,'file'))
            img = imread(input);
            bw = im2bw(img);
            [obj,num] = bwlabel(bw,4);
            for j=1:num
                tmp = obj==j;
                tmp = sum(sum(tmp));
                area = max(area,tmp);
            end
            areas(i)=area;
        end
    end    
    for i =1:1000
        input = ['lagarta/lagarta' int2str(i) '.bmp'];
        area=0;
        if(exist(input,'file'))
            img = imread(input);
            bw = im2bw(img);
            [obj,num] = bwlabel(bw,4);
            for j=1:num
                tmp = obj==j;
                tmp = sum(sum(tmp));
                area = max(area,tmp);
            end
            areas(700+i)=area;
        end
    end    
    
    save 'areas';
end