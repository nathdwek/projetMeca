function [t y newT0 newX0 newY0 newXDot0 newYDot0] = oneRebound(t0,tStep,x0,y0,xDot0,yDot0, options)
   global C omega l
   [t,y] = ode45(@movementEq,[t0:tStep:t0+40],[x0 y0 xDot0 yDot0],options);
   vecteur_n=[0 0];
   newT0=t(end);
   newX0=y(end,1);
   newY0=y(end,2);
   value=nextRebound(t(end),y(end,:));
   if value(1)<1E-8
      vecteur_n=[1 0];
      newX0=-1+5E-8;
   end
   if value(2)>-1E-8
      vecteur_n=[0 -1];
      newY0=1-5E-8;
   end
   if value(3)>-1E-8
      vecteur_n=[-1 0];
      newX0=1-5E-8;
   end
   if value(4)<1E-8
      vecteur_n=[0 1];
      newY0=-1+5E-8;
   end
   if value(5)<1E-6 && value(5)>-1E-13 && (y(end,2)-y(end-1,2))<0
      vecteur_n=[0 1];
      newY0=5E-8;
   end
   if value(5)>-1E-6 && value(5)<1E-13 && (y(end,2)-y(end-1,2))>0
      vecteur_n=[0 -1];
      newY0=-5E-8;
   end
   if abs(value(5))<1E-8
      newXDot0=C*(y(end,3)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(1))+(1+C)*l*cos(omega*t(end))*omega;
   else
      newXDot0=C*(y(end,3)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(1));
   end
   newYDot0=C*(y(end,4)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(2));
end
