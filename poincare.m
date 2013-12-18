clear all; close all;

global g L omega C l
L=1;
C=1;
tGlob=[];
yGlob=[];
tGlob2=[];
yGlob2=[];
tGlob3=[];
yGlob3=[];



%C'est ici que ça se passe
rebondsMax=2000;
g=9.81;
l=0.2;
omega=0;
y0=0.8;
yDot0=0;
x0=0;
xDot0=0.97103;
%%%%%%%%%%%%%%%%%%%%%%%%%%
deltaXInit=0.0001;
deltaYInit=0;
deltaXDotInit=0.0002;
deltaYDotInit=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%



yInit=y0;
yDotInit=yDot0;
xInit=x0;
xDotInit=xDot0;
t0=0;
periode=getPeriode("y",xInit,yInit,xDotInit,yDotInit);
firstPick=0;
for i=1:rebondsMax
   [t y t0 xInit yInit xDotInit yDotInit firstPick]=oneRebound(t0, firstPick, periode, xInit, yInit, xDotInit, yDotInit);
   tGlob=[tGlob;t];
   yGlob=[yGlob;y];
end

yGlob=yGlob(:,[2 4]);

for i=1:length(tGlob)-1
   if abs(tGlob(i+1)-tGlob(i)-periode)>1E-12
      i=i
      diff=tGlob(i+1)-tGlob(i)-periode
   end
end

yInit=y0+deltaYInit;
yDotInit=yDot0+deltaYDotInit;
xInit=x0+deltaXInit;
xDotInit=xDot0+deltaXDotInit;
t0=0;
periode=getPeriode("y",xInit,yInit,xDotInit,yDotInit);
firstPick=0;
for i=1:rebondsMax
   [t y t0 xInit yInit xDotInit yDotInit firstPick]=oneRebound(t0, firstPick, periode, xInit, yInit, xDotInit, yDotInit);
   tGlob2=[tGlob2;t];
   yGlob2=[yGlob2;y];
end

yGlob2=yGlob2(:,[2 4]);

yInit=y0-deltaYInit;
yDotInit=yDot0-deltaYDotInit;
xInit=x0-deltaXInit;
xDotInit=xDot0-deltaXDotInit;
t0=0;
periode=getPeriode("y",xInit,yInit,xDotInit,yDotInit);
firstPick=0;
for i=1:rebondsMax
   [t y t0 xInit yInit xDotInit yDotInit firstPick]=oneRebound(t0, firstPick, periode, xInit, yInit, xDotInit, yDotInit);
   tGlob3=[tGlob3;t];
   yGlob3=[yGlob3;y];
end

yGlob3=yGlob3(:,[2 4]);


figure('NumberTitle','on','Name','Section de Poincare','Renderer','OpenGL','Color','w','Position',[200 200 600 600])
title("Section de Poincare. Echantillonage=Periode de base du systeme sans barre centrale")
text(L+0.05, max([yGlob(:,2);yGlob2(:,2)])+0.6, ["x0= ", num2str(x0),"  y0= ", num2str(y0)]);
text(L+0.05, max([yGlob(:,2);yGlob2(:,2)])+0.4, ["xDot0= ", num2str(xDot0),"  yDot0= ", num2str(yDot0)]);
text(L+0.05, max([yGlob(:,2);yGlob2(:,2)])+0.2, ["g= " num2str(g) "  omega= " num2str(omega) "  l/L= " num2str(l)]);
text(L+0.05, max([yGlob(:,2);yGlob2(:,2)]-0.2), ["Taille de l echantillon: " num2str(length(yGlob))]);
text(L+0.05, max([yGlob(:,2);yGlob2(:,2)]-0.4),["Nombre de rebonds: " num2str(rebondsMax)]);
axis([-L-.1 L+.4 min([yGlob(:,2);yGlob2(:,2)])-0.1 max([yGlob(:,2);yGlob2(:,2)])+.8])
line([-L -L],[min([yGlob(:,2);yGlob2(:,2)])-1 max([yGlob(:,2);yGlob2(:,2)])+1],"MarkerSize", 7);
line([L L],[min([yGlob(:,2);yGlob2(:,2)])-1 max([yGlob(:,2);yGlob2(:,2)])+1],"MarkerSize", 7);
xlabel('Coordonnee y de la balle')
ylabel('Vitesse en y de la balle')
grid on;
hold on;
for i=1:length(yGlob)
   line([yGlob(i,1)], [yGlob(i,2)], "Marker", "s", "MarkerSize",1.5,"color", "b");
end
for i=1:length(yGlob2)
   line([yGlob2(i,1)], [yGlob2(i,2)], "Marker", "*", "MarkerSize",3, "color", "r");
end
for i=1:length(yGlob3)
   line([yGlob3(i,1)], [yGlob3(i,2)], "Marker", ".", "MarkerSize",5, "color", "g");
end


