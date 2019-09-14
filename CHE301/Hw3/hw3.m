temp = 20;%c
length = 402.336;%m
pressureDifference = 1723.689;%Pa
density = 998;%kg/m^3
viscosity = 1.0016*10^-3;%Pa * s
radius = 0.0762; %--m

guessVelocity = 100000; 
renoldsNumber = calculateRenoldsNumber(guessVelocity, radius,viscosity,density);
pressureDifferenceCalculated = calculatePressureDifference(guessVelocity, radius,viscosity,density, length);

calculationError = (pressureDifferenceCalculated / pressureDifference);
result = (calculationError <= 1.01 ) && (calculationError >= .99);

function frictionFactor = calculateFrictionFactor(renoldsNumber)
    frictionFactor = .0791/(renoldsNumber ^0.25);
    
end

function pressureDifference = calculatePressureDifference(velocity, radius,viscosity,density,pipeLength)
renoldsNumber = calculateRenoldsNumber(velocity, radius,viscosity,density);
frictionFactor = calculateFrictionFactor(renoldsNumber);
pressureDifference = (frictionFactor * viscosity * velocity * renoldsNumber * pipeLength) / (2 * (radius^2));

end

function renolds = calculateRenoldsNumber(velocity, radius, viscosity, density)
 if(density == 0)
     error('density cannot be zero')
 end
 
 numerator =2* radius *velocity  *density  ;
 renolds = numerator / viscosity;
end

