clear all; close all;

paramTable=0:0.05:1;

global g L l omega C

L=1;
C=1;

%C'est ici que ça se passe
rebondsMax=400;
g=9.81;
%l=0.4;
omega=0;
y0=0.6;
yDot0=-0.2;
x0=0.3;
xDot0=0.8;
%%%%%%%%%%%%%%%%%%%%%%%%%
periode=4*L/abs(xDotInit);
xGlobsList={};


for j=paramTable
   l=j;
   yInit=y0;
   yDotInit=yDot0;
   xInit=x0;
   xDotInit=xDot0;
   t0=0;
   xGlob=[];
   firstPick=0;

   for i=1:rebondsMax
      [t y t0 xInit yInit xDotInit yDotInit firstPick]=oneRebound(t0, firstPick, periode, xInit, yInit, xDotInit, yDotInit);
      if length(y)>0
         xGlob=[xGlob;y(1:end,1)];
      end
   end
   xGlobsList{end+1}=xGlob;
end


figure('NumberTitle','on','Name','Diagramme Bifurcation','Renderer','OpenGL','Color','w','Position',[200 200 600 600])
axis([paramTable(1)-0.1 paramTable(end)+0.1 -L-0.1 L+0.1])
title("Diagramme de bifurcation. Echantillonage=2L/xDot0")
text(-0.05, -0.7, ["x0: ", num2str(xInit),"  y0: ", num2str(yInit), "  xDot0: ", num2str(xDotInit),"  yDot0: ", num2str(yDotInit)]);
text(-0.05, -0.8, ["g= ", num2str(g)]);
text(-0.05,-0.3,["Nombre de rebonds: " num2str(rebondsMax)]);
text(-0.05,-0.4,"Taille de l echantillon: ");
set(gca(),"xtick",paramTable(1:end), "xaxislocation", "zero", "ytick", [-1 -0.5 0 0.5 xInit 1]);
xlabel('Valeur du parametre l/L')
ylabel('Coordonnee en x echantillonnee')
box off;
for i=1:length(paramTable)
   xGlob=xGlobsList{i};
   text(paramTable(i),-0.5,num2str(length(xGlob)));
   for x=xGlob'
      line([paramTable(i)],[x],"Marker", ".", "MarkerSize",6)
   end
end

print -dpng bifurcation.png
