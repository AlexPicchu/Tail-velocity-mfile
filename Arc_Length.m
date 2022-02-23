function S = Arc_Length(dydx,X,t)
%Arc_Length calculates arc length of curve y(x), in interval x=[X,0]
%   Detailed explanation goes here

integrand = @(x) sqrt(1+(dydx(x,t)).^2);

S     = integral(integrand,X,0);

end