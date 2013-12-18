function courtePeriode=getCourtePeriode(y0, yDot0)
   global g L
   if g==0
      courtePeriode=2*L/yDot0;
   else
      if arg(roots([-g/2 yDot0 y0-L])(1))<1E-15
         courtePeriode=2*abs(min(roots([-g/2 yDot0 y0-L]))-min(roots([-g/2 yDot0 y0])));
      else
         racines=roots([-g/2 yDot0 y0]);
         courtePeriode=abs(racines(1)-racines(2));
      end
   end
end
