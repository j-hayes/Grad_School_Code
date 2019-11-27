function [T,X] = AdiabaticCSTR(scenarioParams,Xin, Tin)
%ADIABATICCSTR assumed to be well mixed 
% uses a linearly increasing guess and check to find X and T that match the
% scenario Volume of the CSTR for the given inlet conversion


Ca2 = scenarioParams.Ca0*(1-Xin);
X3_iterator = Xin; 
Fa2 = scenarioParams.Fa0*(1-Xin);
Fc2 = scenarioParams.Fa0*Xin;
ThetaC_CSTR = (Fc2)/(Fa2);
foundCSTRSolution = 0;
%numerical guess and check for T and X3 in CSTR

while X3_iterator < 1 
    T = Tin + (scenarioParams.dHrxn*X3_iterator)/scenarioParams.Cps;

    Ca_CSTR = Ca2*(1-X3_iterator);
    Cb_CSTR = Ca_CSTR;
    Cc_CSTR = Ca2*(ThetaC_CSTR+X3_iterator);

    k_CSTR = getkAtTemperature(scenarioParams.T0_k, T, scenarioParams.k0, scenarioParams.E, scenarioParams.R);

    Kc_CSTR  = getKcAtTemperature(scenarioParams.T0_Kc, T, scenarioParams.Kc0, scenarioParams.dHrxn, scenarioParams.R);

    ra = -k_CSTR*((Ca_CSTR*Cb_CSTR)-(Cc_CSTR/Kc_CSTR));
    Volume = (Fa2*(X3_iterator-Xin))/(-ra);
    
    V_error_CSTR = abs((scenarioParams.VCSTR - Volume)/scenarioParams.VCSTR);
    if V_error_CSTR < .01
        foundCSTRSolution = true;
        break;
    end    
    X3_iterator = X3_iterator + .0001;
end

if foundCSTRSolution ~= 1 
    error('no solution to the CSTR found');
end
X = X3_iterator;
end

