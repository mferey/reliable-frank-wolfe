function output = LeastSquares(X,Y)
    [N,~] = size(X);
    Xb = [X,-ones(N,1)];
    output = (Xb'*Xb)\(Xb'*Y);
end