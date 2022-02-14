% Velocity plots
clear, clc

% all results are relative to mu

f = 1; %frequency (1/s)
L = linspace(0.00,100,100); %wavelength (mu)
b = 1;%linspace(0.4,2,20)'; %amplitude (mu)
%n = 1.3; %number of waves 
%a = 0.5; %radius of head (mu)
%d = 0.2; %radius of tail (mu)

%speed = Tail_velocity(f, L, b, n, a, d);
duttyspeed = Tail_velocity_NOHEAD(f,L,b);
plot(L,duttyspeed)
%surf(L,b,duttyspeed)
grid off
