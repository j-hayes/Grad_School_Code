function F =  solveForNa(x)
Xa1 = .97;
k1 = .53*10^-2;
T = 298;%K
P = 1;%atm
R = 82.06*10^-3;
Na = x(1)

Xa2 = (Na*R*T)/(k1*P)

lnNumerator = 1 - (Xa2/2)
lnDenomenator = 1-(Xa1/2)
lnPortion = log(lnNumerator/lnDenomenator)

Concentration = 1;
delta = .0013;
DAB = .2*10^-4;

NaCalculated = ((2*DAB*Concentration)/delta) *lnPortion
Xa2Calculated = Xa2

error =  abs(Na- NaCalculated)

F(1) = error; %function that should return 0 or near zero when the equation is solved