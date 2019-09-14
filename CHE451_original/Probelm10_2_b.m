import AntonieEquation.*

A_Clorobutane= 13.7965;
B_Clorobutane = 2723.73;
C_Clorobutane = 218.265;

A_CloroBenzene = 13.8635;
B_CloroBenzene = 3174.78;
C_CloroBenzene = 211.700;
antonieEquation = AntonieEquation;

%%%% P vs x,y
temp90Celcius = 90;
pSatClorobutane = antonieEquation.GetSaturationPressure(A_Clorobutane,B_Clorobutane,C_Clorobutane,90);
pSatCloroBenzene = antonieEquation.GetSaturationPressure(A_CloroBenzene,B_CloroBenzene,C_CloroBenzene,90);
pSatClorobutane
pSatCloroBenzene
%clorobutane has a higher saturation pressure so it is the more volitile. 

%raoult's law yi*Pressure = xi*PressureiSat
%P * Sum(yi) = Sum(xi*PressureiSat)
%P = Sum(xi*PressureiSat)
xiZeroToOne = linspace(0,1,100);
BublP = xiZeroToOne * pSatClorobutane + (1 - xiZeroToOne) * pSatCloroBenzene;
%raoult's law yi*Pressure = xi*PressureiSat
%P * Sum(yi/PressureiSat) = Sum(xi) = 1
%P = 1/Sum(yi/PressureiSat))
yiZeroToOne = linspace(0,1,100);
DewP =   1./((yiZeroToOne/pSatClorobutane) + ((1 - yiZeroToOne)./pSatCloroBenzene));
%plot
plot(xiZeroToOne, BublP, yiZeroToOne,DewP)

%%%%%% T vs x,y
pressure90Kpa = 90;
boilingPointClorobutane = antonieEquation.GetBoilingPointForPressure(A_Clorobutane,B_Clorobutane,C_Clorobutane,90);
boilingPointCloroBenzene = antonieEquation.GetBoilingPointForPressure(A_CloroBenzene,B_CloroBenzene,C_CloroBenzene,90);

temperatures = linspace(boilingPointClorobutane,boilingPointCloroBenzene,100);
pressuresCloroButane = antonieEquation.GetSaturationPressureFromTemperatures(A_Clorobutane,B_Clorobutane,C_Clorobutane, temperatures);
pressuresCloroBenzene = antonieEquation.GetSaturationPressureFromTemperatures(A_CloroBenzene,B_CloroBenzene,C_CloroBenzene,temperatures); 

X = (pressure90Kpa - pressuresCloroBenzene)./(pressuresCloroButane - pressuresCloroBenzene);
Y = X.*pressuresCloroButane/pressure90Kpa;

plot(X,temperatures,Y,temperatures)



