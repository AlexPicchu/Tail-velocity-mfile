function S = Arc_Length(dydx,X)
%Arc_Length calculates arc length of curve y(x), in interval x=[0,X]
%   Detailed explanation goes here

integrand = @(x) sqrt(1+(dydx(x)).^2);
S         = integral(integrand,0,X);

end