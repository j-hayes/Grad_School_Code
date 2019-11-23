clear all
T0_Far = 55; %F
T0_Rank = 55+459.67; %Rankine
Ta_Far = 80; % F
FA0 = 150; %lb mol/hr
Ta_Rank = 80+459.67; % Rankine
U = 100; %btu/(hr*ft^2*F)
A = 40; %ft^2
Cp0 = 400; % btu/(lbmol*F)
dH = -36000; % btu/lb mol 
kap = U*A/(FA0*Cp0);
beta = -dH/Cp0; %F
Arr = 1.7*10^13; %arrhenius constant
EaoverR = -16500; % Ea/R
k0 = Arr*exp(EaoverR/T0_Rank);

tau = 0.4;
X = 0:.02:1;%many slopes for F1 and F2
Temp = (T0_Far+kap*Ta_Far+beta.*X)/(1+kap); %F
Temp_Rank = Temp + 459.67; % Rankine
kExponentialTerm = -16500./Temp_Rank;
k = (1.7*10^13)*exp(kExponentialTerm);
f1 = X./k;
f2 = (1-X).*tau;    
plot(f1,X,'-*',f2,X);
legend('f1','f2')
title('X vs Tau')
xlabel('Residence Time')
ylabel('Conversion')