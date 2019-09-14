classdef TemperatureUnitConversions
    %TEMPERATUREUNITCONVERSIONS 
    %   Detailed explanation goes here
    methods(Static = true)
        function kelvinTemperature = convertCelciusToKelvin(celciusTemperature)
            %convertCelciusToKelvin convert celcius to kelvin
            %   Detailed explanation goes here
            kelvinTemperature = celciusTemperature + 273.15;
        end
    end
end

