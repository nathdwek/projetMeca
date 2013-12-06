function periode=getPeriode(which,x0,y0,xDot0,yDot0)
   global g L
   if which=="x"
      periode=4*L/xDot0;
   elseif which=="y"
      if g==0
         periode=2*(y0+L)/yDot0;
      else
         racines=roots([-g/2 yDot0 y0+L]);
         periode=abs(racines(1)-racines(2))
      end
   else
      disp("erreur sur le choix de direction de periode");
   end
end
