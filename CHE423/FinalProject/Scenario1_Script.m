clear all;
X0 = 0;
Ca0 = 1000; % mol/m^3
Cb0 = Ca0;
volumetricFlowRateFeed = 5;%m^3/s
Fa0 = Ca0*volumetricFlowRateFeed;%params
Cps = 30;%cal/m
Ua = 201.93;% W/K  params
mDotCp = 11.97; % m^3/sparams

specificHeatCoolant = 1.685;
molecularWeightCoolant = 190;%g/mol
calPerKj = (1/.004184);
gramPerKg =  (1/1000);
Cpcool = specificHeatCoolant*gramPerKg*molecularWeightCoolant*calPerKj;

T0_k = 300; %  Kelvin initial temperature for the k1 &pass this in as a parameter 
T0_Kc = 450; % Kelvin initial temperature for the Kc1 &pass this in as a parameter
T0 = 273.15 + 30;
Ta0 = T0;
k0 = .01;
Kc0 = 10;
dHrxn = 6000;
E = 10000;
R = 1.987;%cal/(mol*K)
VSpan = 0:.05:0.0547; % 0.0547 volume of pipe
VCSTR = .1; %m^3

params = [Ca0 ; Cb0 ; volumetricFlowRateFeed; Fa0; Cps; Ua; mDotCp ; Cpcool; T0_k ; T0_Kc ; k0; Kc0; dHrxn ; E ;R];
[VNoInert,Output]=ode45(@(V,X)ODE_CoCurrentPFR(V,X,params),VSpan,[X0;T0;Ta0]);

X2 = Output(53,1);
T2 = Output(53,2);

V_SolveForXCSTR = 0;
X2_iterator = X2; 
%numerical guess and check for T3 and X3 in CSTR
while X2_iterator < 1
    T3 = T2 + (dHrxn*X2)/Cps;
    Ca_pfr1 = Ca0*(1-X_pfr1);
    Cb_pfr1 = Ca_pfr1;
    Cc_pfr1 = Ca0*X_pfr1;

    k_pfr_1 = getkAtTemperature(T0_k, T_pfr1, k0, E, R);
    Kc_pfr_1 = getKcAtTemperature(T0_Kc, T_pfr1, Kc0, dHrxn, R);

ra = -k_pfr_1*((Ca_pfr1*Cb_pfr1)-(Cc_pfr1/Kc_pfr_1));


    k_cstr = getkAtTemperature(T0_k, T3, k0, E, R);
    ra = 
    V_SolveForXCSTR = Fa0*X/(k_cstr*(-ra)) ;

    X2_iterator = X2_iterator + .05; 
end

