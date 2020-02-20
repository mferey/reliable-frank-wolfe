function [vt, Vert] = FrankWolfe(At,bt,gt)
    Vert = VertD(At,bt);
    [~,arg] = min(gt'*Vert);  
    vt = Vert(:,arg);
end