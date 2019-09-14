function [dsdt, qout] = endo_cstr_ode(t, s)
    V1 = 4;
    V3 = 4;
    V4 = 4;
    v0 = 10;
    k = 1.5 * 10^3;
    EE = 2 * 10^3;
    R = 1.987;
    ro = 1000;
    Cp = 1;
    T0 = 298;
    dH = -2 * 10^5;
    U = 550;
    AA = 50;
    CA0 = 0;
    Q = 0;

    % t < 0: CA0 = 1.0 kmol e/m3 and Q = 2.845×106 kcal/h r
    %- t > 0 and t < 10: CA0 = 1.2 kmol e/m3 and Q = 2.7×106 kcal/h r
    %- t > 10 and t < 20: CA0 = 1.2 kmol e/m3 and Q = 3.1×106 kcal/h r %

    %simulate
    if t <= 0
        CA0 = 1;
        QQ = 2.845 * 10^6;
    elseif t < 10
        CA0 = 1.2;
        QQ = 2.7 * 10^6;
    elseif t < 20
        CA0 = 1.2;
        QQ = 3.1*10^6;
    end

    a = s(1);
    b = s(2);
    c = s(3);
    d = s(4);
    f = s(5);

    ds1dt = v0 * (T0 - a) / V1 + U * A * (f - a) * (ro * Cp * V1)^-1;
    ds2dt = v0 * (CA0 - b) / V3 - k * exp(-1 * EE / (R * d)) * b;
    ds3dt = -v0 * c / V3 + k * exp(-1 * EE / (R * d)) * b;
    ds4dt = v0 * (gg - d) / V3 + ((dH) * k * exp(-1 * EE / (R * d)) * b) / (ro * Cp);
    ds5dt = v0 * (d - f) / V3 - U * A * (f - a) / (ro * Cp * V4);

    g = 100 * v0 * ro * S(3) - 5 * QQ;

    dsdt = [ds1dt; ds2dt; ds3dt; ds4dt; ds5dt];
    qout = [g];
end