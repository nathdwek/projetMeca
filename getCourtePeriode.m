function courtePeriode=getCourtePeriode(y0, yDot0)
   global g L
   if g==0
      courtePeriode=2*L/yDot0;
   else
      racines=roots([-g/2 yDot0 y0]);
      courtePeriode=abs(racines(1)-racines(2));
   end
end
