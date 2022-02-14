function F = Tail_velocity_NOHEAD(f, L, b)

F = ((2.*f.*(pi.^2).*(b.^2))./L)...
    .*(1./(1+((4.*(pi.^2).*(b.^2))./(L.^2))));