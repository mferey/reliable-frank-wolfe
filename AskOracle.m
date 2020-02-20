function output = AskOracle(A,b,sigma,X)
    [n,~] = size(X);
    m = length(b);
    output = X*A' - repmat(b',n,1) + sigma*randn(n,m);
end