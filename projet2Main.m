clear all

global g L omega C l
L=1;
t0=0;
tGlob=[];
yGlob=[];
C=1;



%C'est ici que ça se passe
rebondsMax=160;
g=9.81;
l=0.3;
omega=2;
y0=0.8;
yDot0=-1;
x0=0;
xDot0=1;
dynamicView=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%
tStep=0.001;
firstPick=0;




for i=1:rebondsMax
   [t y t0 x0 y0 xDot0 yDot0 firstPick]=oneRebound(t0, firstPick, tStep, x0, y0, xDot0, yDot0);
   tGlob=[tGlob;t];
   yGlob=[yGlob;y];
end

if dynamicView
   figure('NumberTitle','on','Name','Mouvement','Renderer','OpenGL','Color','w','Position',[0 0 720 720])
   for i=1:7:max(size(tGlob))
      subplot(1,1,1, 'replace')
      line([yGlob(i,1)],[yGlob(i,2)],'MarkerSize',8,'Marker','.');
      line([-L L L -L -L ],[-L -L +L +L -L]);
      limitLeft=l*(1+sin(omega*tGlob(i)));
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
axis([-1.2 1.2])
grid on; box on;
