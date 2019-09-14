classdef SmithVanNess
    %SMITHVANNESS functions provided by the authors of smith van ness
    %textbook http://highered.mheducation.com/sites/1259696529/student_view0/matlab.html
    methods(Static = true)

        function HRB = HRB(T, P, Tc, Pc, omega)
            %function HRB = HRB(T,P,Tc,Pc,omega)
            %   This function employs the Pitzer correlation for the second virial
            %   coefficient to evaluate the residual enthalpy at temperature T (K) and
            %   pressure P (bar), for a substance with critical temperature Tc (K),
            %   critical pressure Pc (bar), and acentric factor omega. It returns the
            %   dimensionless value of residual enthalpy divided by RTc.
            Tr = T / Tc;
            Pr = P / Pc;
            B0 = 0.083 - 0.422 / Tr^1.6;
            B1 = 0.139 - 0.172 / Tr^4.2;
            dB0dTr = 0.675 / Tr^2.6;
            dB1dTr = 0.722 / Tr^5.2;
            HRB = Pr * (B0 - Tr * dB0dTr + omega * (B1 - Tr * dB1dTr));
        end

        function ICPH = ICPH(T0, T, A, B, C, D)
            %ICPH = ICPH(T0,T,A,B,C,D)
            %   Returns the integral of Cp/R over the interval from T0 to T, when the
            %   heat capacity Cp is expressed as a polynomial in temperature, given by
            %   Cp/R = A + B*T + C*T^2 + D*T^-2
            ICPH = A * (T - T0) + B / 2 * (T^2 - T0^2) + C / 3 * (T^3 - T0^3) - D * (1 / T - 1 / T0);
        end

        function ICPS = ICPS(T0, T, A, B, C, D)
            %ICPS = ICPS(T0,T,A,B,C,D)
            %   Returns the integral of Cp/(RT) over the interval from T0 to T, when
            %   the heat capacity Cp is expressed as a polynomial in temperature,
            %   given by Cp/R = A + B*T + C*T^2 + D*T^-2
            ICPS = A * log(T / T0) + B * (T - T0) + (C + D / (T^2 * T0^2)) * (T^2 - T0^2) / 2;
        end

        function IDCPH = IDCPH(T0, T, DA, DB, DC, DD)
            %ICPH = IDCPH(T0,T,DA,DB,DC,DD)
            %   Returns the integral of deltaCp/R over the interval from T0 to T, when
            %   the heat capacity difference deltaCp is expressed as a polynomial in
            %   temperature, given by deltaCp/R = DA + DB*T + DC*T^2 + DD*T^-2
            IDCPH = DA * (T - T0) + DB / 2 * (T^2 - T0^2) + DC / 3 * (T^3 - T0^3) - DD * (1 / T - 1 / T0);
        end

        function IDCPS = IDCPS(T0, T, DA, DB, DC, DD)
            %IDCPS = IDCPS(T0,T,DA,DB,DC,DD)
            %   Returns the integral of deltaCp/(RT) over the interval from T0 to T,
            %   when the heat capacity difference deltaCp is expressed as a polynomial
            %   in temperature, given by deltaCp/R = DA + DB*T + DC*T^2 + DD*T^-2
            IDCPS = DA * log(T / T0) + DB * (T - T0) + (DC + DD / (T^2 * T0^2)) * (T^2 - T0^2) / 2;
        end

        function MCPH = MCPH(T0, T, A, B, C, D)
            %MCPH = MCPH(T0,T,A,B,C,D)
            %   Returns the average value of Cp/R over the interval from T0 to T, when
            %   the heat capacity Cp is expressed as a polynomial in temperature,
            %   given by Cp/R = A + B*T + C*T^2 + D*T^-2
            MCPH = A + B / 2 * (T + T0) + C / 3 * (T^2 + T * T0 + T0^2) + D / (T * T0);
        end

        function MCPS = MCPS(T0, T, A, B, C, D)
            %MCPS = MCPS(T0,T,A,B,C,D)
            %   Returns the mean value of Cp/R over the interval from T0 to T, for use
            %   in entropy calculations. This mean is defined as the integral of
            %   Cp/(RT) over this interval, divided by ln(T/T0). As usual, the
            %   heat capacity Cp is expressed as a polynomial in temperature, given by
            %   Cp/R = A + B*T + C*T^2 + D*T^-2
            MCPS = A + (B * T0 + (C * T0^2 + D / T^2) * (T + T0) / (2 * T0)) * (T - T0) / T0 / log(T / T0);
        end

        function MDCPH = MDCPH(T0, T, DA, DB, DC, DD)
            %MDCPH = MDCPH(T0,T,DA,DB,DC,DD)
            %   Returns the average value of deltaCp/R over the interval from T0 to T,
            %   when the heat capacity difference deltaCp is expressed as a polynomial
            %   in temperature, given by deltaCp/R = DA + DB*T + DC*T^2 + DD*T^-2
            MDCPH = DA + DB / 2 * (T + T0) + DC / 3 * (T^2 + T * T0 + T0^2) + DD / (T * T0);
        end

        function MDCPS = MDCPS(T0, T, DA, DB, DC, DD)
            %MDCPS = MDCPS(T0,T,DA,DB,DC,DD)
            %   Returns the mean value of deltaCp/R over the interval from T0 to T,
            %   for use in entropy calculations. This mean is defined as the integral
            %   of deltaCp/(RT) over this interval, divided by ln(T/T0). As usual, the
            %   heat capacity difference deltaCp is expressed as a polynomial in
            %   temperature, given by deltaCp/R = DA + DB*T + DC*T^2 + DD*T^-2
            MDCPS = DA + (DB * T0 + (DC * T0^2 + DD / T^2) * (T + T0) / (2 * T0)) * (T - T0) / T0 / log(T / T0);
        end

        function PHIB_binary = PHIB_binary(T, P, y1, Tc, Pc, Vc, Zc, omega, k12)
            %function PHIB_binary = PHIB_binary(T,P,x1,Tc,Pc,Vc,Zc,omega,k12)
            %   This function employs the Pitzer correlation for the second virial
            %   coefficient to evaluate the fugacity coefficients at temperature T and
            %   pressure P, for a binary mixture with species 1 mole fraction y1.
            %   The critical temperature Tc (K), critical pressure Pc (bar), critical
            %   volume, Vc (cm3/mol), critical compressibility, Zc, and acentric
            %   factor, omega should be column vectors of two elements each.
            %   k12 is the binary interaction parameter. The function returns the
            %   dimensionless fugacity coefficient in a 2 element column vector.
            R = 83.145;
            Tc = [Tc; sqrt(Tc(1) * Tc(2)) * (1 - k12)];
            omega = [omega; (omega(1) + omega(2)) / 2];
            Zc = [Zc; (Zc(1) + Zc(2)) / 2];
            Vc = [Vc; ((Vc(1)^(1/3) + Vc(2)^(1/3)) / 2)^3];
            Pc = [Pc; Zc(3) * R * Tc(3) / Vc(3)];
            Tr = T ./ Tc;
            Pr = P ./ Pc;
            B0 = 0.083 - 0.422 ./ Tr.^1.6;
            B1 = 0.139 - 0.172 ./ Tr.^4.2;
            B = R * Tc ./ Pc .* (B0 + omega .* B1);
            del = 2 * B(3) - B(1) - B(2);
            PHIB_binary = exp(P / (R * T) * (B(1:2) + [(1 - y1)^2; y1^2] * del));
        end

        function PHIB = PHIB(T, P, Tc, Pc, omega)
            %function PHIB = PHIB(T,P,Tc,Pc,omega)
            %   This function employs the Pitzer correlation for the second virial
            %   coefficient to evaluate the fugacity coefficient at temperature T (K)
            %   and pressure P (bar), for a substance with critical temperature Tc (K),
            %   critical pressure Pc (bar), and acentric factor omega. It returns the
            %   dimensionless fugacity coefficient.
            Tr = T / Tc;
            Pr = P / Pc;
            B0 = 0.083 - 0.422 / Tr^1.6;
            B1 = 0.139 - 0.172 / Tr^4.2;
            PHIB = exp(Pr / Tr * (B0 + omega * B1));
        end
        
         function PHIB = PHIBFromReduced(Tr, Pr, omega)
            %function PHIB = PHIB(T,P,Tc,Pc,omega)
            %   This function employs the Pitzer correlation for the second virial
            %   coefficient to evaluate the fugacity coefficient at temperature T (K)
            %   and pressure P (bar), for a substance with critical temperature Tc (K),
            %   critical pressure Pc (bar), and acentric factor omega. It returns the
            %   dimensionless fugacity coefficient.       
            B0 = 0.083 - 0.422 / Tr^1.6;
            B1 = 0.139 - 0.172 / Tr^4.2;
            PHIB = exp(Pr / Tr * (B0 + omega * B1));
        end

        function SRB = SRB(T,P,Tc,Pc,omega)
%function SRB = SRB(T,P,Tc,Pc,omega)
%   This function employs the Pitzer correlation for the second virial
%   coefficient to evaluate the residual entropy at temperature T and
%   pressure P, for a substance with critical temperature Tc, critical
%   pressure Pc, and acentric factor omega. It returns the dimensionless
%   value of residual entropy divided by R.
Tr=T/Tc;
Pr=P/Pc;
dB0dTr=0.675/Tr^2.6;
dB1dTr=0.722/Tr^5.2;
SRB=-Pr*(dB0dTr+omega*dB1dTr);
end
    end

    
end
