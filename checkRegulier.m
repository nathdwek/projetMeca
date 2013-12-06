function isRegulier=checkRegulier(yGlob)
   i=1;
   isRegulier=true;
   while i<length(yGlob) && isRegulier
      isRegulier=norm([yGlob(i+1,1)-yGlob(i,1) yGlob(i+1,2)-yGlob(i,2)])<1E-5;
      i=i+1;
   endwhile
end
