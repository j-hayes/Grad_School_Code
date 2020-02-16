Pa = [1;1;3;1;1;10;1;1;2;1;.6;5];
Pb = [1;1;1;3;1;1;10;1;2;1;.6;5];
Pc = [0;1;1;1;3;0;0;10;2;4;.6;5];

rPrime = [
0.0362;
0.0239;
0.039;
0.0351;
0.0114;
0.0534;
0.028;
0.0033;
0.038;
0.009;
0.0127;
0.0566];



[X, Y, theta, E, rPrimeEstimated, k, K1, K2,K3,Yp] = problem3Rate(Pa,Pb,Pc,rPrime);

sigmaSquared1 = (1/(12-3))*sum(abs(Y-Yp).^2);
zeroarr = zeros(12,1);
linSpace = 1:1:12;

subplot(2,1,1);
plot(linSpace, E, 'o', linSpace, zeroarr);
xlabel('Experiment');
ylabel('rate mol / (g cat h)');
legend('error');
title('Errors');

subplot(2,1,2);
plot(linSpace, rPrime,'x',linSpace, rPrimeEstimated, 'o');
xlabel('Experiment');
ylabel('rate mol / (g cat h)');
legend('Actual','Estimated');
title('Values Vs Predicted');



function [X, Y, theta, E, rPrimeEstimated, k, K1, K2,K3,Yp] = problem3Rate(Pa, Pb, Pc, rPrime)

squareRootRPrime = (rPrime).^(1/2);

X1 = -(Pa.*squareRootRPrime);
X2 = -(Pb.*squareRootRPrime);
X3 = -(Pc.*squareRootRPrime);
X4 = (Pa.*Pb).^(1/2);

X = [X1 X2 X3 X4];
Y = squareRootRPrime;

theta = X\Y;

k = theta(4).^2;
K1 = theta(1);
K2 = theta(2);
K3 = theta(3);
denominator = ((1 + K1*Pa + K2*Pb + K3*Pc).^2);
rPrimeEstimated = (k.*Pa.*Pb)./denominator;
%rPrimeEstimated = (Yp).^2;

Yp = X*theta;

E = (1 - Yp./Y);


end