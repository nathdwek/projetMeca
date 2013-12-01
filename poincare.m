clear all

global g L omega A C
g=0;
L=1;
t0=0;



%C'est ici que ça se passe
rebondsMax=500;
omega=0;
A=0.5;
y0=0.8;
yDot0=1;
x0=0.3;
xDot0=2;
C=1;
%%%%%%%%%%%%%%%%%%%%%%%%%
periode=4*L/abs(xDot0)
precision=500;
tStep=periode/precision;
poincareStep=precision+1;
yGlob=[];
nextFirstPick=1;






options = odeset('Events',@nextRebound,'RelTol',1e-8);
for i=1:rebondsMax
   rebonds=i
   [t,y,t0,x0,y0,xDot0,yDot0] = oneRebound(t0,tStep,x0,y0,xDot0,yDot0,options);
   if nextFirstPick>length(y);
      nextFirstPick=nextFirstPick-length(y)+1;
   else
      yGlob=[yGlob;y(nextFirstPick:poincareStep:end,1:2:3)];
      reste=rem(length(y)-nextFirstPick,poincareStep);
      nextFirstPick=poincareStep-reste+1;
   end
end

figure('NumberTitle','on','Name','Section Poincare','Renderer','OpenGL','Color','w','Position',[200 200 600 600])
plot([yGlob(1:end,1)],[yGlob(1:end,2)],"linestyle", "none", "Marker", "*", "MarkerSize",3)
axis("auto")
axis([-1.2 1.2])
grid on; box on;
hold on;
disp("Taille de léchantillon: ");disp(length(yGlob));
