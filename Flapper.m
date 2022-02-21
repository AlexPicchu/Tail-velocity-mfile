function Wiggle_Function = Flapper(A,f)

if isequal(class(A),'double')
    A = @(x) A;
end

phi  = @(x,t) (A(x)).*sin(2*pi.*f.*t);

y    = @(x,t) - tan(phi(x,t)).*x;
dydt = @(x,t) -(sec(phi(x,t)).^2).*(A(x)).*(2*pi.*f).*cos(2*pi.*f.*t).*x;
dydx = @(x,t) - tan(phi(x,t));

Wiggle_Function = {y;dydt;dydx};

end