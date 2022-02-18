function pqVAL = Flapper_Integrand(f, x, t)

phi   = (pi/8).*sin(2*pi.*f.*t);
% y   = -tan(phi).*x;

dydt  = -(sec(phi).^2).*(pi/8).*(2*pi.*f).*cos(2*pi.*f.*t).*x;
dydx  = -tan(phi);

pqVAL = General_Integrand(dydt,dydx,x,t);

end