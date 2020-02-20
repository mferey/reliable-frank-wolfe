function output = VertD(At,bt)
    [m,d] = size(At);
    Vert = [];
    i = 0;
    k = 0;
    flag = 0;
    while 1
        while k ~= d
            i = i+1;
            if i >= 2^m
                flag = 1;
                break
            end
            indv = find(de2bi(i,m));
            k = length(indv);
        end
        if flag == 1
            break
        end
        k = 0;
        %if abs(det(At(indv,:))) > 1e-20
            v = At(indv,:)\bt(indv);
            if all(At*v-bt <= 1e-5)
                Vert = [Vert,v];
            end
        %end
    end
    output = Vert
end