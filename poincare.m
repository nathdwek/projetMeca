clear all

global g L omega C l
g=9.81;
L=1;
t0=0;
tGlob=[];
yGlob=[];



%C'est ici que ça se passe
l=0.4;
rebondsMax=10000;
omega=0;
y0=0.6;
yDot0=-2;
x0=0;
xDot0=1;
dynamicView=1;
C=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%
periode=4*L/abs(xDot0);
firstPick=0;






options = odeset('Events',@nextRebound,'RelTol',1e-8);
for i=1:rebondsMax
   [t y t0 x0 y0 xDot0 yDot0 firstPick]=oneRebound2(t0, firstPick, periode, x0, y0, xDot0, yDot0);
   tGlob=[tGlob;t];
   yGlob=[yGlob;y];
end

figure('NumberTitle','on','Name','Section Poincare','Renderer','OpenGL','Color','w','Position',[200 200 600 600])
plot(yGlob(1:end,1),yGlob(1:end,3),"linestyle", "none", "Marker", "*", "MarkerSize",3);
axis([-1.2 1.2])
grid on; box on;
hold on;
disp("Taille de léchantillon: ");disp(length(yGlob));
