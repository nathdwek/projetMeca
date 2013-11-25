clear all

global g L omega A
g=10;
L=1;
C=1;
omega=3.3;
A=0.5;

y0=0.8;
yDot0=1;
x0=0.5;
xDot0=1;
t0=0;
tStep=0.0005;
periode=2*L/xDot0;
poincare=round(periode/tStep)-1;
tGlob=[];
yGlob=[];
dynamicView=0;






options = odeset('Events',@nextRebound,'RelTol',1e-8);
for i=1:50
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

   tGlob=[tGlob;t];
   yGlob=[yGlob;y];


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

   tGlob=[tGlob;t0];
   yGlob=[yGlob; x0 y0 xDot0 yDot0];
   t0=t0+tStep;
end

if dynamicView
   figure('NumberTitle','on','Name','Mouvement','Renderer','OpenGL','Color','w','Position',[0 0 720 720])
   for i=1:14:max(size(tGlob))
      subplot(1,1,1, 'replace')
      line([yGlob(i,1)],[yGlob(i,2)],'MarkerSize',8,'Marker','.');
      line([-L L L -L -L ],[-L -L +L +L -L]);
      limitLeft=A*(1+sin(omega*tGlob(i))/2);
      limitRight = -1*limitLeft;
      line([limitLeft limitRight],[0 0]);
      grid on;box on;
      axis([-1.5 1.5 -1.5 1.5])
      drawnow;
   end
end

figure('NumberTitle','on','Name','Position en fct du temps','Renderer','OpenGL','Color','w','Position',[50 50 600 600])
plot(tGlob,yGlob(:,2))
grid on;box on;


figure('NumberTitle','on','Name','Trajectoire','Renderer','OpenGL','Color','w','Position',[100 100 600 600])
plot(yGlob(:,1),yGlob(:,2))
line([-L L L -L -L ],[-L -L +L +L -L],"MarkerSize", 7);
grid on;box on;
axis([-1.2 1.2 -1.2 1.2])

figure('NumberTitle','on','Name','Plan des phases','Renderer','OpenGL','Color','w','Position',[150 150 600 600])
plot(yGlob(:,2),yGlob(:,4))
xlabel("position");
ylabel("vitesse");
legend("Attention projete sur un axe!!");
axis("auto")
grid on; box on;

figure('NumberTitle','on','Name','Section Poincare','Renderer','OpenGL','Color','w','Position',[200 200 600 600])
max(size(tGlob))
plot([yGlob(1:poincare:end,1)],[yGlob(1:poincare:end,3)],"linestyle", "none", "Marker", "*", "MarkerSize",3)
axis("auto")
axis([-1.2 1.2])
grid on; box on;
hold on;
