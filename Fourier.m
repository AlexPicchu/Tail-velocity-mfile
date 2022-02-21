function Wiggle_Function = Fourier(BfL)
% bfL - parameter cell matrix (row for nth sinusoid, col for B,f,L respectively)
%       Note: B may be a vector function [b(x),b'(x)], or a scalar b

y     = @(x,t) 0;
dydt  = @(x,t) 0;
dydx  = @(x,t) 0; 

yn    = @(x,t,B,f,L)             B{1}(x).*sin((2.*pi./L).*(x+(f.*L.*t)));
dyndt = @(x,t,B,f,L) (2.*pi.*f.*B{1}(x)).*cos((2.*pi./L).*(x+(f.*L.*t)));
dyndx = @(x,t,B,f,L) (2.*pi.*B{1}(x)./L).*cos((2.*pi./L).*(x+(f.*L.*t)))...
                                +B{2}(x).*sin((2.*pi./L).*(x+(f.*L.*t)));

for row = 1:dot(size(BfL),[1 0])
    
    B = BfL{row,1};
    f = BfL{row,2};
    L = BfL{row,3};
    
    if isequal(class(B),'double')
        B = {@(x)B; @(x)0};
    end
    
    y    = @(x,t) y(x,t)    + yn(x,t,B,f,L);
    dydt = @(x,t) dydt(x,t) + dyndt(x,t,B,f,L);
    dydx = @(x,t) dydx(x,t) + dyndx(x,t,B,f,L);
end

Wiggle_Function = {y;dydt;dydx};

end