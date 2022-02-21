% Wiggle Calculations

%% Flapper

% Parameters
T = 0:0.005:1;
A = @(x) pi/2.1; f = 1; X = 1:0.1:2;

% Wiggle Function
W_Fun = Flapper(A,f);

speeds = zeros(length(X),length(T));
for i = 1:length(T)
    for j = 1:length(X)
        speeds(j,i) = Velocity_Integral(W_Fun, X(j),T(i));
    end
end

plot(T,speeds,'linewidth',2); xlabel('Time'); ylabel('Velocity')

%% Sine vs Growing Sine Waves

% Parameters
t = 0; b = 1; L = 1; f = 1;
Coeffs0 = {{@(x)b; @(x)0} f L };
b_Range = 0:0.01:1;

% Wiggle Functions
W_Fun0 = Fourier(Coeffs0);
S      = Arc_Length(W_Fun0{3},-L,t);

% SPEEDS

V0_x = Velocity_Integral(W_Fun0, -L, t);
speeds0 = @(B) V0_x*B.^0;

speeds1 = [];
for b = b_Range
    Coeffs = {{@(x)exp(-b*x); @(x)-b*exp(-b*x)} f L };
    W_Fun1 = Fourier(Coeffs);
    X1      = X_Length(W_Fun1{3},S,-L,t);
    V_x     = Velocity_Integral(W_Fun1, X1, t);
    speeds1 = [speeds1 V_x];
end

speedsSq = [];
b_Range = 0.5:0.1:5;
for b = b_Range
    Coeffs = {};
    for n = 1:10
        Coeffs(n,:) = {4*b./(pi*(2*n-1)) f.*(2*n-1) L./(2*n-1)};
    end
    W_Fun1 = Fourier(Coeffs);
    XSq      = X_Length(W_Fun1{3},S,-L,t);
    V_x     = Velocity_Integral(W_Fun1, XSq, t);
    speedsSq = [speedsSq V_x];
end

speedsSw = [];
b_Range = 0.5:0.1:5;
for b = b_Range
    Coeffs = {};
    for n = 1:10
        Coeffs(n,:) = {4*b./(pi*(2*n)) f*2*n L./(2*n)};
    end
    W_Fun1 = Fourier(Coeffs);
    XSw      = X_Length(W_Fun1{3},S,-L,t);
    V_x     = Velocity_Integral(W_Fun1, XSw, t);
    speedsSw = [speedsSw V_x];
end

plot(b_Range,[speeds0(b_Range);speedsSq;speedsSw],'linewidth',2);

%% ------------------------------

% speeds2 = [];
% for bc = b_coeff
%     b2      = @(x) bc*x;
%     db2dx   = @(x) bc;
%     X       = X_Length(@(x) dydx(x,t,b2,db2dx,f,L),S,L);
%     V_x     = Velocity_Integral(@(x) SineWave_Integrand(f, x, t, b2, db2dx, L), X);
%     speeds2 = [speeds2 V_x];
% end
% 
% speeds3 = [];
% for bc = b_coeff
%     b3      = @(x) bc*x.^2;
%     db2dx   = @(x) 2*bc*x;
%     X       = X_Length(@(x) dydx(x,t,b3,db2dx,f,L),S,L);
%     V_x     = Velocity_Integral(@(x) SineWave_Integrand(f, x, t, b3, db2dx, L), X);
%     speeds3 = [speeds3 V_x];
% end
%  
% plot(b_coeff,speeds2,speeds3)

%% Fourier

% Parameters
b = 1; f = 1; L = 1;
T = 0:0.005:1;
Coeffs = {{@(x)b;  @(x)0} f L   ;...
          {@(x)b/2;@(x)0} f L/2 ;...
          {@(x)b/4;@(x)0} f L/4};

% Wiggle Function
W_Fun = Fourier(Coeffs);

speeds = zeros(1,length(T));
for i = 1:length(T)
    speeds(i) = Velocity_Integral(W_Fun, -L, T(i));
end

plot(T,speeds,'linewidth',2); xlabel('Time'); ylabel('Velocity')

%% Square

% Parameters
b = 4; f = 1; L = 1;
T = 0:0.005:1;
Coeffs = {};
for n = 1:10
    Coeffs(n,:) = {4*b./(pi*(2*n-1)) f.*(2*n-1) L./(2*n-1)};
end

% Wiggle Function
W_Fun = Fourier(Coeffs);

speeds = zeros(1,length(T));
for i = 1:length(T)
    speeds(i) = Velocity_Integral(W_Fun, XSq, T(i));
end

plot(T,speeds,'linewidth',2); xlabel('Time'); ylabel('Velocity')


%% Saw

% Parameters
b = 10; f = 1; L = 1;
T = 0:0.005:1;
Coeffs = {};
for n = 1:10
    Coeffs(n,:) = {4*b./(pi*(2*n)) f*2*n L./(2*n)};
end

% Wiggle Function
W_Fun = Fourier(Coeffs);

speeds = zeros(1,length(T));
for i = 1:length(T)
    speeds(i) = Velocity_Integral(W_Fun, XSw, T(i));
end

plot(T,speeds,'linewidth',2); xlabel('Time'); ylabel('Velocity')



