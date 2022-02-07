% Velocity plots
clear, clc

% all results are relative to mu

f = 35; %frequency (1/s)
L = linspace(0.001,100,100); %wavelength (mu)
b = linspace(0.4,4,10)'; %amplitude (mu)
n = 1.3; %number of waves 
a = 0.5; %radius of head (mu)
d = 0.2; %radius of tail (mu)

speed = Tail_velocity(f, L, b, n, a, d);
%plot(b,speed)
surf(L,b,speed)
grid off