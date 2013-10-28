clear all
global  g L
L=20;g=10;C=1; % C est le coefficient de restitution
ydot_initial=0;
y_initial=10;
x_initial=0;
xdot_initial=5;
t_initial=0;

% Cosmétique Graphe

figure('NumberTitle','on','Name','Une balle sur une tole ondulée','Renderer','OpenGL','Color','w','Position',[100 100 500 500])
subplot(2,1,1);
xlabel('x(m)');ylabel('y (m)');
subplot(2,1,2);
title('Visualisation du mouvement');
xlabel('x(m)');ylabel('y (m)');
hold on;
% Fin Cosmétique Graphe

for i=1:10 % Nombre de rebonds
   options = odeset('Events',@nextRebound,'RelTol',1e-10);
   [t,y] = ode45(@movementEq,[t_initial:0.02:t_initial+10],[x_initial  y_initial xdot_initial ydot_initial],options);
   if y(end, 1)>= L
      vecteur_n = [-1, 0]
   elseif y(end, 1) <= -L
      vecteur_n = [1 0]
   elseif y(end, 2) >= L
      vecteur_n = [0 -1]
   elseif y(end, 2) <= -L
      vecteur_n = [0 1]
   end

   t
   y
   subplot(2,1,1);
   plot(t(1:end),y(1:end,2)); hold on;
   drawnow;
   hold on;




   % Conditions initiales après impact

   x_initial=y(end,1);

   y_initial=y(end,2);

   xdot_initial=C*(y(end,3)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(1))+(1+C)*cos(t(end))*vecteur_n(1); %cette formule est générale du moment que vous avez calculé la normale au point d'impact

   ydot_initial=C*(y(end,4)-2*(y(end,3)*vecteur_n(1)+y(end,4)*vecteur_n(2))*vecteur_n(2))+(1+C)*cos(t(end))*vecteur_n(2); %cette formule est générale du moment que vous avez calculé la normale au point d'impact

   % le terme (1+C)*cos(t(end)) est le résultat de la

   % conservation de la quantité de mouvement avant et après impact. C'est la quantité de mouvement

   % échangée entre la balle et la plaque onduéle.

   % On la projette suivant x et y et on additionne à la vitesse suivant 1x et suivant 1y

   t_initial=t(end)

   % Fin conditions initiales après impact
end
