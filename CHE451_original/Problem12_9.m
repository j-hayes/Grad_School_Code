import AntonieEquation.*;
antonieEquation = AntonieEquation;

saturationPressureAcetonitrile = antonieEquation.GetSaturationPressure(14.8950,3413.10, 250.523, 45);
saturationPressureBenzene = antonieEquation.GetSaturationPressure(13.7819, 2726.81, 217.572, 45);
pressures = [29.819 31.857 33.285 35.285 36.457 36.996 37.068 36.978 36.778 35.792 34.372 32.331 30.038 27.778];
x1 = [0 0.0455 .0940 .1829 .2909 .3980 .5069 .5458 .5946 .7206 .8145 .8972 .9573 1.0];
y1 = [0 .1056 .1818 .2783 .3607 .4274 .4885 .5098 .5375 .6157 .6913 .7869 .8916 1.0];
y2 = 1-y1;
x2 = 1-x1;
A = [0 0; 0 0]
C = 0;

gamma1Exp = y1.*pressures./(x1.*saturationPressureAcetonitrile);
gamma2Exp = y2.*pressures./(x2.*saturationPressureBenzene);
lnGamma1Exp= log(gamma1Exp)
lnGamma2Exp = log(gamma2Exp)
GeOverRTX1X2Exp = (x1.*log(gamma1Exp) + x2.*log(gamma2Exp))./(x1.*x2);

scatter(x1, GeOverRTX1X2Exp);hold on;
scatter(x1, lnGamma1Exp);hold on;
scatter(x1,lnGamma2Exp);hold on;
x = .1 + x1;
plot(x1,x);hold on;

legend('Exp', 'ln(gamma1)exp','ln(gamma2)exp', 'x=1'); hold on;
hold on;
hold off;

function GeOverRT = margules(x1,x2,A,C);
%A parameter with values for A21 and A12 
% C constant 
    GeOverRT = (A(2,1).*x1 + A(1,2).*x2-C.*x2).*x1.*x2;
end