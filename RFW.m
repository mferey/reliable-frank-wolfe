x0 = [130 0.09]'; T = 80; eta = 0.1; L = 7; M = 5; delta = 0.01; sigma = 0.01; d = 2; m = 5;
%x0 = [0 0]; T = 10; eta = 0.1; L = 7; M = 5; delta = 0.01; sigma = 0.01; d = 2; m = 5;
xt = x0;
fx = [];
X = [];
A = [100 100 64.914 200 200; 0.08 0.16 0.08 0.12968 0.16];
for t = 1:T
    fx = [fx,f0(xt)];
    vt = min(eta/sqrt(d)/M, min(-f(xt))/max(L,m*sqrt(d)*M));
    gt = g(xt,vt,eta,d,m);
    [~,i] = min(gt'*A);
    xt = xt+1/sqrt(t+2)*(A(:,i)-xt);
    %X = [X xt];
    %j = randi(t)
    %fx = [fx,f0(X(:,j))];
end
figure;
grid on
ax = gca;
ax.GridAlpha = 0.7;
%grid minor

hold on
plot(fxLB, '-gs','LineWidth',2 )
plot(fx, '-.b','LineWidth',2)


set(gca,'Fontsize',14)
xlabel('function oracle calls')
ylabel('function value')


legend({'0-LBM','Reliable-FW' },'Location','best','Fontsize',14);

