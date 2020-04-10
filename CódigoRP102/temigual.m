for i=1:n(1)
    for j=1:n(1)
        [t q] = size(find(C(i,:)==C(j,:)));
        if(q>26)
            i
            j
            q
        end
        [t q] = size(find(C(:,i)==C(:,j)));
        if(q>26)
            i
            j
            q
        end
    end
end