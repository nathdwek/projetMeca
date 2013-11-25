clear all

global g L omega A
g=10;
L=1;
C=1;
omega=1;
A=0.5;






y0=0.8;
yDot0=1;
x0=0.5;
xDot0=1;
t0=0;
tStep=0.0005;
periode=4*L/xDot0;
poincare=round(periode/tStep)-1;
tGlob1=[];
yGlob1=[];
options = odeset('Events',@nextRebound,'RelTol',1e-8);
for i=1:38
   [t,y] = ode45(@movementEq,[t0:tStep:t0+40],[x0 y0 xDot0 yDot0],options);
   vecteur_n=[0 0];
   value=nextRebound(t(end),y(end,:));
   if value(1)<1E-8
      vecteur_n=[1 0];
   end
   if value(2)>-1E-8
      vecteur_n=[0 -1];
   end
   if value(3)>-1E-8
      vecteur_n=[-1 0];
   end
   if value(4)<1E-8
      vecteur_n=[0 1];
   end
   if value(5)<1E-8 && value(5)>-1E-14
      vecteur_n=[0 1];
   end
   if value(5)>-1E-8 && value(5)<1E-14
      vecteur_n=[0 -1];
   end

   tGlob1=[tGlob1;t];
   yGlob1=[yGlob1;y];


   if abs(value(5))<1E-8
      xDot0=C*(y(end,3)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(1))+(1+C)*cos(t(end))*omega;
   else
      xDot0=C*(y(end,3)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(1));
   end
   yDot0=C*(y(end,4)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(2));

   x0=y(end,1)+xDot0*tStep;
   y0=y(end,2)+yDot0*tStep;

   t0=t(end)+tStep;
   yDot0=yDot0-g*tStep;

   tGlob1=[tGlob1;t0];
   yGlob1=[yGlob1; x0 y0 xDot0 yDot0];
   t0=t0+tStep;
end



y0=0.801;
yDot0=1;
x0=0.5;
xDot0=1;
t0=0;
tStep=0.0005;
periode=4*L/xDot0;
poincare=round(periode/tStep)-1;
tGlob2=[];
yGlob2=[];
options = odeset('Events',@nextRebound,'RelTol',1e-8);
for i=1:38
   [t,y] = ode45(@movementEq,[t0:tStep:t0+40],[x0 y0 xDot0 yDot0],options);
   rebonds=i
   vecteur_n=[0 0];
   value=nextRebound(t(end),y(end,:));
   if value(1)<1E-8
      vecteur_n=[1 0];
   end
   if value(2)>-1E-8
      vecteur_n=[0 -1];
   end
   if value(3)>-1E-8
      vecteur_n=[-1 0];
   end
   if value(4)<1E-8
      vecteur_n=[0 1];
   end
   if value(5)<1E-8 && value(5)>-1E-14
      vecteur_n=[0 1];
   end
   if value(5)>-1E-8 && value(5)<1E-14
      vecteur_n=[0 -1];
   end

   tGlob2=[tGlob2;t];
   yGlob2=[yGlob2;y];


   if abs(value(5))<1E-8
      xDot0=C*(y(end,3)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(1))+(1+C)*cos(t(end))*omega;
   else
      xDot0=C*(y(end,3)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(1));
   end
   yDot0=C*(y(end,4)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(2));

   x0=y(end,1)+xDot0*tStep;
   y0=y(end,2)+yDot0*tStep;

   t0=t(end)+tStep;
   yDot0=yDot0-g*tStep;

   tGlob2=[tGlob2;t0];
   yGlob2=[yGlob2; x0 y0 xDot0 yDot0];
   t0=t0+tStep
end




figure('NumberTitle','on','Name','Position en fct du temps','Renderer','OpenGL','Color','w','Position',[50 50 600 600])
plot(tGlob1,yGlob1(:,1), tGlob2, yGlob2(:,1))
grid on;box on;


figure('NumberTitle','on','Name','Trajectoire','Renderer','OpenGL','Color','w','Position',[100 100 600 600])
plot(yGlob1(:,1), yGlob1(:,2),yGlob2(:,1),yGlob2(:,2))
line([-L L L -L -L ],[-L -L +L +L -L],"MarkerSize", 7);
grid on;box on;
axis([-1.2 1.2 -1.2 1.2])

figure('NumberTitle','on','Name','Plan des phases','Renderer','OpenGL','Color','w','Position',[150 150 600 600])
plot(yGlob1(:,2),yGlob1(:,4),yGlob2(:,2),yGlob2(:,4))
xlabel("position");
ylabel("vitesse");
legend("Attention projete sur un axe!!");
axis("auto")
grid on; box on;

