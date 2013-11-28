clear all

global g L omega A
g=10;
L=1;
C=1;
omega=2;
A=0.5;

y0=0.8;
yDot0=1;
x0=0.5;
xDot0=1;
t0=0;
tStep=0.0005;
periode=2*L/xDot0;
poincareStep=round(periode/tStep)-1
yGlob=[];
nextFirstPick=1;






options = odeset('Events',@nextRebound,'RelTol',1e-8);
for i=1:1500
   [t,y] = ode45(@movementEq,[t0:tStep:t0+40],[x0 y0 xDot0 yDot0],options);
   rebonds=i
   vecteur_n=[0 0];
   value=nextRebound(t(end),y(end,:));
   if value(1)<1E-6
      vecteur_n=[1 0];
   end
   if value(2)>-1E-6
      vecteur_n=[0 -1];
   end
   if value(3)>-1E-6
      vecteur_n=[-1 0];
   end
   if value(4)<1E-6
      vecteur_n=[0 1];
   end
   if value(5)<1E-6 && value(5)>-1E-12
      vecteur_n=[0 1];
   end
   if value(5)>-1E-8 && value(5)<1E-14
      vecteur_n=[0 -1];
   end


   if abs(value(5))<1E-6
      xDot0=C*(y(end,3)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(1))+(1+C)*cos(t(end))*omega;
   else
      xDot0=C*(y(end,3)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(1));
   end
   yDot0=C*(y(end,4)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(2));

   x0=y(end,1)+xDot0*tStep;
   y0=y(end,2)+yDot0*tStep;
   yDot0=yDot0-g*tStep;
   t0=t(end)+tStep;

   y=[y;x0 y0 xDot0 yDot0];
   t0=t0+tStep;
   if nextFirstPick>length(y);
      nextFirstPick=nextFirstPick-length(y);
   else
      yGlob=[yGlob;y(nextFirstPick:poincareStep:end,1:2:3)];
      reste=rem(length(y)-nextFirstPick,poincareStep);
      nextFirstPick=poincareStep-reste;
   end
end

figure('NumberTitle','on','Name','Section Poincare','Renderer','OpenGL','Color','w','Position',[200 200 600 600])
length(yGlob)
plot([yGlob(1:end,1)],[yGlob(1:end,2)],"linestyle", "none", "Marker", "*", "MarkerSize",3)
axis("auto")
axis([-1.2 1.2])
grid on; box on;
hold on;
