function pq = General_Integrand(dydt,dydx,x,t)

p  = (dydt.*dydx)./((1+(dydt.^2)).^(1./2));
q  = (1+2.*(dydx).^2)./((1+(dydt).^2).^(1./2));
pq = [p,q];

end