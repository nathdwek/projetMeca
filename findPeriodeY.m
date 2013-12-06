clear all; close all;

global g L omega C l
g=9.81;
L=1;
C=1;





%C'est ici que ça se passe
l=0.3;
rebondsMax=200;
omega=0;
y0Init=0.6;
yDot0Init=-2;
x0Init=0.5;
xDot0Init=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%
longuePeriode=getPeriode("y",x0Init,y0Init,xDot0Init,yDot0Init);
courtePeriode=getCourtePeriode(y0Init,yDot0Init);

i=-1;
isRegulier=false;
while i<=10 && not(isRegulier)
   i=i+1;
   if i==0
      j=0;
   else
      j=-1;
   end
   while j<=10 && not(isRegulier)
      j=j+1;
      tGlob=[];
      yGlob=[];
      y0=y0Init;
      yDot0=yDot0Init;
      x0=x0Init;
      xDot0=xDot0Init;
      periode=i*longuePeriode+j*courtePeriode;
      firstPick=0;
      t0=0;
      for k=1:rebondsMax
         [t y t0 x0 y0 xDot0 yDot0 firstPick]=oneRebound2(t0, firstPick, periode, x0, y0, xDot0, yDot0);
         tGlob=[tGlob;t];
         yGlob=[yGlob;y];
      end
      yGlob=yGlob(:,[2 4]);
      isRegulier=checkRegulier(yGlob);
   endwhile
endwhile

nombreLonguesPeriodes=i
nombreCourtesPeriodes=j

figure('NumberTitle','on','Name','Section Poincare','Renderer','OpenGL','Color','w','Position',[200 200 600 600])
axis([-1.1 1.1 min(yGlob(:,2))-0.1 max(yGlob(:,2))+0.1])
grid on; box on;
hold on;
for i=1:length(yGlob)
   line([yGlob(i,1)], [yGlob(i,2)], "Marker", ".", "MarkerSize",6);
   %pause(0.1);
end
