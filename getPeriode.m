function periode=getPeriode(which,x0,y0,xDot0,yDot0)
   global g L
   if which=="x"
      periode=4*L/xDot0;
   elseif which=="y"
      if g==0
         periode=4*L/abs(yDot0);
      elseif arg(roots([-g/2 yDot0 y0-L])(1))<1E-15
         periode=2*abs(min(roots([-g/2 yDot0 y0-L]))-min(roots([-g/2 yDot0 y0+L])));
      else
         racines=roots([-g/2 yDot0 y0+L]);
         periode=abs(racines(1)-racines(2));
      end
   else
      disp("erreur sur le choix de direction de periode");
   end
end
