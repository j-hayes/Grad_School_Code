import Reduced.*;
import TemperatureUnitConversions.*;


pressure = 30;%bar
temperature = TemperatureUnitConversions.convertCelciusToKelvin(150);
R = 83.14;%cm^3*bar/(mol* K)
y1 = .35;
y2 = 1-y1;
%properties ethylene - 1 
criticalPressureEthylene =50.40;
accentricityFactorEthylene = .087;
criticalTemperatureEthylene = 282.3;
zCriticalEthylene = .281; 
volumeCriticalEthylene = 131;
reducedPressureEthylene = Reduced.getReducedPressure(criticalPressureEthylene, pressure);
reducedTemperatureEthylene = Reduced.getReducedPressure(criticalTemperatureEthylene, temperature);

%properties propelyne - 2
criticalPressurePropylene = 46.65;
accentricityFactorPropylene = .140;
criticalTemperaturePropylene = 365.6;
zCriticalProylene = .289;
volumeCriticalPropylene = 188.4; 
reducedPressurePropylene = Reduced.getReducedPressure(criticalPressurePropylene, pressure);
reducedTemperaturePropylene = Reduced.getReducedPressure(criticalTemperaturePropylene, temperature);

accentricities = zeros(2,2);

accentricities(1,1) = accentricityFactorEthylene;
accentricities(1,2) = (accentricityFactorEthylene + accentricityFactorPropylene) / 2;
accentricities(2,1) = (accentricityFactorEthylene + accentricityFactorPropylene) / 2;
accentricities(2,2) = accentricityFactorPropylene;

criticalTemperatures = zeros(2,2);
criticalTemperatures(1,1) = criticalTemperatureEthylene;
criticalTemperatures(1,2) = (criticalTemperatureEthylene * criticalTemperaturePropylene)^(1/2);
criticalTemperatures(2,1) = (criticalTemperatureEthylene * criticalTemperaturePropylene)^(1/2);
criticalTemperatures(2,2) = criticalTemperaturePropylene;

zValues = zeros(2,2);
zValues(1,1) = zCriticalEthylene;
zValues(1,2) = (zCriticalEthylene + zCriticalProylene)*(1/2);
zValues(2,1) = (zCriticalEthylene + zCriticalProylene)*(1/2);
zValues(2,2) = zCriticalProylene;

criticalVolumes= zeros(2,2);
criticalVolumes(1,1) = volumeCriticalEthylene;
criticalVolumes(1,2) = ((volumeCriticalEthylene^(1/3) + volumeCriticalPropylene^(1/3))/2)^(3);
criticalVolumes(2,1) = ((volumeCriticalEthylene^(1/3) + volumeCriticalPropylene^(1/3))/2)^(3);
criticalVolumes(2,2) = volumeCriticalPropylene;

criticalPressures = R.*(zValues .* criticalTemperatures./criticalVolumes);

reducedTemperatures = Reduced.getReducedTemperatures(criticalTemperatures, temperature)
reducedPressures = Reduced.getReducedPressures(criticalPressures, pressure)

bZeroValues = 0.083-(.422./(reducedTemperatures.^(1.6)))
bOneValues = .139-(.172./(reducedTemperatures.^(4.2)))

bValues = (R.*criticalTemperatures./criticalPressures).*(bZeroValues +accentricities.*bOneValues)

delta21 = 2*bValues(2,1) - bValues(2,2) - bValues(1,1);
delta12 = 2*bValues(1,2) - bValues(1,1) - bValues(2,2);

phi1_parta = exp(pressure/(R*temperature)*(bValues(1,1)+(y2^2)*delta12))
phi2_parta = exp(pressure/(R*temperature)*(bValues(2,2)+(y1^2)*delta12))

fugacity1_parta = phi1_parta*y1*pressure
fugacity2_parta = phi2_parta*y2*pressure

%%%%%%% 
disp('part b')
%%%%%%%

phi_partB = exp((reducedPressures./reducedTemperatures).*(bZeroValues+accentricities.*bOneValues));
phi1_partB = phi_partB(1,1)
phi2_partB = phi_partB(2,2)


fugacity1_partb = phi1_partB*y1*pressure
fugacity2_partb = phi2_partB*y2*pressure
