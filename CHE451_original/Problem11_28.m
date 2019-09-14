x1 = linspace(0,1,11);
x2 = 1-x1;

GeOverRT = -1.8.*x1 + x1.^2 + .8.*(x1.^3);

lnGamma1 = -1.8 + 2.*x1 +1.4.*x1.^2 -1.6.*x1.^3;
lnGamma2 = (-1.*x1.^2)-1.6.*x1.^3;

plot(x1,lnGamma1,x1,lnGamma2, x1, GeOverRT)
hold on
legend('ln(Gamma1)','ln(gamma2),','Ge/RT')

lnGamma1Inf=lnGamma1(1);
lnGamma2Inf=lnGamma2(11);

text(x1(1), lnGamma1(1),'ln(gamma1inf)')
text(x1(11), lnGamma2(11),'ln(gamma1inf)')
    




