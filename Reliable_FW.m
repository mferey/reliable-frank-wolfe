% Parameter settings

x0 = [150; 0.09]; T = 26;  sigma = 0.06; sigmaG = 0.1; C = 3e7; r0 = 0.01;
a1 = -0.0844; b1 = -0.010035; c1 = 7.0877; d1 = 200; e1 = -100; h1 = 0.16; g1 = -0.08;
A = [b1 c1;1 0;-1 0;0 1;0 -1];
b = [a1; d1; e1; h1; g1];

% -------------------------------------------------------------------------

% Reliable Frank Wolfe

% figure;
% hold on
xt = x0;
d = length(x0);
fx = [];
Iterates = [];
Xc = [];
Yc = [];
for t = 0:T-1
    Iterates = [Iterates, xt];
    fx = [fx, F0(xt)];
    
    
    % Polytope Estimation
    
    % nt = C;
    nt = C*(t+1)^(1/3);
    X = PickQueryPoints(xt,r0,nt);
    Y = AskOracle(A,b,sigma,X);
    Xc = [Xc; X];
    Yc = [Yc; Y];
    beta = LeastSquares(Xc,Yc);
    At = beta(1:d,:)';
    bt = beta(d+1,:)';
    
    
    % STORM Gradient Estimation
    
    eta = 1/((t+2)^(2/3));
    % eta = 1/((t+2)^(0.5));
    nablaF0t = NoisyGradient(xt,sigmaG);
    if t == 0
        gt = nablaF0t;
    else
        gt = nablaF0t + (1-eta)*(gtprev - nablaF0t);
    end
    gtprev = gt;
    % gt = nablaF0(xt);
    
    
    % Frank-Wolfe 
    
    [vt, V] = FrankWolfe(At,bt,gt);
%     plot([V(1,:),V(1,1)],[V(2,:),V(2,1)],'-.g','LineWidth',1)

    
    
    xt = xt + eta*(vt - xt); 
end

% j = randi(T)-1;
% xt0 = X(:,j);
% f_xt0 = fx(:,j);

% -------------------------------------------------------------------------


% Plotting

% Feasible Set

% V = VertD(A,b);
% plot([V(1,:),V(1,1)],[V(2,:),V(2,1)],'-b','LineWidth',0.5)
% xlim([80,220])
% ylim([0.06,0.18])
% grid on
% ax = gca;
% ax.GridAlpha = 0.7;
% grid minor
% set(gca,'Fontsize',14)
% plot(Iterates(1,:),Iterates(2,:),'mx','MarkerSize',12,'LineWidth',2)
% 
% 
% figure;
% grid on
% ax = gca;
% ax.GridAlpha = 0.7;
% grid minor
% set(gca,'Fontsize',14)
% xlabel('stochastic gradient oracles')
% % xlabel('deterministic gradient oracles')
% ylabel('function value')
% 
% hold on
% plot(1:length(fx),fx, '-.b','LineWidth',2)
% legend('Reliable-FW' ,'Location','best','Fontsize',14)