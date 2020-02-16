Pa = [5;5;5;5;5;5;5;0.918;1.84;2.98;3.78;4.91];
Pb = [.922;1.36;1.97;2.8;2.91;3.89;4.85;5;5;5;5;5];
rPrime = [1.6;2.56;3.27;3.64;3.48;4.46;4.75;1.47;2.48;3.45;4.06;4.75];

[X1, Y1, theta1, E1, rPrimeEstimated1, k1, K11, K21,Yp1] = rate1CollectTerms(Pa,Pb,rPrime);
[X2, Y2, theta2, E2, rPrimeEstimated2, k2, K12, K22,Yp2] = rate2CollectTerms(Pa,Pb,rPrime);
[X3, Y3, theta3, E3, rPrimeEstimated3, k3, K13, K23,Yp3] = rate3CollectTerms(Pa,Pb,rPrime);
% Rate 1 and 2 are not valid because the K1 and K2 parameters came out to a
% negative (not physically possible) value
sigmaSquared1 = (1/(12-3))*sum(abs(Y1-Yp1).^2);
sigmaSquared2 = (1/(12-3))*sum(abs(Y2-Yp2).^2);
sigmaSquared3 = (1/(12-3))*sum(abs(Y3-Yp3).^2);
zeroarr = zeros(12,1);
linSpace = 1:1:12;

subplot(3,2,1);
plot(linSpace, E1, 'o', linSpace, zeroarr);
xlabel('Experiment');
ylabel('rate mol / (g cat min)');
legend('error');
title('Rate 1');

subplot(3,2,2);
plot(linSpace, rPrime,'x',linSpace, rPrimeEstimated1, 'o');
xlabel('Experiment');
ylabel('rate mol / (g cat min)');
legend('Actual','Estimated');
title('Rate 1');


subplot(3,2,3);
plot(linSpace, E2, 'o', linSpace, zeroarr);
xlabel('Experiment');
ylabel('rate mol / (g cat min)');
legend('error');
title('Rate 2');


subplot(3,2,4);
plot(linSpace, rPrime,'x',linSpace, rPrimeEstimated2, 'o');
xlabel('Experiment');
ylabel('rate mol / (g cat min)');
legend('Actual','Estimated');
title('Rate 2');


subplot(3,2,5);
plot(linSpace, E3, 'o', linSpace, zeroarr);
xlabel('Experiment');
ylabel('rate mol / (g cat min)');
legend('error');
title('Rate 3');

subplot(3,2,6);
plot(linSpace, rPrime,'x',linSpace, rPrimeEstimated3, 'o');
xlabel('Experiment');
ylabel('rate mol / (g cat min)');
legend('Actual','Estimated');
title('Rate 3');



function [X, Y, theta, E, rPrimeEstimated, k, K1, K2,Yp] = rate1CollectTerms(Pa, Pb, rPrime)


X1 = -Pa.*rPrime;
X2 = -Pb.*rPrime;
X3 = Pa.*Pb;

X = [X1 X2 X3];
Y = rPrime;

theta = X\Y;

k = theta(3);
K1 = theta(1);
K2 = theta(2);


rPrimeEstimated = k.*Pa.*Pb./(1 + K1.*Pa + K2.*Pb);

Yp = X*theta;
%rPrimeEstimated = Yp;
E = (1 - Yp./Y);
end

function [X, Y, theta, E, rPrimeEstimated, k, K1, K2,Yp] = rate2CollectTerms(Pa, Pb, rPrime)


X1 = -Pa.*rPrime;
X2 = -Pb.*rPrime;
X3 = Pa;
X = [X1 X2 X3];

Y = rPrime;

theta = X\Y;

K1 = theta(1);
K2 = theta(2);
k = theta(3);

rPrimeEstimated = k*Pa./(1 + K1*Pa + K2*Pb);

Yp = X*theta;
%rPrimeEstimated = Yp;

E = (1 - Yp./Y);
end

function [X, Y, theta, E, rPrimeEstimated, k, K1, K2,Yp] = rate3CollectTerms(Pa, Pb, rPrime)

squareRootRPrime = (rPrime).^(1/2);

X1 = -(Pa.*squareRootRPrime);
X2 = -(Pb.*squareRootRPrime);
X3 = (Pa.*Pb).^(1/2);

X = [X1 X2 X3];
Y = squareRootRPrime;

theta = X\Y;

k = theta(3).^2;
K1 = theta(1);
K2 = theta(2);
denominator = ((1 + K1*Pa + K2*Pb).^2);
rPrimeEstimated = (k.*Pa.*Pb)./denominator;

Yp = X*theta;
%rPrimeEstimated = (Yp).^2;

E = (1 - Yp./Y);


end