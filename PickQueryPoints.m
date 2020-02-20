function output = PickQueryPoints(xt,r0,nt)
    d = length(xt);
    X = [];
    r0ej = [r0*eye(d) -r0*eye(d)];
    for j = 1:2*d
        X = [X;repmat((xt+r0ej(:,j))',round(nt/2/d),1)];
    end
    output = X;
end