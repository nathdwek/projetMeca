function [t y newT0 newX0 newY0 newXDot0 newYDot0 newFirstPick]=oneRebound2(t0, firstPick, periode, x0, y0, xDot0, yDot0)
   global g l L omega C
   y=[];
   t=[];
   [tEnd reason newX0 newY0]=findTEnd(t0, x0, y0, xDot0, yDot0);
   if firstPick<=tEnd
      for tEch=firstPick:periode:tEnd
         [nextX nextY nextXDot nextYDot]=calcY(tEch-t0, x0, y0, xDot0, yDot0);
         y=[y; nextX nextY nextXDot nextYDot];
         t=[t;tEch];
      end
      newFirstPick=t(end)+periode;
   else
      newFirstPick=firstPick;
   end
   newT0=tEnd;
   [tmp1 tmp2 newXDot0 newYDot0]=calcY(newT0-t0, x0, y0, xDot0, yDot0);
   if reason==1
      newYDot0=-newYDot0;
   end
   if reason==2
      newYDot0=-newYDot0;
      newXDot0=newXDot0+(1+C)*l*cos(omega*newT0)*omega;
   end
   if reason==3
      newXDot0=-newXDot0;
   end

end

