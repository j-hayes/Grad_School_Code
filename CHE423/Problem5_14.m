Fao = 50000;%mol/hr
k = .054;
kA = .32;
Patm = 10;
T =660;
R = 82.06;

%fluidized cstr 
x1 = .8;
WCSTR = Fao*x1*(1+kA*Patm*R*T*(1-x1))^2/(k*Patm*R*T*(1-x1))
