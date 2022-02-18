function X = X_Length(dydx,S,X0)
%X_Length Finds horizontal length of a curve y(x) given known arc length S
%   Detailed explanation goes here

S2      = @(X) Arc_Length(dydx,X);
problem = @(X) S2(X)-S;
X       = fzero(problem,X0);

end