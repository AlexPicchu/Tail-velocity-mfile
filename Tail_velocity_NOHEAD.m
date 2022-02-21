function F = Tail_velocity_NOHEAD(f, L, b)
% Calculates tail velcotity analytically (excluding the head)

F = ((2.*f.*(pi.^2).*(b.^2))./L)...
    .*(1./(1+((4.*(pi.^2).*(b.^2))./(L.^2))));