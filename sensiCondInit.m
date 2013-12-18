clear all

global g L omega A C l
L=1;
C=1;



%C'est ici que ça se passe
rebondsMax=2000;
g=9.81;
l=0.5;
omega=0;
y0=0.6;
yDot0=0;
x0=0.4;
xDot0=2;
%%%%%%%%%%%%%%%%%%%%%%%%%%
startGraph=300;
endGraph=320;
deltaXInit=0.001;
deltaYInit=0;
deltaXDotInit=0;
deltaYDotInit=0.001;
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


figure('NumberTitle','on','Name','Position en fct du temps','Renderer','OpenGL','Color','w','Position',[50 50 600 600])
if indexEnd<0
   plot(tGlob1(indexStart:end),yGlob1(indexStart:end,2), tGlob2(indexStart:end), yGlob2(indexStart:end,2))
else
   plot(tGlob1(indexStart:indexEnd),yGlob1(indexStart:indexEnd,2), tGlob2(indexStart:indexEnd), yGlob2(indexStart:indexEnd,2),"r")
   title("Sensibilite aux Conditions Initiales")
   text(endGraph+1, L+0.15, ["x0= ", num2str(x0),"  y0= ", num2str(y0)]);
   text(endGraph+1, L+0.1, ["xDot0= ", num2str(xDot0),"  yDot0= ", num2str(yDot0)]);
   text(endGraph+1, L+0.05, ["g= " num2str(g) "  omega= " num2str(omega) "  l/L= " num2str(l)]);
   text(endGraph+1, L-0.1, ["Delta x0= ", num2str(deltaXInit),"  Delta y0= ", num2str(deltaYInit)]);
   text(endGraph+1, L-0.15, ["Delta xDot0= ", num2str(deltaXDotInit),"  Delta yDot0= ", num2str(deltaYDotInit)]);
   axis([startGraph endGraph+5 -L-.1 L+.2])
   line([startGraph-20 endGraph+20],[-L -L], "linewidth", 1.5);
   line([startGraph-20 endGraph+20],[0 0], "linewidth", 1);
   line([startGraph-20 endGraph+20],[L L], "linewidth", 1.5);
   xlabel('Temps')
   ylabel('Coordonnee y de la balle')
   grid on;
   hold on;
end

