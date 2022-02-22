% Wiggle Calculations

Titlesize = 16;
Labelsize = 14;
Legsize = 10;

%% b, f, L Initial Observation - Sine Wave

% Parameters
b = 0:0.01:1; f = 0:0.01:1; L = 0:0.01:1;
t = 0;

speeds = zeros(1,length(b));
for i = 1:length(b)
    % Wiggle Function
    W_Fun = Fourier({2*b(i),f(end),L(end)});
    speeds(i) = Velocity_Integral(W_Fun,L(end),t);
end
Vb = figure; plot(2*b,speeds,'linewidth',2); 
title('\textbf{Velocity vs Amplitude} (Sine Wave)','Interpreter','latex','FontSize',Titlesize)
xlabel('Amplitude $(b)$, $\mu$','Interpreter','latex','FontSize',Labelsize)
ylabel('Velocity $(V_x)$, $\mu s^{-1}$','Interpreter','latex','FontSize',Labelsize)
grid on
set(groot,'defaultAxesTickLabelIntepreter','latex')
exportgraphics(Vb,'Plots/Velocity-Amplitude.pdf','ContentType','vector')

speeds = zeros(1,length(f));
for i = 1:length(f)
    % Wiggle Function
    W_Fun = Fourier({b(end),f(i),L(end)});
    speeds(i) = Velocity_Integral(W_Fun,L(end),t);
end
Vf = figure; plot(f,speeds,'linewidth',2);
title('\textbf{Velocity vs Frequency} (Sine Wave)','Interpreter','latex','FontSize',Titlesize)
xlabel('Wave Frequency $(f)$, $Hz$','Interpreter','latex','FontSize',Labelsize)
ylabel('Velocity $(V_x)$, $\mu s^{-1}$','Interpreter','latex','FontSize',Labelsize)
grid on
exportgraphics(Vf,'Plots/Velocity-Frequency.pdf','ContentType','vector')

speeds = zeros(1,length(L));
for i = 1:length(L)
    % Wiggle Function
    W_Fun = Fourier({b(end),f(end),20*L(i)});
    speeds(i) = Velocity_Integral(W_Fun,20*L(i),t);
end
VL = figure; plot(20*L,speeds,'linewidth',2); 
title('\textbf{Velocity vs Wavelength} (Sine Wave)','Interpreter','latex','FontSize',Titlesize)
xlabel('Wavelength $(\lambda)$, $\mu$','Interpreter','latex','FontSize',Labelsize)
ylabel('Velocity $(V_x)$, $\mu s^{-1}$','Interpreter','latex','FontSize',Labelsize)
grid on
exportgraphics(VL,'Plots/Velocity-Wavelength.pdf','ContentType','vector')

%% b and L Relationship - Sine Wave

b = 0:0.1:1; L = 0:0.01:1;

speeds = zeros(length(b),length(L));
for i = 1:length(L)
    for j = 1:length(b)
        % Wiggle Function
        W_Fun = Fourier({b(j),f(end),20*L(i)});
        speeds(j,i) = Velocity_Integral(W_Fun,20*L(i),t);
    end
end

VbL = figure; plot(20*L,speeds,'linewidth',2); 
title('\textbf{Velocity vs Amplitude and Wavelength} (Sine Wave)','Interpreter','latex','FontSize',Titlesize)
xlabel('Wavelength $(\lambda)$, $\mu$','Interpreter','latex','FontSize',Labelsize)
ylabel('Velocity $(V_x)$, $\mu s^{-1}$','Interpreter','latex','FontSize',Labelsize)
grid on
legendCell = strcat('{$b$ = }', string(num2cell(b)), '$\mu$');
legend(legendCell,'Interpreter','latex','FontSize',Legsize)

exportgraphics(VbL,'Plots/Velocity-Amplitude-Wavelength.pdf','ContentType','vector')

%% b vs Optimum Wavelength - Sine Wave

f = 1; b = linspace(0,1,100);
h = 1e-8;

plots = zeros(1,length(b));
for i = 1:length(b)
    W_Fun = @(L) Fourier({b(i) f, L});
    V = @(L) Velocity_Integral(W_Fun(L),L,t);
    V_Dash = @(L) (V(L+h)-V(L-h))./(2.*h);
    plots(i) = fzero(V_Dash,4*b(i)); 
end

bLopt = figure; plot(b, plots, 'linewidth',2)
title('\textbf{Amplitude vs Optimum Wavelength} (Sine Wave)','Interpreter','latex','FontSize',Titlesize)
ylabel('Wavelength $(\lambda)$, $\mu$','Interpreter','latex','FontSize',Labelsize)
xlabel('Amplitude $(b)$, $\mu$','Interpreter','latex','FontSize',Labelsize)
grid on
exportgraphics(bLopt,'Plots/Amplitude-Optimum_Wavelength.pdf','ContentType','vector')

L2b_Ratio = plots(end)/b(end); % b = 0.17, when L = 1 is optimum 

%% f and L Relationship - Sine Wave

f = 0:0.1:1; L = 0:0.01:1;

speeds = zeros(length(f),length(L));
for i = 1:length(L)
    for j = 1:length(f)
        % Wiggle Function
        W_Fun = Fourier({b(end),f(j),20*L(i)});
        speeds(j,i) = Velocity_Integral(W_Fun,20*L(i),t);
    end
end
VfL = figure; plot(20*L,speeds,'linewidth',2); 
title('\textbf{Velocity vs Frequency and Wavelength} (Sine Wave)','Interpreter','latex','FontSize',Titlesize)
xlabel('Wavelength $(\lambda)$, $\mu$','Interpreter','latex','FontSize',Labelsize) 
ylabel('Velocity $(V_x)$, $\mu s^{-1}$','Interpreter','latex','FontSize',Labelsize)
grid on
legendCell = strcat('{$f$ = }', string(num2cell(f)), '$Hz$');
legend(legendCell,'Interpreter','latex','FontSize',Legsize)
exportgraphics(VfL,'Plots/Velocity-Frequency-Wavelength.pdf','ContentType','vector')

%% Sine vs Growing Sine Waves (Varying Amplitude Coefficients)

% Parameters
t = 0; b0 = 0.17; L = 1; f = 1;
Coeffs0 = {{@(x)b0; @(x)0} f L };
b = (-3:0.1:3);

% Wiggle Functions
W_Fun0 = Fourier(Coeffs0);
S      = Arc_Length(W_Fun0{3},-L,t);

% SPEEDS

V0_x = Velocity_Integral(W_Fun0, -L, t);
speeds0 = @(B) V0_x*B.^0;

speeds1 = zeros(1,length(b));
for i = 1:length(b)
    Coeffs = {{@(x)exp(-b(i)*x); @(x)-b(i)*exp(-b(i)*x)} f L };
    W_Fun1 = Fourier(Coeffs);
    X1      = X_Length(W_Fun1{3},S,-L,t);
    V     = Velocity_Integral(W_Fun1, X1, t);
    speeds1(i) = V;
end

speeds2 = zeros(1,length(b));
for i = 1:length(b)
    Coeffs  = {{@(x)b(i)*x; @(x)b(i)} f L };
    W_Fun2  = Fourier(Coeffs);
    X2      = X_Length(W_Fun2{3},S,-L,t);
    V       = Velocity_Integral(W_Fun2, X2, t);
    speeds2(i) = V;
end

speeds3 = zeros(1,length(b));
for i = 1:length(b)
    Coeffs  = {{@(x)b(i)*x.^2; @(x)2*b(i).*x} f L };
    W_Fun3  = Fourier(Coeffs);
    X3      = X_Length(W_Fun3{3},S,-L,t);
    V       = Velocity_Integral(W_Fun3, X3, t);
    speeds3(i) = V;
end

VbGROW = figure;
plot(b,[speeds0(b);speeds1;speeds2;speeds3],'linewidth',2); 
xlabel('Amplitude Coefficient $(b)$','Interpreter','latex','FontSize',Labelsize)
ylabel('Velocity $(V_x)$, $\mu s^{-1}$','Interpreter','latex','FontSize',Labelsize)
title('\textbf{Velocity vs Amplitude Coefficients} (Growing Sine Waves)','Interpreter','latex','FontSize',Titlesize)
grid on
legend('Func 1', 'Func 2', 'Func 3', 'Func 4','Interpreter','latex','FontSize',Legsize)
exportgraphics(VbGROW,'Plots/Velocity-Amplitude(Growing Sines).pdf','ContentType','vector')

%% Sine vs Fourier Waves

% Parameters
t = 0; b0 = 0.17; L = 1; f = 1;
Coeffs0 = {{@(x)b0; @(x)0} f L };
b = (0:0.1:1);

% Wiggle Functions
W_Fun0 = Fourier(Coeffs0);
S      = Arc_Length(W_Fun0{3},-L,t);

% SPEEDS

V0_x = Velocity_Integral(W_Fun0, -L, t);
speeds0 = @(B) V0_x*B.^0;

speedsSq = zeros(1,length(b));
for i = 1:length(b)
    Coeffs = {};
    for n = 1:10
        Coeffs(n,:) = {4*b(i)./(pi*(2*n-1)) f.*(2*n-1) L./(2*n-1)};
    end
    W_Fun1   = Fourier(Coeffs);
    XSq      = X_Length(W_Fun1{3},S,-L,t);
    V        = Velocity_Integral(W_Fun1, XSq, t);
    speedsSq(i) = V;
end

speedsSw = zeros(1,length(b));
for i = 1:length(b)
    Coeffs = {};
    for n = 1:10
        Coeffs(n,:) = {4*b(i)./(pi*(2*n)) f*2*n L./(2*n)};
    end
    W_Fun1   = Fourier(Coeffs);
    XSw      = X_Length(W_Fun1{3},S,-L,t);
    V        = Velocity_Integral(W_Fun1, XSw, t);
    speedsSw(i) = V;
end

VbFOURIER = figure; plot(b,[speeds0(b);speedsSq;speedsSw],'linewidth',2);
xlabel('Amplitude Coefficient $(b)$','Interpreter','latex','FontSize',Labelsize) 
ylabel('Velocity $(V_x)$, $\mu s^{-1}$','Interpreter','latex','FontSize',Labelsize)
title('\textbf{Velocity vs Amplitude Coefficients} (Fourier Waves)','Interpreter','latex','FontSize',Titlesize)
grid on
legend('Func 1', 'Func 2', 'Func 3','Interpreter','latex','FontSize',Legsize)
exportgraphics(VbFOURIER,'Plots/Velocity-Amplitude(Fouriers).pdf','ContentType','vector')

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

VbSine = figure; plot(b_Range,[speeds0(b_Range);speedsSin],'linewidth',2);
xlabel('Amplitude $(b)$ $\mu$','Interpreter','latex','FontSize',Labelsize)
ylabel('Velocity $(V_x)$ $\mu s^{-1}$','Interpreter','latex','FontSize',Labelsize)
title('\textbf{Velocity vs Amplitude Coefficients} (Sine Waves)','Interpreter','latex','FontSize',Titlesize)
grid on
legend('Func 1', 'Func 2','Interpreter','latex','FontSize',Legsize)
exportgraphics(VbSine,'Plots/Velocity-Amplitude(Sines).pdf','ContentType','vector')

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

VtFLAP = figure; plot(T,speeds,'linewidth',2); 
xlabel('Time $(t)$ $s$','Interpreter','latex','FontSize',Labelsize)
ylabel('Velocity $(V_x)$ $\mu s^{-1}$','Interpreter','latex','FontSize',Labelsize); 
title('\textbf{Velocity vs Length and Time} (Flapper)','Interpreter','latex','FontSize',Titlesize)
grid on
legendCell = strcat('{$L$ = }', string(num2cell(X)), '$m$');
legend(legendCell,'Interpreter','latex','FontSize',Legsize)
exportgraphics(VtFLAP,'Plots/Velocity-Time(Flapper).pdf','ContentType','vector')

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

VtFOURIERrand = figure; plot(T,speeds,'linewidth',2);
xlabel('Time $(t)$ $s$','Interpreter','latex','FontSize',Labelsize)
ylabel('Velocity $(V_x)$, $\mu s^{-1}$','Interpreter','latex','FontSize',Labelsize)
title('\textbf{Velocity vs Time} (Random Fourier Wave)','Interpreter','latex','FontSize',Titlesize)
grid on
exportgraphics(VtFOURIERrand,'Plots/Velocity-Time(Random Fourier).pdf','ContentType','vector')

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

VtSq = figure; plot(T,speeds,'linewidth',2);
xlabel('Time $(t)$ $s$','Interpreter','latex','FontSize',Labelsize); 
ylabel('Velocity $(V_x)$ $\mu s^{-1}$','Interpreter','latex','FontSize',Labelsize)
title('\textbf{Velocity vs Time} (Square Waves)','Interpreter','latex','FontSize',Titlesize)
grid on
exportgraphics(VtSq,'Plots/Velocity-Time(Square).pdf','ContentType','vector')

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

VtSw = figure; plot(T,speeds,'linewidth',2);
xlabel('Time $(t)$ $s$','Interpreter','latex','FontSize',Labelsize)
ylabel('Velocity $(V_x)$ $\mu s^{-1}$','Interpreter','latex','FontSize',Labelsize)
title('\textbf{Velocity vs Time} (Saw Waves)','Interpreter','latex','FontSize',Titlesize)
grid on
exportgraphics(VtSw,'Plots/Velocity-Time(Saw).pdf','ContentType','vector')

