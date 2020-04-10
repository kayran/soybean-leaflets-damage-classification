function imout = constroigrafo(img)

    w = geragrafo(img);
    a = removearestas(w,0.3);    
    imout = desenhagrafo(img,a);    

end