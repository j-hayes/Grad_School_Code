classdef AntonieEquation
   methods
       function saturationPressure = GetSaturationPressure(obj,A,B,C,temperature)
          saturationPressure = exp( A - (B/(temperature+C)));
       end
        function saturationPressures = GetSaturationPressureFromTemperatures(obj,A,B,C,temperatures)
          saturationPressures = exp( A - (B./(temperatures+C)));
        end
        function boilingPoint = GetBoilingPointForPressure(obj,A,B,C,saturationPressure)
            boilingPoint =  (B/(A-log(saturationPressure)))-C;
        end       
   end
end