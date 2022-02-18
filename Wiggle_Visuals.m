% Wiggle Visuals

%% Plot

L = 1;
LL = 0.668;
LLL = 0.437;
LLLL = 1.45;
f = 1;
ff = 1;
Tend = 1/f;

T_Series = linspace(0,10*Tend,10*100);

b = @(x) 1;
bb = @(x) 0.67*x;
yc = @(x, t) b(x).*sin((2.*pi./L).*(x+(f.*L.*t)))...
    +bb(x).*sin((2.*pi./LL).*(x+(ff.*LL.*t)))...
    +b(x).*sin((2.*pi./LLL).*(x+(f.*LLL.*t)))...
    +b(x).*sin((2.*pi./LLLL).*(x+(f.*LLLL.*t)));
xc = 0:0.01:5*L;

yt = yc(xc, 0);

figure; axes;
plt = plot(xc,yt);
for j = 1:length(T_Series)
    yt = yc(xc, T_Series(j)); 
    plt.YData = yt;
    drawnow %limitrate % display updates
end