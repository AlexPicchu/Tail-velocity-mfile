% Wiggle Calculations

%% b, f, L Initial Observation - Sine Wave

% Parameters
b = 0:0.01:1; f = 0:0.01:1; L = 0:0.01:1;
t = 0;

speeds = [];
for i = 1:length(b)
    % Wiggle Function
    W_Fun = Fourier({2*b(i),f(end),L(end)});
    speeds(i) = Velocity_Integral(W_Fun,L(end),t);
end
plot(2*b,speeds,'linewidth',2); 
xlabel('Amplitude (b), \mu'); ylabel('Velocity (V_x), \mu s^{-1}')

speeds = [];
for i = 1:length(f)
    % Wiggle Function
    W_Fun = Fourier({b(end),f(i),L(end)});
    speeds(i) = Velocity_Integral(W_Fun,L(end),t);
end
figure;
plot(f,speeds,'linewidth',2); 
xlabel('Wave Frequency (f), Hz'); ylabel('Velocity (V_x), \mu s^{-1}')

speeds = [];
for i = 1:length(L)
    % Wiggle Function
    W_Fun = Fourier({b(end),f(end),20*L(i)});
    speeds(i) = Velocity_Integral(W_Fun,20*L(i),t);
end
figure;
plot(20*L,speeds,'linewidth',2); 
xlabel('Wavelength (\lambda), \mu'); ylabel('Velocity (V_x), \mu s^{-1}')

%% b and L Relationship - Sine Wave

b = 0:0.1:1; L = 0:0.01:1;
speeds = [];
for i = 1:length(L)
    for j = 1:length(b)
        % Wiggle Function
        W_Fun = Fourier({b(j),f(end),20*L(i)});
        speeds(j,i) = Velocity_Integral(W_Fun,20*L(i),t);
    end
end
figure;
plot(20*L,speeds,'linewidth',2); 
xlabel('Wavelength (\lambda), \mu'); ylabel('Velocity (V_x), \mu s^{-1}')

%% b vs Optimum Wavelength - Sine Wave

f = 1; b = linspace(0,1,100);
h = 1e-8;


plots = [];
for i = 1:length(b)
    W_Fun = @(L) Fourier({b(i) f, L});
%     V = @(L) tail_velocity_NOHEAD(f,L,b(i));
    V = @(L) Velocity_Integral(W_Fun(L),L,t);
    V_Dash = @(L) (V(L+h)-V(L-h))./(2.*h);
    plots(i) = fzero(V_Dash,4*b(i)); 
end

plot(b, plots)
title('Plot showing optimum wavelength relative to amplitude')
grid on
ylabel('wavelength (mu)')
xlabel('amplitude (mu)')

L2b_Ratio = plots(end)/b(end); % b = 0.17, when L = 1 is optimum 

%% f and L Relationship - Sine Wave

f = 0:0.1:1; L = 0:0.01:1;
speeds = [];
for i = 1:length(L)
    for j = 1:length(f)
        % Wiggle Function
        W_Fun = Fourier({b(end),f(j),20*L(i)});
        speeds(j,i) = Velocity_Integral(W_Fun,20*L(i),t);
    end
end
figure;
plot(20*L,speeds,'linewidth',2); 
xlabel('Wavelength (\lambda), \mu'); ylabel('Velocity (V_x), \mu s^{-1}')

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
t = 0; b = 0.17; L = 1; f = 1;
Coeffs0 = {{@(x)b; @(x)0} f L };
b_Range = (-1:0.1:1);

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
    V     = Velocity_Integral(W_Fun1, X1, t);
    speeds1 = [speeds1 V];
end

speedsSq = [];
% b_Range = 0.5:0.1:5;
for b = b_Range
    Coeffs = {};
    for n = 1:10
        Coeffs(n,:) = {4*b./(pi*(2*n-1)) f.*(2*n-1) L./(2*n-1)};
    end
    W_Fun1 = Fourier(Coeffs);
    XSq      = X_Length(W_Fun1{3},S,-L,t);
    V     = Velocity_Integral(W_Fun1, XSq, t);
    speedsSq = [speedsSq V];
end

speedsSw = [];
% b_Range = 0.5:0.1:5;
for b = b_Range
    Coeffs = {};
    for n = 1:10
        Coeffs(n,:) = {4*b./(pi*(2*n)) f*2*n L./(2*n)};
    end
    W_Fun1 = Fourier(Coeffs);
    XSw      = X_Length(W_Fun1{3},S,-L,t);
    V     = Velocity_Integral(W_Fun1, XSw, t);
    speedsSw = [speedsSw V];
end

plot(b_Range,[speeds0(b_Range);speeds1;speedsSq;speedsSw],'linewidth',2);

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

%% Sine vs Sine Wave

% Parameters
t = 0; b = 0.17; L = 1; f = 1;
Coeffs0 = {{@(x)b; @(x)0} f L };
b_Range = (0:0.1:2);

% Wiggle Functions
W_Fun0 = Fourier(Coeffs0);
S      = Arc_Length(W_Fun0{3},-L,t);

% SPEEDS

V0_x = Velocity_Integral(W_Fun0, -L, t);
speeds0 = @(B) V0_x*B.^0;

speedsSin = [];
for b = b_Range
    Coeffs = {b f L };
    W_Fun1 = Fourier(Coeffs);
    X1      = X_Length(W_Fun1{3},S,-L,t);
    V     = Velocity_Integral(W_Fun1, X1, t);
    speedsSin = [speedsSin V];
end

plot(b_Range,[speeds0(b_Range);speedsSin],'linewidth',2);

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



