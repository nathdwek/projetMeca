clear all

global g L omega A C
g=9.81;
L=1;
C=1;


%C'est ici que ça se passe
rebondsMax=200;
omega=3;
A=0.5;
yInit=0.7;
yDotInit=2;
xInit=0.5;
xDotInit=1;
startGraph=12;
endGraph=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%
deltaXInit=0.01;
deltaYInit=0;
deltaXDotInit=0;
deltaYDotInit=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%

t0=0;
tStep=0.005;
tGlob1=[];
yGlob1=[];
tGlob2=[];
yGlob2=[];
options = odeset('Events',@nextRebound,'RelTol',1e-8);
indexStart=floor(startGraph/tStep)+1;
indexEnd=ceil(endGraph/tStep)-1




y0=yInit;
yDot0=yDotInit;
x0=xInit;
xDot0=xDotInit;
for i=1:rebondsMax
   rebonds=i
   [t,y,t0,x0,y0,xDot0,yDot0] = oneRebound(t0,tStep,x0,y0,xDot0,yDot0, options);
   tGlob1=[tGlob1;t];
   yGlob1=[yGlob1;y];
end



y0=yInit+deltaYInit;
yDot0=yDotInit+deltaYDotInit;
x0=xInit+deltaXInit;
xDot0=xDotInit+deltaXDotInit;
t0=0;

for i=1:rebondsMax
   rebonds=i
   [t,y,t0,x0,y0,xDot0,yDot0] = oneRebound(t0,tStep,x0,y0,xDot0,yDot0, options);
   tGlob2=[tGlob2;t];
   yGlob2=[yGlob2;y];
end



if indexEnd<0
   figure('NumberTitle','on','Name','Position en fct du temps','Renderer','OpenGL','Color','w','Position',[50 50 600 600])
   plot(tGlob1(indexStart:end),yGlob1(indexStart:end,1), tGlob2(indexStart:end), yGlob2(indexStart:end,1))
   grid on;box on;

   figure('NumberTitle','on','Name','Plan des phases','Renderer','OpenGL','Color','w','Position',[150 150 600 600])
   plot(yGlob1(indexStart:end,1),yGlob1(indexStart:end,3),yGlob2(indexStart:end,1),yGlob2(indexStart:end,3))
   xlabel("position en x");
   ylabel("vitesse en x");
   legend("Attention projete sur un axe!!");
   axis("auto")
   grid on; box on;
else
   figure('NumberTitle','on','Name','Position en fct du temps','Renderer','OpenGL','Color','w','Position',[50 50 600 600])
   plot(tGlob1(indexStart:indexEnd),yGlob1(indexStart:indexEnd,1), tGlob2(indexStart:indexEnd), yGlob2(indexStart:indexEnd,1))
   grid on;box on;

   figure('NumberTitle','on','Name','Plan des phases','Renderer','OpenGL','Color','w','Position',[150 150 600 600])
   plot(yGlob1(indexStart:indexEnd,1),yGlob1(indexStart:indexEnd,3),yGlob2(indexStart:indexEnd,1),yGlob2(indexStart:indexEnd,3))
   xlabel("position en x");
   ylabel("vitesse en x");
   legend("Attention projete sur un axe!!");
   axis("auto")
   grid on; box on;
end
