function [value,isterminal,direction] = nextRebound(t,y)
   global L omega value l

   value(1) =y(1)+L;
   isterminal(1) = 1;
   direction(1) = 0;

   value(2) =y(2)-L;
   isterminal(2) = 1;
   direction(2) = 0;

   value(3) =y(1)-L;
   isterminal(3) = 1;
   direction(3) = 0;

   value(4) =y(2)+L;
   isterminal(4) = 1;
   direction(4) = 0;

   xProximity=abs(y(1))-l*(1+sin(omega*t));
   value(5)=sign(y(2));
   if xProximity<1E-8
      value(5)=y(2);
   end
   direction(5) = 0;
   isterminal(5)=1;
end
