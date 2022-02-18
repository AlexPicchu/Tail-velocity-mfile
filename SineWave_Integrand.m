function pqVAL = SineWave_Integrand(f, x, t, b, dbdx, L)

% y   = b(x).*sin((2.*pi./L).*(x+(f.*L.*t)));

dydt  = (2.*pi.*f.*b(x)).*cos((2.*pi./L).*(x+(f.*L.*t)));
dydx  = (2.*pi.*b(x)./L).*cos((2.*pi./L).*(x+(f.*L.*t)))...
        +dbdx(x).*sin((2.*pi./L).*(x+(f.*L.*t)));

pqVAL = General_Integrand(dydt,dydx,x,t);

end