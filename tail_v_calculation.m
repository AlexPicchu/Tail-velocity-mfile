% Velocity plots
clear, clc

% all results are relative to mu

f = 35; %frequency (1/s)
L = [24;48;96;192;500;1000]; %wavelength (mu)
b = 1:1000; %amplitude (mu)
n = 100; %number of waves 
a = 0.5; %radius of head (mu)
d = 0.2; %radius of tail (mu)

speed = Tail_velocity(f, L, b, n, a, d);

plot(b,speed)
grid on