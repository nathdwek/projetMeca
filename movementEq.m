function dy=movementEq(t, y)
   global g
   dy = zeros(4,1);
   dy(1) = y(3);
   dy(3) =0;

   dy(2) = y(4);
   dy(4)=-g;
