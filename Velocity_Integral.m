function V_x = Velocity_Integral(W_Fun, X, t)
%Velocity_Integral Integrates W_Fun wrt x, to find the V_x of W_Fun
%   W_Fun is a Wiggle Function of the form {y,dydt,dydx}

if X==0
    V_x = 0;
else
    dydt = W_Fun{2};
    dydx = W_Fun{3};

    p  = @(x) (dydt(x,t).*dydx(x,t))./((1+(dydx(x,t).^2)).^(1./2));
    q  = @(x)  (1+2.*(dydx(x,t)).^2)./((1+(dydx(x,t)).^2).^(1./2));
    pq = @(x)  [p(x),q(x)];

    PQ  = integral(pq, X, 0, 'ArrayValued', true);
    V_x = PQ(1)./PQ(2);
end
end