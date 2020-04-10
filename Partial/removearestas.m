function a = removearestas(w,t)

    a = ones(size(w));
    
    a(w>=t) = 0;    

end