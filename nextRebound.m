function [value,isterminal,direction] = nextRebound(t,y)
   global L omega A
   value(1) = y(2)+L; % si y(2) qui est la position de la balle rencontre la plaque horizontale inférieure
   isterminal(1) = 1; % stopper l'intégration
   direction(1) = -1; % la balle ne peut aller plus bas

   value(2) = y(2)-L; % si y(2) qui est la position de la balle rencontre la plaque horizontale supérieure
   isterminal(2) = 1; % stopper l'intégration
   direction(2) = 1; % la balle ne peut aller plus haut

   value(3) = y(1)+L; % si y(2) qui est la position de la balle rencontre la plaque verticale de gauche
   isterminal(3) = 1; % stopper l'intégration
   direction(3) = -1; % la balle ne peut aller plus à gauche

   value(4) = y(1)-L; % si y(2) qui est la position de la balle rencontre la plaque verticale de droite
   isterminal(4) = 1; % stopper l'intégration
   direction(4) = -1; % la balle ne peut aller plus à droite

   end
