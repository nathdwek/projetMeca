clear all

global g L omega C l
g=0;
L=1;
t0=0;




%C'est ici que ça se passe
l=0.4;
rebondsMax=50;
omega=0;
y0=0.6;
yDot0=0;
x0=0;
xDot0=1;
C=1;
%%%%%%%%%%%%%%%%%%%%%%%%%
periode=0.005;
firstPick=0;
tG=[];
yG=[];



for i=1:rebondsMax
   rebonds=i
   [t y t0 x0 y0 xDot0 yDot0 firstPick]=oneRebound2(t0, firstPick, periode, x0, y0, xDot0, yDot0);
   t=t
   tG=[tG;t];
   yG=[yG;y];
end

figure('NumberTitle','on','Name','Section Poincare','Renderer','OpenGL','Color','w','Position',[200 200 600 600])
plot([yG(1:end,1)],[yG(1:end,2)],"linestyle", "none", "Marker", "*", "MarkerSize",3)
axis("auto")
axis([-1.2 1.2])
grid on; box on;
hold on;
disp("Taille de léchantillon: ");disp(length(yG));

for i=1:length(tGlob)-1
   disp(tGlob(i)-tGlob(i+1)+periode);
end
