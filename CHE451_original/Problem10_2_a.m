import AntonieEquation.*
temp90Celcius = 90;

A_Benezene = 13.7819;
B_Benezene = 2726.81;
C_Benezene = 217.572;

A_EthylBenzene = 13.9726;
B_EthylBenzene = 3259.93;
C_EthylBenzene = 212.300;
antonieEquation = AntonieEquation;

%%%% P vs x,y
pSatBenezene = antonieEquation.GetSaturationPressure(A_Benezene,B_Benezene,C_Benezene,90);
pSatEthylBenezene = antonieEquation.GetSaturationPressure(A_EthylBenzene,B_EthylBenzene,C_EthylBenzene,90);

pSatBenezene
pSatEthylBenezene

%benzene has a higher saturation pressure so it is the more volitile. 

%raoult's law yi*Pressure = xi*PressureiSat
%P * Sum(yi) = Sum(xi*PressureiSat)
%P = Sum(xi*PressureiSat)
xiZeroToOne = linspace(0,1,100);
BublP = xiZeroToOne * pSatBenezene + (1 - xiZeroToOne) * pSatEthylBenezene;
%raoult's law yi*Pressure = xi*PressureiSat
%P * Sum(yi/PressureiSat) = Sum(xi) = 1
%P = 1/Sum(yi/PressureiSat))
yiZeroToOne = linspace(0,1,100);
DewP =   1./((yiZeroToOne/pSatBenezene) + ((1 - yiZeroToOne)./pSatEthylBenezene));
%plot
plot(xiZeroToOne, BublP, yiZeroToOne,DewP)

%%%%%% T vs x,y
pressure90Kpa = 90;
boilingPointBenzene = antonieEquation.GetBoilingPointForPressure(A_Benezene,B_Benezene,C_Benezene,90);
boilingPointEthylBenzene = antonieEquation.GetBoilingPointForPressure(A_EthylBenzene,B_EthylBenzene,C_EthylBenzene,90);

temperatures = linspace(boilingPointBenzene,boilingPointEthylBenzene,100);
pressuresBenzene = antonieEquation.GetSaturationPressureFromTemperatures(A_Benezene,B_Benezene,C_Benezene, temperatures);
pressuresEthylBenzene = antonieEquation.GetSaturationPressureFromTemperatures(A_EthylBenzene,B_EthylBenzene,C_EthylBenzene,temperatures); 

X = (pressure90Kpa - pressuresEthylBenzene)./(pressuresBenzene - pressuresEthylBenzene);
Y = X.*pressuresBenzene/pressure90Kpa;
plot(X,temperatures,Y,temperatures)







