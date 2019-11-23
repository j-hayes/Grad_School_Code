
function k = getkAtTemperature(T0, T, k0, E, R)
    k = k0*exp((E/R)*((1/T0)-(1/T)));
end 
