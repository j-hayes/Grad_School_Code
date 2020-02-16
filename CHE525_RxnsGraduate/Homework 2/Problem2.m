
Ca = [.2; .02; .05;.08;.1];
T = [700;750;800;850;900];
r = [4.9* 10^-4;1.1 *10^-4; 2.4 *10^-3; 2.2*10^-2 ; 1.18*10^-1];

[X, Y, theta, Err, rEstimated, k0, E, n, e, Yp] = powerLaw(Ca, T, r, 8.314);

subplot(2,1,1)
plot(T, Y, 'o', T, Yp, 'x', T, Yp);
xlabel('T');
ylabel('Yi and Ypi (curve)');
legend('Y', 'Yp points', 'Yp curve');
title('Power Law');


subplot(2,1,2)
plot(T, Err, 'o', T, zeros(5,1));
xlabel('T');
ylabel('Yi and Ypi');
legend('relative error', 'Zero relative error');
title('Power Law Rates');


function [X, Y, theta, Err, rEstimated, k0, E, n, e, Yp] = powerLaw(Ca, T, r, R)

X1 = ones(5,1);
X2 = log(Ca);
X3 = -1./(R*T);

X = [X1 X2 X3];
Y = log(r);

theta = X\Y;

k0 = exp(theta(1));
n = theta(2);
E = theta(3);

e = Y - X*theta;
Yp = X*theta;

rEstimated = k0.*(Ca.^n).*exp(-E./(R.*T));
Err = (1 -(rEstimated./r));

end