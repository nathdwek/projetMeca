function [tEnd]=findTEnd(t0, x0, y0, xDot0, yDot0)
   global g l L omega C
   if g~=0
      tMax=yDot0/g
   end
   if xDot0>0
      tX=(L-x0)/xDot0;
   elseif xDot0<0
      tX=(-L-X0)/xDot0;
   else
      tX=-1
   end
   [tY1 tY3]=roots([-g/2 yDot0 y0-1]);

