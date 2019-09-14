import SmithVanNess.*;

pressure = 1.0133% 1atm => bar

func = @dGdE;
Temp = fzero(func,300);

function difference = getKDifference(kSought,T,deltaA,deltaB,deltaC,deltaD)
R = 8.314;
T0 = 
difference = deltaGibsFreeEnergy(deltaG0,deltaH0,T0,T,deltaA,deltaB,deltaC,deltaD,R) - K

end

function value = deltaGibsFreeEnergy(deltaG0,deltaH0,T0,T,deltaA,deltaB,deltaC,deltaD,R)
%eq 13.18
value = (deltaG0 - ddeltaH0)/(R*T0);
value = value + deltaH0/(R*T);
value = value + 1/T*SmithVanNess.IDCPH(T0,T,deltaA,deltaB,deltaC,deltaD)
value = value -  SmithVanNess.IDCPS(T0,T,deltaA,deltaB,deltaC,deltaD);
end