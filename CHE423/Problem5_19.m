Fao = 6.85;
R = 10.73;
T1 = 660;%Rankin
T2 = 760;%rankin
V = 6.14; %ft^3
P = 114.7;%Pa
k1 = .00152 * 60 * 60;% hr^-1
EoverR = log(.074/.00152)*(T2*T1/(T2-T1));


constant = (Fao*log(5)*R)/(k1*P*V);


Taaa = fzero(@(T3)-T3 + exp((EoverR)*((1/T1)-(1/T3)))/constant, T2);

% 
% 
% 
% 
% Fao = 6.85;
% R = 8.314;
% T1 = 366.5;%Kelvin
% V = .0174; %m^3
% P = 689475.729;%Pa
% k1 = .00152 * 60 * 60;% hr^-1
% EoverR = log(.074/.00152)*(422.039*366.5/(422.039-366.5));
% 
% 
% constant = (Fao*log(5)*R)/(k1*P*V);
% 
% 
% T3 = fzero(@(T3)(k1*V*P*exp((-1*EoverR)*((1/T1)-(1/T3)))/(R*Fao*log(5))), 408);
% 
