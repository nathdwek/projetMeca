clear all; close all;

global g L omega C l
L=1;
t0=0;
tGlob=[];
yGlob=[];
C=1;



%C'est ici que ça se passe
rebondsMax=100;
g=0;
l=0.4;
omega=2;
y0=0.2;
yDot0=2;
x0=0.1;
xDot0=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%
dynamicView=0;
tStep=0.001;
firstPick=0;
longuePeriode=getPeriode("y",x0,y0,xDot0,yDot0);
courtePeriode=getCourtePeriode(y0,yDot0);
periodeEnDessous=longuePeriode-courtePeriode;

xInit=x0;
yInit=y0;
xDotInit=xDot0;
yDotInit=yDot0;

for i=1:rebondsMax
   [t y t0 xInit yInit xDotInit yDotInit firstPick]=oneRebound(t0, firstPick, tStep, xInit, yInit, xDotInit, yDotInit);
   tGlob=[tGlob;t];
   yGlob=[yGlob;y];
end

if dynamicView
   figure('NumberTitle','on','Name','Mouvement','Renderer','OpenGL','Color','w','Position',[0 0 720 720])
   for i=1:10:max(size(tGlob))
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
title("Position en y en fonction du temps")
text(0.5, L+0.25, ["x0= ", num2str(x0),"  y0= ", num2str(y0)]);
text(0.5, L+0.19, ["xDot0= ", num2str(xDot0),"  yDot0= ", num2str(yDot0)]);
text(0.5, L+0.13, ["g= " num2str(g) "  omega= " num2str(omega) "  lzero/L= " num2str(l)]);
text(0.5, L+0.07,["Nombre de rebonds: " num2str(rebondsMax)]);
xlabel('T')
ylabel('Y')
axis([-1 tGlob(end)+5 -1.1 1.3])
line([-2 tGlob(end)+10],[-L -L],"linewidth", 3);
line([-2 tGlob(end)+10],[L L],"linewidth", 3);
line([-2 tGlob(end)+10],[0 0],"linewidth", 1);
box on;




%figure('NumberTitle','on','Name','Trajectoire','Renderer','OpenGL','Color','w','Position',[100 100 600 600])
%title("Trajectoire de la balle")
%text(L+0.05, L+0.05, ["x0= ", num2str(x0),"  y0= ", num2str(y0)]);
%text(L+0.05, L-0.05, ["xDot0= ", num2str(xDot0),"  yDot0= ", num2str(yDot0)]);
%text(L+0.05, L-0.15, ["g= " num2str(g) "  omega= " num2str(omega) "  lzero/L= " num2str(l)]);
%text(L+0.05, L-0.25,["Nombre de rebonds: " num2str(rebondsMax)]);
%xlabel('X')
%ylabel('Y')
%hold on;
%line([-L L L -L -L ],[-L -L +L +L -L],"linewidth", 3);
%grid on;box on;
%axis([-1.1 1.3 -1.1 1.1])
%set(gca(),"ytick", [-1 -0.5 0 0.5 y0 1]);
%plot(yGlob(:,1),yGlob(:,2))

%figure('NumberTitle','on','Name','Plan des phases','Renderer','OpenGL','Color','w','Position',[150 150 600 600])
%plot(yGlob(:,2),yGlob(:,4))
%title("Plan des phases projete sur Y")
%line([-L-0.001 -L-0.001],[min(yGlob(:,4))-1 max(yGlob(:,4))+1], "linewidth", 2);
%line([L L],[min(yGlob(:,4))-1 max(yGlob(:,4))+1], "linewidth", 3);
%text(L+0.05, L+0.2, ["x0= ", num2str(x0),"  y0= ", num2str(y0)]);
%text(L+0.05, L-0.2, ["xDot0= ", num2str(xDot0),"  yDot0= ", num2str(yDot0)]);
%text(L+0.05, L-0.6, ["g= " num2str(g) "  omega= " num2str(omega) "  lzero/L= " num2str(l)]);
%xlabel("Y");
%ylabel("vY");
%axis([-1.1 1.4 min(yGlob(:,4))-0.9 max(yGlob(:,4))+0.9])
%set(gca(),"xtick", [-1 -0.5 0 0.5 max(yGlob(:,2)) 1], "xticklabel", {"-1", "-0.5" ,"0", "0.5", ["Ymax=" num2str(max(yGlob(:,2)))] , "1"});


