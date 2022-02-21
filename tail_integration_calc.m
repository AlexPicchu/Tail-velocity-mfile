% Integration for Sine Wave Tail

% Parameters
t = 0;
L = 1:100; %lambda - wavelength
f = 1; % frequency]

%speeds = zeros(1,length(L));
speeds = [];
for l = L
    ST = integral(@(x) Tail_wiggle_funcs(l, f, x, t), 0, l, 'ArrayValued', true);
    V_x = ST(1)./ST(2);
    %speeds(l) = V_x;
    speeds = [speeds V_x];
end

plot(L,speeds)
