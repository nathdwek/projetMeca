clear all

global g L omega A C l
L=1;
C=1;



%C'est ici que ça se passe
rebondsMax=160;
g=9.81;
l=0.3;
omega=2;
y0=0.8;
yDot0=-1;
x0=0;
xDot0=1;
%%%%%%%%%%%%%%%%%%%%%%%%%%
startGraph=0;
endGraph=0;
deltaXInit=0.01;
deltaYInit=0;
deltaXDotInit=0;
deltaYDotInit=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%
t0=0;
periode=0.005;
tGlob1=[];
yGlob1=[];
tGlob2=[];
yGlob2=[];
indexStart=floor(startGraph/periode)+1;
indexEnd=ceil(endGraph/periode)-1;
firstPick=0;




yInit=y0;
yDotInit=yDot0;
xInit=x0;
xDotInit=xDot0;
for i=1:rebondsMax
   [t y t0 xInit yInit xDotInit yDotInit firstPick]=oneRebound(t0, firstPick, periode, xInit, yInit, xDotInit, yDotInit);
   tGlob1=[tGlob1;t];
   yGlob1=[yGlob1;y];
end



yInit=y0+deltaYInit;
yDotInit=yDot0+deltaYDotInit;
xInit=x0+deltaXInit;
xDotInit=xDot0+deltaXDotInit;
t0=0;
firstPick=0;

for i=1:rebondsMax
   [t y t0 xInit yInit xDotInit yDotInit firstPick]=oneRebound(t0, firstPick, periode, xInit, yInit, xDotInit, yDotInit);
   tGlob2=[tGlob2;t];
   yGlob2=[yGlob2;y];
end



if indexEnd<0
   figure('NumberTitle','on','Name','Position en fct du temps','Renderer','OpenGL','Color','w','Position',[50 50 600 600])
   plot(tGlob1(indexStart:end),yGlob1(indexStart:end,1), tGlob2(indexStart:end), yGlob2(indexStart:end,1))
   grid on;box on;
else
   figure('NumberTitle','on','Name','Position en fct du temps','Renderer','OpenGL','Color','w','Position',[50 50 600 600])
   plot(tGlob1(indexStart:indexEnd),yGlob1(indexStart:indexEnd,1), tGlob2(indexStart:indexEnd), yGlob2(indexStart:indexEnd,1))
   grid on;box on;
   print -dpng test.png
end
