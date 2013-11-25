clear all



list={};
omegaTable=0:0.1:4;

   global g L A C
   g=10;
   L=1;
   C=1;
   A=0.5;

for i=omegaTable

   global omega
   omega=i
   y0=0.8;
   yDot0=1;
   x0=0.5;
   xDot0=1;
   t0=0;
   tStep=0.0005;
   periode=4*L/xDot0;
   poincare=round(periode/tStep)-1;
   tGlob=[];
   yGlob=[];


   options = odeset('Events',@nextRebound,'RelTol',1e-8);
   for i=1:50
      [t,y] = ode45(@movementEq,[t0:tStep:t0+40],[x0 y0 xDot0 yDot0],options);

      vecteur_n=[0 0];
      value=nextRebound(t(end),y(end,:));
      if value(1)<1E-8
         vecteur_n=[1 0];
      end
      if value(2)>-1E-8
         vecteur_n=[0 -1];
      end
      if value(3)>-1E-8
         vecteur_n=[-1 0];
      end
      if value(4)<1E-8
         vecteur_n=[0 1];
      end
      if value(5)<1E-8 && value(5)>-1E-14
         vecteur_n=[0 1];
      end
      if value(5)>-1E-8 && value(5)<1E-14
         vecteur_n=[0 -1];
      end

      tGlob=[tGlob;t];
      yGlob=[yGlob;y];


      if abs(value(5))<1E-8
         xDot0=C*(y(end,3)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(1))+(1+C)*cos(t(end))*omega;
      else
         xDot0=C*(y(end,3)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(1));
      end
      yDot0=C*(y(end,4)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(2));

      x0=y(end,1)+xDot0*tStep;
      y0=y(end,2)+yDot0*tStep;

      t0=t(end)+tStep;
      yDot0=yDot0-g*tStep;

      tGlob=[tGlob;t0];
      yGlob=[yGlob; x0 y0 xDot0 yDot0];
      t0=t0+tStep;
   end
   list{end+1}=yGlob(1:poincare:end, 3);
end


figure('NumberTitle','on','Name','Diagramme Bifurcation','Renderer','OpenGL','Color','w','Position',[200 200 600 600])
axis([omegaTable(1)-0.2 omegaTable(end)+0.2])
for i=1:length(omegaTable)
   for vxTable=list{i}
      length(vxTable)
      for vx=vxTable'
         line([omegaTable(i)],[vx],"Marker", "*", "MarkerSize",5)
      end
   end
end
