% Analytical Velocity Calculations

%% Velocity plots

% all results are relative to mu

f = 1; %frequency (1/s)
L = linspace(0,150,100); %wavelength (mu)
b = [linspace(0,5,20)]';%linspace(0.4,2,20)'; %amplitude (mu)
%n = 1.3; %number of waves 
%a = 0.5; %radius of head (mu)
%d = 0.2; %radius of tail (mu)

%speed = Tail_velocity(f, L, b, n, a, d);
duttyspeed = Tail_velocity_NOHEAD(f,L,b);
plot(L,duttyspeed)
%surf(L,b,duttyspeed)
grid on
title('Plot showing speed varying with wavelength for different amplitudes')
xlabel('speed (mu/s)')
ylabel('wavelength (mu)')
legend('2mu', '4mu', '6mu', ...
    '8mu', '10mu')

%% Amplitude vs Optimum Wavelength
f = 1;
L = linspace(0,150,100000);
b = [linspace(0,5,20)];
h = 1e-8; 
plots = [];
 
for B = b
    F = @(L) Tail_velocity_NOHEAD(f,L,B);
    Fdash = @(L) (F(L+h)-F(L-h))./(2.*h);
    plots = [plots fzero(Fdash,B)]; 
end

plot(plots, b)
title('Plot showing optimum wavelength relative to amplitude')
grid on
xlabel('wavelength (mu)')
ylabel('amplitude (mu)')