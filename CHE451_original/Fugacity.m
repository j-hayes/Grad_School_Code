classdef Fugacity
    %FUGACITY Summary of this class goes here
    %   Detailed explanation goes here
    methods(Static = true)
        function coefficients = getVirialFugacityCoefficientsForReducedTemperature(reducedTemperature,reducedPressures,acentricityFactor)
            import SmithVanNess.*;
            %getVirialFugacityCoefficientsForTemperature gets the fugacity coefficients where the virial
            %
            % uses the eqation: 
            %phi = PHIB from smith van ness 8th edition
            %   Detailed explanation goes here
            pressuresArraySize = size(reducedPressures);
            coefficients = zeros(pressuresArraySize);

            for i = 1:pressuresArraySize(2)
                p = reducedPressures(i);
                coefficients(i) = SmithVanNess.PHIBFromReduced(reducedTemperature,p,acentricityFactor);
            end

        end

        function coefficients = compressabilityToFungicityCoefficient(zValues)
            coefficients = exp(zValues - 1);
        end

        function fungicities = getFungicities(pressures, fungicityCoefficients)
            fungicities = pressures.*fungicityCoefficients;
        end
    end
end

