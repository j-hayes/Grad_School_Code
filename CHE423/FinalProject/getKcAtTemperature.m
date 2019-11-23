function Kc = getKcAtTemperature(T0, T, Kc0, dHrx, R)
    Kc = Kc0*exp((dHrx/R)*((1/T0)-(1/T)));
end 