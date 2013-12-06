clear all; close all;

global g L omega C l
g=9.81;
L=1;
t0=0;
tGlob=[];
yGlob=[];



%C'est ici que ça se passe
l=0.1;
rebondsMax=1000;
omega=0;
y0=0.6;
yDot0=-2;
x0=0;
xDot0=1;
C=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%
periode=getPeriode("y",x0,y0,xDot0,yDot0);
firstPick=0;



for i=1:rebondsMax
   [t y t0 x0 y0 xDot0 yDot0 firstPick]=oneRebound2(t0, firstPick, periode, x0, y0, xDot0, yDot0);
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

figure('NumberTitle','on','Name','Section Poincare','Renderer','OpenGL','Color','w','Position',[200 200 600 600])
axis([-1.1 1.1 min(yGlob(:,2))-0.1 max(yGlob(:,2))+0.1])
grid on; box on;
hold on;
for i=1:length(yGlob)
   line([yGlob(i,1)], [yGlob(i,2)], "Marker", ".", "MarkerSize",6);
   %pause(0.1);
end
disp("Taille de léchantillon: ");disp(length(yGlob));

