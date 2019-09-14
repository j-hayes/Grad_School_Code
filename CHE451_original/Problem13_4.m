%find 0
fun = @dGdE;
min_x = fzero(fun,.4)
gibbsFreeEnergies = zeros(20);

extentsOfReation = linspace(0,1,20);
for i = 1:20
    gibbsFreeEnergies(i) = GibsFreeEnergy(extentsOfReation(i));
end

gibbsFreeEnergyAtMin = GibsFreeEnergy(min_x);

plot(extentsOfReation,gibbsFreeEnergies);hold on;
plot(min_x,gibbsFreeEnergyAtMin,'r*');
function value = dGdE(extentOfReaction)
R = 8.314;
T = 1000;
value = 1565 + (R*T/2)*(2*(extentOfReaction/(extentOfReaction-1 + log((1-extentOfReaction)/2) + 1 + log(extentOfReaction/2))));
end

function value = GibsFreeEnergy(extentOfReaction)
R = 8.314;
T = 1000;

a = (1-extentOfReaction)/2;
b = (extentOfReaction/2);

value = a*(-395790)+ b*(-192400)+ b*(-200240) + R*T*(2*(a*log(a))+2*b*log(b));R*T
end