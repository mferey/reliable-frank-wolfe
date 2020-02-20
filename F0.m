function output = F0(inp)
    x = inp(1,:);
    y = inp(2,:);
    h = 127.5365 - 0.84629*x - 144.21*y + 0.001703*x.^2 + 0.3656*x.*y;
    output = 22./x./y.*(50+40./h);
end