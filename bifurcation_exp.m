%L est la moitié de la longueur du carré, contrairement au L du rapport!
clear all; close all;

paramStep=1E-9;
paramTable=[paramStep];
for i =1:7
   paramStep=2*paramStep;
   paramTable=[paramTable paramStep];
   paramStep=2.5*paramStep;
   paramTable=[paramTable paramStep];
   paramStep=2*paramStep;
   paramTable=[paramTable paramStep];
end
paramTable=paramTable.^(1/2);

global g L l omega C

L=1;
C=1;

%C'est ici que ça se passe
rebondsMax=500;
g=9.81;
l=0.4;
%omega=0;
y0=0.6;
yDot0=0.2;
x0=0.1;
xDot0=20;
%%%%%%%%%%%%%%%%%%%%%%%%%
deltaXInit=0;
deltaYInit=0.0001;
deltaXDotInit=0;
deltaYDotInit=0.0001;
%%%%%%%%%%%%%%%%%%%%%%%%%%
xGlobsList={};
xGlobs2List={};


for j=paramTable
   omega=j;
   yInit=y0;
   yDotInit=yDot0;
   xInit=x0;
   xDotInit=xDot0;
   t0=0;
   xGlob=[];
   firstPick=0;
   periode=getPeriode("x",xInit,yInit,xDotInit,yDotInit);

   for i=1:rebondsMax
      [t y t0 xInit yInit xDotInit yDotInit firstPick]=oneRebound(t0, firstPick, periode, xInit, yInit, xDotInit, yDotInit);
      if length(y)>0
         xGlob=[xGlob;y(1:end,1)];
      end
   end
   xGlobsList{end+1}=xGlob;
end

for j=paramTable
   omega=j;
   yInit=y0+deltaYInit;
   yDotInit=yDot0+deltaYDotInit;
   xInit=x0+deltaXInit;
   xDotInit=xDot0+deltaXDotInit;
   t0=0;
   firstPick=0;
   xGlob=[];
   periode=getPeriode("x",xInit,yInit,xDotInit,yDotInit);

   for i=1:rebondsMax
      [t y t0 xInit yInit xDotInit yDotInit firstPick]=oneRebound(t0, firstPick, periode, xInit, yInit, xDotInit, yDotInit);
      if length(y)>0
         xGlob=[xGlob;y(1:end,1)];
      end
   end
   xGlobs2List{end+1}=xGlob;
end


figure('NumberTitle','on','Name','Diagramme Bifurcation','Renderer','OpenGL','Color','w','Position',[200 200 600 600])
axis([log10(paramTable(1)^2/xDot0)-0.2 log10(paramTable(end)^2/xDot0)+0.2 -L-0.1 L+0.1])
title("Diagramme de bifurcation. Echantillonage=Periode du mouvement en x en l'absence de respiration de la barre centrale")
%text(paramTable(end)^2+2, L+0.2, ["x0= ", num2str(x0),"  y0= ", num2str(y0)]);
%text(paramTable(end)^2+2, L+0.15, ["xDot0= ", num2str(xDot0),"  yDot0= ", num2str(yDot0)]);
%text(paramTable(end)^2+2, L+0.1, ["g= " num2str(g) "  l0/L= " num2str(l)]);
%text(-1,L+0.2,["Nombre de rebonds: " num2str(rebondsMax)]);
set(gca(),"xtick",log10(paramTable(1:3:end).^2 ./xDot0), "ytick", [-1 -0.5 0 0.5 x0 1]);
xlabel('log10(A*omegaCarre/xDot0) (A=1)')
ylabel('Coordonnee en x echantillonnee')
box on; grid on;
for i=1:length(paramTable)
   xGlob=xGlobsList{i};
   xGlob2=xGlobs2List{i};
   for x=xGlob'
      line([log10(paramTable(i)^2/xDot0)],[x],"Marker", "s", "MarkerSize",3, "color", "b")
   end
   for x=xGlob2'
      line([log10(paramTable(i)^2/xDot0)],[x],"Marker", "*", "MarkerSize",2.7, "color", "r")
   end
end
