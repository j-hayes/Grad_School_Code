w = .012
Pc = (45.99*10^5);
Tc = 190.6;

T = 250;%K
P = (90*10^5);%bar
R = 8.314;


Pr = P/Pc;
Tr = T/Tc;

B0 = .083 - (.422/(Tr^1.6));
B1 = .139 - (.172/(Tr^4.2));
dB0dTr = (.675/(Tr^2.6));
dB1dTr = (.722/(Tr^5.2));

Z = 1 + B0*(Pr/Tr) + w*B1*(Pr/Tr);

VIdeal = R*T/P;
VReal = R*T*Z/P;

VR = VReal - VIdeal;
HR = R*Tc*Pr*(B0 - Tr*dB0dTr + w*(B1 - Tr*dB1dTr));
SR = -1*R*Pr*(dB0dTr+w*dB1dTr);

VR
HR
SR




 
