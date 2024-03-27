close all;

e = out.e;
de = out.de;
c = pa.c;

plot(e,-c*e,e,de,'r:','linewidth',2);
legend('s = 0','s schange'); 
xlable('e');ylable('de');
title('phase portait');