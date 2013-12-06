function courtePeriode=getCourtePeriode(y0, yDot0)
   global g
   racines=roots([-g/2 yDot0 y0]);
   courtePeriode=abs(racines(1)-racines(2));
end
