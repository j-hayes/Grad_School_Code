clear all;
inchToMeter = 0.0254;
D1 = 1*inchToMeter;%m
D2 = 1.333*inchToMeter;%m 1 INCH SCEDULE 40 PIPE
D3 = 2*inchToMeter;
D4 = 2.154*inchToMeter; %SURROUNDED BY 2 INCH SHEDULE 40 PIPE;
L = 3;%m

V_PFR_inner = L*pi*D1^2/4;
V_PFR_outer = L*pi*D2^2/4;
V_Jacket = (L*pi*D1^2/4) - V_PFR_outer;
r = (D1/2);
R = D1 + 2*(D4-D1) + .1; % inner pipe + everything else + small gap for airflow
VCSTR = (pi*(r^2)*(2*pi*R))/2;%volume of torus/2 

a = D2/D2^2;%m^2

U = 127; %W/m^2 *K
Ua = U*a;% (J/m^3 s K)

X0 = 0;
Ca0 = 1000; % mol/m^3
Cb0 = Ca0;
volumetricFlowRateFeed = .35;%m^3/s
Fa0 = Ca0*volumetricFlowRateFeed;
Cps = 30;%cal/m
mDotCp = .1; % mol/s
specificHeatCoolant = 1.685;%KJ/kg;
molecularWeightCoolant = 190;%g/mol
calPerkJ = (1/.004184);
gramPerKg =  (1/1000);
Cpcool = specificHeatCoolant*gramPerKg*molecularWeightCoolant*calPerkJ;

T0_k = 300; %  Kelvin initial temperature for the k1 &pass this in as a parameter 
T0_Kc = 450; % Kelvin initial temperature for the Kc1 &pass this in as a parameter
T0 = 273.15 + 30;
Ta0 = 273.15 + 20;
k0 = .01;
Kc0 = 10;
dHrxn = 6000;
E = 10000;
R = 1.987;%cal/(mol*K)
VSpan = 0:(V_PFR_inner/100):V_PFR_inner; 

params = [Ca0 ; Cb0 ; volumetricFlowRateFeed; Fa0; Cps; Ua; mDotCp ; Cpcool; T0_k ; T0_Kc ; k0; Kc0; dHrxn ; E ;R];
[VOut_1,Output_PFR1]=ode45(@(V,X)ODE_CoCurrentPFR(V,X,params),VSpan,[X0;T0;Ta0]);

X_PFR1 = Output_PFR1(:,1);
T_PFR1 = Output_PFR1(:,2);
Ta_PFR1 = Output_PFR1(:,3);

X2 = X_PFR1(101);
T2 = T_PFR1(101);
Ta2 = Ta_PFR1(101);

V_SolveForXCSTR = 0;
Ca2 = Ca0*(1-X2);
X3_iterator = X2; 
Fa2 = Fa0*(1-X2);
Fc2 = Fa0*X2;
ThetaC_CSTR = (Fc2)/(Fa2);
foundCSTRSolution = 0;
%numerical guess and check for T3 and X3 in CSTR

minError = 10000;
while X3_iterator < 1 
    T3 = T2 + (dHrxn*X3_iterator)/Cps;

    Ca_CSTR = Ca2*(1-X3_iterator);
    Cb_CSTR = Ca_CSTR;
    Cc_CSTR = Ca2*(ThetaC_CSTR+X3_iterator);

    k_CSTR = getkAtTemperature(T0_k, T3, k0, E, R);

    Kc_CSTR  = getKcAtTemperature(T0_Kc, T3, Kc0, dHrxn, R);

    ra = -k_CSTR*((Ca_CSTR*Cb_CSTR)-(Cc_CSTR/Kc_CSTR));
    V_SolveForXCSTR = (Fa2*(X3_iterator-X2))/(-ra);
    
    V_error_CSTR = abs((VCSTR - V_SolveForXCSTR)/VCSTR);
    if V_error_CSTR < .01
        foundCSTRSolution = true;
        break;
    end    
    X3_iterator = X3_iterator + .0001;
end

if foundCSTRSolution ~= 1 
    error('no solution to the CSTR found');
end
X3 = X3_iterator;
Ca3 = Ca0*(1-X3);
Cb3 = Ca3;
Fa3 = Fa0*(1-X3);
Ta3 = Ta2;


params = [Ca3 ; Cb3 ; volumetricFlowRateFeed; Fa3; Cps; Ua; mDotCp ; Cpcool; T0_k ; T0_Kc ; k0; Kc0; dHrxn ; E ;R];
[VOut_2,Output_PFR2]=ode45(@(V,X)ODE_CoCurrentPFR(V,X,params),VSpan,[X3;T3;Ta3]);


X_PFR2 = Output_PFR2(:,1);
T_PFR2 = Output_PFR2(:,2);
Ta_PFR2 = Output_PFR2(:,3);

X4 = X_PFR2(101);
T4 = T_PFR2(101);
Ta4 = Ta_PFR2(101);

subplot(4,1,1);
plot(VSpan, X_PFR1);
xlabel('Volume');
ylabel('conversion');
title('conversion pfr1 cocurrent');

subplot(4,1,2);
plot(VSpan, T_PFR1, VSpan, Ta_PFR1);
xlabel('Volume');
ylabel('Temperature');
legend('T','Ta');
title('temperature pfr1 cocurrent');

subplot(4,1,3);
plot(VSpan, X_PFR2);
xlabel('Volume');
ylabel('conversion');
title('conversion pfr2 cocurrent');

subplot(4,1,4);
plot(VSpan, T_PFR2, VSpan, Ta_PFR2);
xlabel('Volume');
ylabel('Temperature');
legend('T','Ta')
title('temperature pfr2 cocurrent');