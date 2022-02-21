% Wiggle Visuals

%% Sine vs Growing Sine Plot

% Parameters
t = 0; b = 0.17; L = 1; f = 1;
b2 = -0.2;
Coeffs1 = {{@(x)b; @(x)0} f L };
Coeffs2 = {{@(x)exp(-b2*x); @(x)-b2*exp(-b2*x)} f L };

% Wiggle Functions
W_Fun1 = Fourier(Coeffs1);
W_Fun2 = Fourier(Coeffs2);

S       = Arc_Length(W_Fun1{3},-L,t);
X       = X_Length(W_Fun2{3},S,-L,t);

X_Range = 0:-0.01:X;
L_Range = 0:-0.01:-L;

y1 = W_Fun1{1};
y2 = W_Fun2{1};

figure; grid on; hold on
plot(L_Range,y1(L_Range,t),'linewidth',2)
plot(X_Range,y2(X_Range,t),'linewidth',2)
xlabel('X')
ylabel('Y')

%% Sine vs Sine Plot

% Parameters
t = 0; b = 0.17; L = 1; f = 1;
b2 = 2;
Coeffs1 = {{@(x)b; @(x)0} f L };
Coeffs2 = {b2 f L };

% Wiggle Functions
W_Fun1 = Fourier(Coeffs1);
W_Fun2 = Fourier(Coeffs2);

S       = Arc_Length(W_Fun1{3},-L,t);
X       = X_Length(W_Fun2{3},S,-L,t);

X_Range = 0:-0.01:X;
L_Range = 0:-0.01:-L;

y1 = W_Fun1{1};
y2 = W_Fun2{1};

figure; grid on; hold on
plot(L_Range,y1(L_Range,t),'linewidth',2)
plot(X_Range,y2(X_Range,t),'linewidth',2)
xlabel('X')
ylabel('Y')

%% Sine vs Square Plot

% Parameters
t = 0; b = 1; L = 1; f = 1;
b2 = 4;
Coeffs1 = {{@(x)b; @(x)0} f L };
Coeffs2 = {};
for n = 1:10
    Coeffs2(n,:) = {4*b2./(pi*(2*n-1)) f.*(2*n-1) L./(2*n-1)};
end

% Wiggle Functions
W_Fun1 = Fourier(Coeffs1);
W_Fun2 = Fourier(Coeffs2);

S       = Arc_Length(W_Fun1{3},-L,t);
XSq       = X_Length(W_Fun2{3},S,-L,t);

X_Range = 0:-0.01:XSq;
L_Range = 0:-0.01:-L;

y1 = W_Fun1{1};
y2 = W_Fun2{1};

figure; grid on; hold on
plot(L_Range,y1(L_Range,t),'linewidth',2)
plot(X_Range,y2(X_Range,t),'linewidth',2)
xlabel('X')
ylabel('Y')

%% Sine vs Saw Plot

% Parameters
t = 0; b = 1; L = 1; f = 1;
b2 = 4;
Coeffs1 = {{@(x)b; @(x)0} f L };
Coeffs2 = {};
for n = 1:10
    Coeffs2(n,:) = {4*b2./(pi*(2*n)) f.*(2*n) L./(2*n)};
end

% Wiggle Functions
W_Fun1 = Fourier(Coeffs1);
W_Fun2 = Fourier(Coeffs2);

S       = Arc_Length(W_Fun1{3},-L,t);
XSw       = X_Length(W_Fun2{3},S,-L,t);

X_Range = 0:-0.01:XSw;
L_Range = 0:-0.01:-L;

y1 = W_Fun1{1};
y2 = W_Fun2{1};

figure; grid on; hold on
plot(L_Range,y1(L_Range,t),'linewidth',2)
plot(X_Range,y2(X_Range,t),'linewidth',2)
xlabel('X')
ylabel('Y')

%% Fourier Animation

% Parameters
b = 1; L = 1; f = 1;
Xend = 2*L;
Tend = 1/f;
T_Series = linspace(0,10*Tend,10*100);
Coeffs = {{@(x)b;@(x)0}   f L   ;...
          {@(x)b/2;@(x)0} f L/2 ;...
          {@(x)b/4;@(x)0} f L/4 ;...
          {@(x)b/8;@(x)0} f L/8};
% Coeffs = {b2 f L }; Xend=-X; 
% X2end=L; b = 1;


% Wiggle Function
W_Fun = Fourier(Coeffs);

y = W_Fun{1};
% y2 = W_Fun1{1};
x = -(0:0.01:Xend);
% x2 = -(0:0.01:X2end);

yt = y(x, 0);
% y2t = y2(x2, 0);

figure; ax = axes;
plt = plot(x,yt,'linewidth',4); hold on;
% plt2 = plot(x2,y2t,'linewidth',4);
pltH = plot(x(1:4),yt(1:4),'-o','MarkerSize',15,...
                                'MarkerEdgeColor',[0,0.45,0.74],...
                                'MarkerFaceColor',[0,0.45,0.74]);
% plt2H = plot(x2(1:4),y2t(1:4),'-o','MarkerSize',15,...
%                                 'MarkerEdgeColor',[0.85,0.45,0],...
%                                 'MarkerFaceColor',[0.85,0.45,0]);
xlabel('X')
ylabel('Y')
axis(ax,[-(X2end+0.1) 0.1 -2*b 2*b])
for j = 1:length(T_Series)
    yt = y(x, T_Series(j)); 
%     y2t = y2(x2, T_Series(j));
    plt.YData = yt;
%     plt2.YData = y2t;
    pltH.YData = yt(1:4);
%     plt2H.YData = y2t(1:4);
    drawnow % limitrate % display updates
end

%% Flapper Animation

% Parameters
A = @(x) x*pi/2.1; f = 1; 
Xend = 1;
Tend = 1/f;
T_Series = linspace(0,10*Tend,10*200);

% Wiggle Function
W_Fun = Flapper(A,f);

y = W_Fun{1};
x = -(0:0.01:Xend);

yt = y(x, 0);

figure; ax = axes;
plt = plot(x,yt,'linewidth',4); hold on;
pltH = plot(x(1:4),yt(1:4),'-o','MarkerSize',15,'MarkerEdgeColor',[0,0.45,0.74],'MarkerFaceColor',[0,0.45,0.74]);
xlabel('X')
ylabel('Y')
axis(ax,[-(Xend+0.1) 0.1 -tan(A(Xend))*Xend tan(A(Xend))*Xend])
for j = 1:length(T_Series)
    yt = y(x, T_Series(j)); 
    plt.YData = yt;
    pltH.YData = yt(1:4);
    drawnow % limitrate % display updates
end


%% Square Animation

% Parameters
b = 1; L = 1; f = 1;
Xend = L;
% Xend = -XSq;
Tend = 10*1/f;
T_Series = linspace(0,1*Tend,1*200);
      
Coeffs = {};
for n = 1:100
    Coeffs(n,:) = {4*b./(pi*(2*n-1)) f L./(2*n-1)};
end
% .*(2*n-1)
% Wiggle Function
W_Fun = Fourier(Coeffs);

y = W_Fun{1};
x = -(0:0.001:Xend);

yt = y(x, 0);

figure; ax = axes;
plt = plot(x,yt,'linewidth',4); hold on;
pltH = plot(x(1:4),yt(1:4),'-o','MarkerSize',15,...
                                'MarkerEdgeColor',[0,0.45,0.74],...
                                'MarkerFaceColor',[0,0.45,0.74]);
xlabel('X')
ylabel('Y')
axis(ax,[-(Xend+0.1) 0.1 -5*b 5*b])
for j = 1:length(T_Series)
    yt = y(x, T_Series(j)); 
    plt.YData = yt;
    pltH.YData = yt(1:4);
    drawnow % limitrate % display updates
end

%% Saw Animation

% Parameters
b = 1; L = 1; f = 1;
Xend = L;
% Xend = -XSw;
Tend = 10*1/f;
T_Series = linspace(0,1*Tend,1*200);
      
Coeffs = {};
for n = 1:10
    Coeffs(n,:) = {4*b./(pi*(2*n)) f L./(2*n)};
end
% *2*n
% Wiggle Function
W_Fun = Fourier(Coeffs);

y = W_Fun{1};
x = -(0:0.001:Xend);

yt = y(x, 0);

figure; ax = axes;
plt = plot(x,yt,'linewidth',4); hold on;
pltH = plot(x(1:4),yt(1:4),'-o','MarkerSize',15,...
                                'MarkerEdgeColor',[0,0.45,0.74],...
                                'MarkerFaceColor',[0,0.45,0.74]);
xlabel('X')
ylabel('Y')
axis(ax,[-(Xend+0.1) 0.1 -5*b 5*b])
for j = 1:length(T_Series)
    yt = y(x, T_Series(j)); 
    plt.YData = yt;
    pltH.YData = yt(1:4);
    drawnow % limitrate % display updates
end