function Scenario3(scenarioParams, figureNumber)
%counter current pfr followed by adiabatic CSTR followed by a counter current pfr
%inital temp of each jacket is the same temperature (the coolant feed is
%split in two and enters the two jackets independently
params = [scenarioParams.Ca0; ...
    scenarioParams.Cb0;...
    scenarioParams.volumetricFlowRateFeed;...
    scenarioParams.Fa0; ...
    scenarioParams.Cps;...
    scenarioParams.Ua; ...
    scenarioParams.mDotCp; ...
    scenarioParams.Cpcool; ...
    scenarioParams.T0_k ; ...
    scenarioParams.T0_Kc ;...
    scenarioParams.k0;...
    scenarioParams.Kc0; ...
    scenarioParams.dHrxn ;...
    scenarioParams.E;...
    scenarioParams.R; ...
    true
    ];


Output_PFR1 = SolveCounterCurrentPFR(scenarioParams, ...
            params, ...
            scenarioParams.Ta0,...
            scenarioParams.T0,...
            scenarioParams.X0);


X_PFR1 = Output_PFR1(:,1);
T_PFR1 = Output_PFR1(:,2);
Ta_PFR1 = Output_PFR1(:,3);

X2 = X_PFR1(end);
T2 = T_PFR1(end);

[T3, X3] = AdiabaticCSTR(scenarioParams, X2,T2);%numerical guess and check for T3 and X3 in CSTR

Ca3 = scenarioParams.Ca0*(1-X3);
Cb3 = Ca3;
Fa3 = scenarioParams.Fa0*(1-X3);
Ta4 = scenarioParams.Ta0; %outlet of jacket goes to inlet of other countercurrent jacket

params = [Ca3 ;
    Cb3 ;  ...
    scenarioParams.volumetricFlowRateFeed; ...
    Fa3;...
    scenarioParams.Cps;...
    scenarioParams.Ua; ...
    scenarioParams.mDotCp ;...
    scenarioParams.Cpcool; ...
    scenarioParams.T0_k ;...
    scenarioParams.T0_Kc ;...
    scenarioParams.k0;...
    scenarioParams.Kc0; ...
    scenarioParams.dHrxn ;...
    scenarioParams.E;...
    scenarioParams.R; ...
    true
    ];
Output_PFR2 = SolveCounterCurrentPFR(scenarioParams, ...
    params, ... 
    Ta4, ...
    T3, ...
    X3);


X_PFR2 = Output_PFR2(:,1);
T_PFR2 = Output_PFR2(:,2);
Ta_PFR2 = Output_PFR2(:,3);

X4 = X_PFR2(end);
T4 = T_PFR2(end);
Ta4 = Ta_PFR2(end);


figure(figureNumber);
subplot(4,1,1);
plot(scenarioParams.VSpan, X_PFR1);
xlabel('Volume');
ylabel('conversion');
title('conversion pfr1 counter current');

subplot(4,1,2);
plot(scenarioParams.VSpan, T_PFR1, scenarioParams.VSpan, Ta_PFR1);
xlabel('Volume');
ylabel('Temperature');
legend('T','Ta');
title('temperature pfr1 counter current');

subplot(4,1,3);
plot(scenarioParams.VSpan, X_PFR2);
xlabel('Volume');
ylabel('conversion');
title('conversion pfr2 counter current');

subplot(4,1,4);
plot(scenarioParams.VSpan, T_PFR2, scenarioParams.VSpan, Ta_PFR2);
xlabel('Volume');
ylabel('Temperature');
legend('T','Ta')
title('temperature counter current');

end