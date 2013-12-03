function [t y newT0 newFirstPick newX0 newY0 newXDot0 newYDot0]=oneRebound2(t0, firstPick, periode, x0, y0, xDot0, yDot0)
   global g l L omega C
   y=[]
   t=[]
   tEnd=findTEnd(t0, x0, y0, xDot0, yDot0);
   for tEch=firstPick:periode:tEnd
      y=[y;calcY(tEch, x0, y0, xDot0, yDot0)];
      t=[t;tEch];
   end
   newT0=tEnd;
   [newX0 newY0 newXDot0 newYDot0]=calcY(newT0);
   newFirstPick=t(end)+periode;
end

