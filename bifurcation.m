%L est la moitié de la longueur du carré, contrairement au L du rapport!
clear all; close all;

paramTable=0:0.05:2;

global g L l omega C

L=1;
C=1;

%C'est ici que ça se passe
rebondsMax=400;
g=0;
l=0.4;
%omega=0;
y0=-0.1;
yDot0=0.5;
x0=0.1;
xDot0=0.5;
%%%%%%%%%%%%%%%%%%%%%%%%%
deltaXInit=0;
deltaYInit=0.001;
deltaXDotInit=0;
deltaYDotInit=0.03;
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
axis([paramTable(1)-0.1 paramTable(end)+0.2 -L-0.1 L+0.3])
title("Diagramme de bifurcation. Echantillonage=Periode du mouvement en y en l'absence de barre centrale")
text(paramTable(end)+0.05, L+0.2, ["x0= ", num2str(x0),"  y0= ", num2str(y0)]);
text(paramTable(end)+0.05, L+0.15, ["xDot0= ", num2str(xDot0),"  yDot0= ", num2str(yDot0)]);
text(paramTable(end)+0.05, L+0.1, ["g= " num2str(g) "  omega= " num2str(omega)]);
text(-0.05,L+0.2,["Nombre de rebonds: " num2str(rebondsMax)]);
text(-0.05,L+0.15,"Taille de l echantillon: ");
set(gca(),"xtick",paramTable(1:end), "ytick", [-1 -0.5 0 0.5 y0 1]);
xlabel('Valeur du parametre l/L')
ylabel('Coordonnee en y echantillonnee')
box off;
for i=1:length(paramTable)
   xGlob=xGlobsList{i};
   xGlob2=xGlobs2List{i};
   text(paramTable(i),L+0.1,num2str(length(xGlob)));
   for x=xGlob'
      line([paramTable(i)],[x],"Marker", "s", "MarkerSize",3, "color", "b")
   end
   for x=xGlob2'
      line([paramTable(i)],[x],"Marker", "*", "MarkerSize",3, "color", "r")
   end
end
