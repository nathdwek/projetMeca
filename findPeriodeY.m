clear all; close all;

global g L omega C l
L=1;
C=1;





%C'est ici que ça se passe
rebondsMax=500
g=9.81;
l=0.2;
omega=0;
y0=0.8;
yDot0=0;
x0=0;
xDot0=0.2;
%%%%%%%%%%%%%%%%%%%%%%%%%%
longuePeriode=getPeriode("y",x0,y0,xDot0,yDot0);
courtePeriode=getCourtePeriode(y0,yDot0);
periodeEnDessous=longuePeriode-courtePeriode;

xDot0=10*L/(7*longuePeriode+3*courtePeriode/2+3*periodeEnDessous/2);

i=-1;
isRegulier=false;
while i<=30 && not(isRegulier)
   i=i+1;
   j=-1;
   while j<=30 && not(isRegulier)
      j=j+1;
      if i==0 && j==0
         u=0;
      else
         u=-1;
      end
      while u<=3 && not(isRegulier)
         u=u+1;
         tGlob=[];
         yGlob=[];
         yInit=y0;
         yDotInit=yDot0;
         xInit=x0;
         xDotInit=xDot0;
         periode=j*longuePeriode+i*courtePeriode+u*periodeEnDessous;
         firstPick=0;
         t0=0;
         for k=1:rebondsMax
            [t y t0 xInit yInit xDotInit yDotInit firstPick]=oneRebound(t0, firstPick, periode, xInit, yInit, xDotInit, yDotInit);
            tGlob=[tGlob;t];
            yGlob=[yGlob;y];
         end
         yGlob=yGlob(:,[2 4]);
         isRegulier=checkRegulier(yGlob);
      endwhile
   endwhile
endwhile

nombreLonguesPeriodes=j
nombreCourtesPeriodes=i
nombrePeriodesEnDessous=u

figure('NumberTitle','on','Name','Section de Poincare','Renderer','OpenGL','Color','w','Position',[200 200 600 600])
title("Section de Poincare. Echantillonnage=Combili entiere des trois periodes-types de base")
text(L+0.05, max([yGlob(:,2)])+0.55, ["x0= ", num2str(x0),"  y0= ", num2str(y0)]);
text(L+0.05, max([yGlob(:,2)])+0.45, ["xDot0= ", num2str(xDot0),"  yDot0= ", num2str(yDot0)]);
text(L+0.05, max([yGlob(:,2)])+0.4, ["g= " num2str(g) "  omega= " num2str(omega) "  l/L= " num2str(l)]);
text(L+0.05, max([yGlob(:,2)])+0.35, ["Taille de l echantillon: " num2str(length(yGlob))]);
text(L+0.05, max([yGlob(:,2)])+0.3,["Nombre de rebonds: " num2str(rebondsMax)]);
text(L+0.05, max([yGlob(:,2)])-0.03, ['Nombre de periodes "completes": ' num2str(j)]);
text(L+0.05, max([yGlob(:,2)])-0.1, ['Nombre de periodes courtes "par au dessus": ' num2str(i)]);
text(L+0.05, max([yGlob(:,2)])-0.17, ['Nombre de periodes courtes "par en dessous": ' num2str(u)]);
axis([-L-.1 L+.5 min([yGlob(:,2);])-1 max([yGlob(:,2)])+1])
line([-L -L],[min([yGlob(:,2)])-1 max([yGlob(:,2)])+1],"linewidth", 1.5);
line([L L],[min([yGlob(:,2)])-1 max([yGlob(:,2)])+1],"linewidth", 1.5);
xlabel('coordonnée y de la balle')
ylabel('Vitesse en y de la balle')
set(gca(), "ytick", [-1 -0.5 0 0.5 y0 1]);
grid on;
hold on;
for i=1:length(yGlob)
   line([yGlob(i,1)], [yGlob(i,2)], "Marker", "s", "MarkerSize",3, "color", "r");
   %pause(0.1);
end
