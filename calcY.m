function [x y xDot yDot]=calcY(t, x0, y0, xDot0, yDot0)
   global g
   x=x0+t*xDot0;
   y=polyval([-g/2 yDot0 y0],t);
   xDot=xDot0;
   yDot=yDot0-g*t;
end
