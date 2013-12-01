clear all

paramTable=0:0.1:1;

global g L omega C
g=9.81;
L=1;
omega=0;

%C'est ici que ça se passe
rebondsMax=100;
yInit=0.8;
yDotInit=-1;
xInit=0.5;
xDotInit=1;
C=1;
%%%%%%%%%%%%%%%%%%%%%%%%%

periode=4*L/abs(xDotInit);
precision=500;
tStep=periode/precision;
poincareStep=precision+1;
xList={};


for j=paramTable
   global A
   A=j;
   y0=yInit;
   yDot0=yDotInit;
   x0=xInit;
   xDot0=xDotInit;
   t0=0;
   xGlob=[];
   nextFirstPick=1;

   options = odeset('Events',@nextRebound,'RelTol',1e-8);
   for i=1:rebondsMax
      rebonds=i
      A=A
      [t,y,t0,x0,y0,xDot0,yDot0] = oneRebound(t0,tStep,x0,y0,xDot0,yDot0,options);
      if nextFirstPick>length(y);
         nextFirstPick=nextFirstPick-length(y)+1;
      else
         xGlob=[xGlob;y(nextFirstPick:poincareStep:end,1)];
         reste=rem(length(y)-nextFirstPick,poincareStep);
         nextFirstPick=poincareStep-reste+1;
      end
   end
   list{end+1}=xGlob;
end


figure('NumberTitle','on','Name','Diagramme Bifurcation','Renderer','OpenGL','Color','w','Position',[200 200 600 600])
axis([paramTable(1)-0.2 paramTable(end)+0.2 -L-0.2 L+0.2])
for i=1:length(paramTable)
   for xGlob=list{i}
      disp("Taille de léchantillon: ");disp(length(xGlob));
      for x=xGlob'
         line([paramTable(i)],[x],"Marker", "*", "MarkerSize",3)
      end
   end
end
print -dpng bifurcation.png
