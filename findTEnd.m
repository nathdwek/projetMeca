function [tEnd reason newX0 newY0]=findTEnd(t0, x0, y0, xDot0, yDot0)
   global g l L omega C
   if xDot0>0
      tX=(L-x0)/xDot0;
      newX=L-1E-10;
   elseif xDot0<0
      tX=(-L-x0)/xDot0;
      newX=-L+1E-10;
   else
      tX=-1;
   end
   if yDot0<0
      if y0<=0
         tY=max(roots([-g/2 yDot0 y0+L]));
         reason=1;
         newY=-L+1E-10;
      else
         tY=max(roots([-g/2 yDot0 y0]));
         reason=2;
         newY=1E-10;
         if abs(x0+xDot0*tY)-l*(1+sin(omega*(tY+t0)))>0
            tY=max(roots([-g/2 yDot0 y0+L]));
            reason=1;
            newY=-L+1E-10;
         end
      end
   else
      if y0>0
         tY=min(roots([-g/2 yDot0 y0-L]));
         reason=1;
         newY=L-1E-10;
         if arg(tY)~=0
            tY=max(roots([-g/2 yDot0 y0]));
            reason=2;
            newY=1E-10;
            if abs(x0+xDot0*tY)-l*(1+sin(omega*(tY+t0)))>0
               tY=max(roots([-g/2 yDot0 y0+L]));
               reason=1;
               newY=-L+1E-10;
            end
         end
      else
         tY=min(roots([-g/2 yDot0 y0]));
         reason=2;
         newY=-1E-10;
         if arg(tY)~=0
            tY=max(roots([-g/2 yDot0 y0+L]));
            reason=1;
            newY=-L+1E-10;
         else
            if abs(x0+xDot0*tY)-l*(1+sin(omega*(tY+t0)))>0
               tY=min(roots([-g/2 yDot0 y0-L]));
               reason=1;
               newY=L-1E-10;
               if arg(tY)~=0
                  tY=max(roots([-g/2 yDot0 y0]));
                  reason=2;
                  newY=1E-10;
                  if abs(x0+xDot0*tY)-l*(1+sin(omega*(tY+t0)))>0
                     tY=max(roots([-g/2 yDot0 y0+L]));
                     reason=1;
                     newY=-L+1E-10;
                  end
               end
            end
         end
      end
   end
   if tX>=0
      if tX<tY
         reason=3;
         tEnd=tX+t0;
         newX0=newX;
         newY0=y=polyval([-g/2 yDot0 y0],tX);
      else
         tEnd=tY+t0;
         newY0=newY;
         newX0=x0+xDot0*tY;
      end
   else
      tEnd=tY+t0;
      newY0=newY;
      newX0=x0+xDot0*tY;
   end
end






