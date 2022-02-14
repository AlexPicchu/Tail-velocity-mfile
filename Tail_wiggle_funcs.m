function STdiff = Tail_wiggle_funcs(L, f, x, t)

%b = 1*x/L;
%bdiff = 1/L;

%b = 1*sqrt(x);
%bdiff = 1*

b = 1;
bdiff = 0;

dydt = (2.*pi.*f.*b).*cos((2.*pi./L).*(x+(f.*L.*t)));

dydx = (2.*pi.*b./L).*cos((2.*pi./L).*(x+(f.*L.*t)))...
    +bdiff.*sin((2.*pi./L).*(x+(f.*L.*t)));

S_diff = (dydt.*dydx)./((1+(dydt.^2)).^(1./2));

T_diff = (1+2.*(dydx).^2)./((1+(dydt).^2).^(1./2));

STdiff = [S_diff, T_diff];

end