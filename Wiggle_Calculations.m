% Wiggle Calculations

% Parameters
T = 1:0.01:2;
L = 1:10; % lambda - wavelength
f = 1; % frequency]

%% Flapper
speeds = zeros(length(L),length(T));
for i = 1:length(T)
    for j = 1:length(L)
        speeds(j,i) = Velocity_Integral(@(x) Flapper_Integrand(f, x, T(i)), L(j));
    end
end

plot(T,speeds)


%% Sine Waves

dydx = @(x,t,b,dbdx,f,L) (2.*pi.*b(x)./L).*cos((2.*pi./L).*(x+(f.*L.*t)))...
    +dbdx(x).*sin((2.*pi./L).*(x+(f.*L.*t)));
b0 = @(x) 1;
db1dx = @(x) 0;
L = 1;
f = 1;
t = 0;
S = Arc_Length(@(x) dydx(x,t,b0,db1dx,f,L),L);

b_coeff = -2:0.01:2;

V0_x = Velocity_Integral(@(x) SineWave_Integrand(f, x, t, b0, db1dx, L), L);
speeds0 = @(B) V0_x*B.^0;

speeds1 = [];
for bc = b_coeff
    b1      = @(x) exp(bc*(x+10));
    db2dx   = @(x) bc*b1(x);
    X       = X_Length(@(x) dydx(x,t,b1,db2dx,f,L),S,L);
    V_x     = Velocity_Integral(@(x) SineWave_Integrand(f, x, t, b1, db2dx, L), X);
    speeds1 = [speeds1 V_x];
end

speeds2 = [];
for bc = b_coeff
    b2      = @(x) bc*x;
    db2dx   = @(x) bc;
    X       = X_Length(@(x) dydx(x,t,b2,db2dx,f,L),S,L);
    V_x     = Velocity_Integral(@(x) SineWave_Integrand(f, x, t, b2, db2dx, L), X);
    speeds2 = [speeds2 V_x];
end

speeds3 = [];
for bc = b_coeff
    b3      = @(x) bc*x.^2;
    db2dx   = @(x) 2*bc*x;
    X       = X_Length(@(x) dydx(x,t,b3,db2dx,f,L),S,L);
    V_x     = Velocity_Integral(@(x) SineWave_Integrand(f, x, t, b3, db2dx, L), X);
    speeds3 = [speeds3 V_x];
end

plot(b_coeff,speeds0(b_coeff)); hold on
plot(b_coeff,speeds1); 
% plot(b_coeff,speeds2)
% plot(b_coeff,speeds3)

% TAIL PLOT

b1      = @(x) exp(2*(x+2));
db1dx   = @(x) 2*exp(2*(x+2));
X       = X_Length(@(x) dydx(x,t,b1,db1dx,f,L),S,L);
X_Range = 0:0.01:X;
L_Range = 0:0.01:L;

y1 = @(x) b0(x).*sin((2.*pi./L).*(x+(f.*L.*t)));
y2 = @(x) b1(x).*sin((2.*pi./L).*(x+(f.*L.*t)));

figure; grid on; hold on
plot(L_Range,y1(L_Range))
plot(X_Range,y2(X_Range))




