classdef Reduced
    %REDUCED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    methods(Static)
        
        
        function reducedPressure = getReducedPressures(criticalPressures,actualPressures)
            %getReducedPressures get the reduced pressures of a list of systems
            %
            reducedPressure = actualPressures./criticalPressures;
        end
        
        function reducedPressure = getReducedPressure(criticalPressure,actualPressure)
            %getReducedPressure get the reduced pressure of a system
            %
            reducedPressure = actualPressure/criticalPressure;
        end
         function reducedTemperature = getReducedTemperature(criticalTemperature,actualTemperature)
            %getReducedTemperature get the reduced pressure of a system
            %
            reducedTemperature = actualTemperature/criticalTemperature;
         end
         function reducedTemperatures = getReducedTemperatures(criticalTemperatures,actualTemperatures)
            %getReducedTemperatures get the reduced pressure of a system
            %
            reducedTemperatures = actualTemperatures./criticalTemperatures;
        end
    end
end

