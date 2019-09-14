import cubicEos.*
T = 298.15;
Tc=647.1; % Kelvin
Pc=220.55; % bars
w=0.345;
R=83.14; % bar*cm^3/mol/K

deltaHVapSteamTable = 2547.3-104.8;%KJ/Kg
specificVolumeSteamTableLiquid = 1.003;%cm^3/g
specificVolumeSteamTableVapor = 43400;%cm^3/g


%Part B
pressureInitiialGuess = 0.031;
pengRobinson = cubicEos(R,T,pressureInitiialGuess,Tc,Pc,w,'peng robinson');
pengRobinsonPsat = fzero(@(pengRobinsonPsat) pengRobinson.calculateVaporPressureError(pengRobinsonPsat),pressureInitiialGuess);

pengRobinsonDetlaT1 = cubicEos(R,T-1,pressureInitiialGuess,Tc,Pc,w,'peng robinson');
pengRobinsonPSat1 = fzero(@(pengRobinsonPSat1) pengRobinsonDetlaT1.calculateVaporPressureError(pengRobinsonPSat1),pressureInitiialGuess);
pengRobinsonDetlaT2 = cubicEos(R,T+1,pressureInitiialGuess,Tc,Pc,w,'peng robinson');
pengRobinsonPSat2 = fzero(@(pengRobinsonPSat2) pengRobinsonDetlaT2.calculateVaporPressureError(pengRobinsonPSat2),pressureInitiialGuess);

deltaHPengRobinson = T*(pengRobinson.Vv-pengRobinson.Vl)*(pengRobinsonPSat2-pengRobinsonPSat1)/(2); %bar * cm^3/mol
deltaHByMassPengRobinson = deltaHPengRobinson/18.01528;  %bar * cm^3/g
deltaHKiloJoulesPerKiloGramPengRobinson = deltaHByMassPengRobinson * 0.1; % bar*cm^3/g = 1/10 kJ/kg 

%part c for peng robinson
errorEnthalpyPengRobinson = 1-deltaHKiloJoulesPerKiloGramPengRobinson/deltaHVapSteamTable
errorVolumeVaporPengRobinson = 1-pengRobinson.Vv/18.01528/specificVolumeSteamTableVapor
errorVolumeLiquidPengRobinson = 1-pengRobinson.Vl/18.01528/specificVolumeSteamTableLiquid


%sanity check with SRK to check generic functionality because van der waals
%is not converging to an answer
pressureInitiialGuess = 0.031;
SRK = cubicEos(R,T,pressureInitiialGuess,Tc,Pc,w,'SRK');
SRKPsat = fzero(@(SRKPsat) SRK.calculateVaporPressureError(SRKPsat),pressureInitiialGuess);

SRKDetlaT1 = cubicEos(R,T-1,pressureInitiialGuess,Tc,Pc,w,'peng robinson');
SRKPSat1 = fzero(@(SRKPSat1) SRKDetlaT1.calculateVaporPressureError(SRKPSat1),pressureInitiialGuess);
SRKDetlaT2 = cubicEos(R,T+1,pressureInitiialGuess,Tc,Pc,w,'peng robinson');
SRKPSat2 = fzero(@(SRKPSat2) SRKDetlaT2.calculateVaporPressureError(SRKPSat2),pressureInitiialGuess);

deltaHSRK = T*(SRK.Vv-SRK.Vl)*(SRKPSat2-SRKPSat1)/(2); %bar * cm^3/mol
deltaHByMassSRK = deltaHSRK/18.01528;  %bar * cm^3/g
deltaHKiloJoulesPerKiloGramSRK = deltaHByMassSRK * 0.1; % bar*cm^3/g = 1/10 kJ/kg 

errorEnthalpySRK = 1-deltaHKiloJoulesPerKiloGramSRK/deltaHVapSteamTable
errorVolumeVaporSRK = 1-SRK.Vv/18.01528/specificVolumeSteamTableVapor
errorVolumeLiquidSRK = 1-SRK.Vl/18.01528/specificVolumeSteamTableLiquid




pressureInitiialGuess = 0.031;

%part A
vanDerWaals = cubicEos(R,T,pressureInitiialGuess,Tc,Pc,w,'van der waals');

vanDerWaalsPsat = fzero(@(vanDerWaalsPsat) vanDerWaals.calculateVaporPressureError(vanDerWaalsPsat),pressureInitiialGuess);

vanDerWaalsDeltaT1 = cubicEos(R,T-1,pressureInitiialGuess,Tc,Pc,w,'van der waals');
vanDerWaalsPSat1 = fzero(@(vanDerWaalsPSat1) vanDerWaalsDeltaT1.calculateVaporPressureError(vanDerWaalsPSat1),pressureInitiialGuess);
vanDerWaalsDeltaT2 = cubicEos(R,T+1,pressureInitiialGuess,Tc,Pc,w,'van der waals');
vanDerWaalsPSat2 = fzero(@(vanDerWaalsPSat2) vanDerWaalsDeltaT2.calculateVaporPressureError(vanDerWaalsPSat2),pressureInitiialGuess);

deltaHVanDerWaals = T*(vanDerWaals.Vv-vanDerWaals.Vl)*(vanDerWaalsPSat2-vanDerWaalsPSat1)/(2); %bar * cm^3/mol
deltaHByMassVanDerWaals = deltaHVanDerWaals/18.01528;  %bar * cm^3/g
deltaHKiloJoulesPerKiloGramVanDerWaals = deltaHByMassVanDerWaals * 0.1; % bar*cm^3/g = 1/10 kJ/kg 

%part c for van der waals
errorEnthalpyVanDerWaals = 1-deltaHKiloJoulesPerKiloGramVanDerWaals/deltaHVapSteamTable
errorVolumeVaporVanDerWaals = 1-vanDerWaals.Vv/18.01528/specificVolumeSteamTableVapor
errorVolumeLiquidVanDerWaals = 1-vanDerWaals.Vl/18.01528/specificVolumeSteamTableLiquid
