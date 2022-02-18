function V_x = Velocity_Integral(Integrand, X)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

PQ  = integral(Integrand, 0, X, 'ArrayValued', true);
V_x = PQ(1)./PQ(2);

end