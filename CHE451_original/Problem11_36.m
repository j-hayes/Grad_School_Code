x1 = [.0426 .0817 .1177 .1510 .2107 .2624 .3472 .4158 .5163 .6156 .6810 .7621 .8181 .8650 .9276 .9624]
HeEperimental = [-23.3 -45.7 -66.5 -86.6 -118.2 -144.6 -176.6 -195.7 -204.2 -191.7 -174.1 -141.0 -116.8 -85.6 -43.5 -22.6]

a = -500;%did guess and check by hand
b = -1135;
c=1010;

he = HE(x1,a,b,c);
subplot(2,1,1)
plot(x1, HeEperimental, x1,He)
legend('exp','He')

%%%b
functionToFinMin = @(x1) dHe_dx1(x1, a, b , c)

minx1 = fzero(functionToFinMin, .5)
HeMin = HE(minx1,a,b,c)


%%%% c

Hebar1 = HE(x1,a,b,c) + (1-x1).*dHe_dx1(x1,a,b,c);
Hebar2 = HE(x1,a,b,c) + x1.*dHe_dx1(x1,a,b,c);
subplot(2,1,2)
plot(x1, Hebar1, x1, Hebar2)

%%He1Bar = He(.512) + .512*dhe_dx();

  function he = dHe_dx1(x1, a,b,c)
      he = a - 2*a.*x1 + x1.*(b.*(2 - 3.*x1) + c .*(3 - 4.*x1).*x1);
  end
  
  function he = HE(x1, a,b,c)
      he = (x1.*(1-x1)).*(a+(b.*x1)+(c.*(x1.^2)));
  end




