import Reduced.*;
import TemperatureUnitConversions.*;

temperature = TemperatureUnitConversions.convertCelciusToKelvin(150);
criticalTemperatureCO2 = 304.2;%Kelvin 
criticalPressureCO2 = 73.83;%bar
acentricityFactorCO2 = .224;
pressures = [10 20 40 60 80 100 200 300 400 500];%bar
compressabilityDataZValues =   [.985 .970 .942 .913 .885 .869 .765 .762 .824 .910];

phiFromCompressabilityData = Fugacity.compressabilityToFungicityCoefficient(compressabilityDataZValues);
fugacitiesFromCompressability = Fugacity.getFungicities(pressures,phiFromCompressabilityData);

reducedPressuresCO2 = Reduced.getReducedPressures(criticalPressureCO2, pressures);
reducedTemperatureCO2 = Reduced.getReducedTemperature(criticalTemperatureCO2, temperature);

fugacityCoefficientsFromVirialEquation = Fugacity.getVirialFugacityCoefficientsForReducedTemperature(reducedTemperatureCO2,reducedPressuresCO2,acentricityFactorCO2)
fungicityFromVirialEquation = Fugacity.getFungicities(pressures,fugacityCoefficientsFromVirialEquation);

subplot(2,1,1)
plot(pressures, fungicityFromVirialEquation,pressures,fugacitiesFromCompressability );
legend('virial equation','compressability')
xlabel('Pressure')
ylabel('Fugacity')

subplot(2,1,2)
plot(pressures, fugacityCoefficientsFromVirialEquation,pressures,phiFromCompressabilityData );
legend('virial equation','compressability')
xlabel('Pressure')
ylabel('Fugacity Coefficient')
