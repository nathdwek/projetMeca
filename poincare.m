clear all

global g L omega C l
g=9.81;
L=1;
t0=0;




%C'est ici que ça se passe
l=0;
rebondsMax=20;
omega=0;
y0=0.6;
yDot0=0;
x0=0;
xDot0=1;
C=1;
%%%%%%%%%%%%%%%%%%%%%%%%%
periode=4*L/xDot0
precision=1000;
tStep=periode/precision;
poincareStep=precision+1;
yGlob=[];
tGlob=[];
nextFirstPick=1;
TG=[];






options = odeset('Events',@nextRebound,'RelTol',1e-8);
for i=1:rebondsMax
   rebonds=i
   [t,y,t0,x0,y0,xDot0,yDot0] = oneRebound(t0,tStep,x0,y0,xDot0,yDot0,options);
   TG=[TG;t];
   if nextFirstPick>length(y);
      nextFirstPick=nextFirstPick-length(y)+1;
   else
      yGlob=[yGlob;y(nextFirstPick:poincareStep:end,1:2:3)];
      tGlob=[tGlob;t(nextFirstPick:poincareStep:end)];
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

for i=1:length(tGlob)-1
   disp(tGlob(i)-tGlob(i+1)+periode);
end
