function F =  root2(x)
velocity = x(1);
pressureDrop = 68947.6;
viscosity = (1.04*10^-3);
radius = .0125;
length = 20;
density = 795;

renoldsNumber = ((velocity * 2 *radius * density)/viscosity); %renolds number and velocity relationship
frictionFactor = .0791/(renoldsNumber^.25);
%pressure drop related to renolds, friction factor and velocity;
pressureDropCalculated = ((length *frictionFactor * viscosity * velocity * renoldsNumber)/(2 *(radius^2)))

error =  pressureDrop - pressureDropCalculated

F(1) = error; %function that should return 0 or near zero when the equation is solved