function Scenario2(scenarioParams)
%co-current pfr followed by adiabatic CSTR followed by a counter current pfr
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
    false
    ];

[VOut_1,Output_PFR1]=ode45(@(V,X)ODE_PFR(V,X,params), ...
scenarioParams.VSpan,[scenarioParams.X0;scenarioParams.T0;scenarioParams.Ta0]);

X_PFR1 = Output_PFR1(:,1);
T_PFR1 = Output_PFR1(:,2);
Ta_PFR1 = Output_PFR1(:,3);

X2 = X_PFR1(101);
T2 = T_PFR1(101);
Ta2 = Ta_PFR1(101);

[T3, X3] = AdiabaticCSTR(scenarioParams, X2,T2);%numerical guess and check for T3 and X3 in CSTR

Ca3 = scenarioParams.Ca0*(1-X3);
Cb3 = Ca3;
Fa3 = scenarioParams.Fa0*(1-X3);
Ta4 = Ta2; %outlet of jacket goes to inlet of other countercurrent jacket

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

TaError = 1000;
guessTa3 = Ta4+.1;%initial guess of a temp just barely higher than Ta4
while TaError > .01 || isnan(TaError) 

    [VOut_2,Output_PFR2]=ode45(@(V,X)ODE_PFR(V,X,params),scenarioParams.VSpan,[X3;T3;guessTa3]);
    Ta4_fromGuess = Output_PFR2(end,3);
    TaError = abs((Ta4 -Ta4_fromGuess)/Ta4);
    if guessTa3 > 1000
        error('no solution to the PFR2 Scenario 2 found');
    end
    guessTa3 = guessTa3 + .1;
end

X_PFR2 = Output_PFR2(:,1);
T_PFR2 = Output_PFR2(:,2);
Ta_PFR2 = Output_PFR2(:,3);

X4 = X_PFR2(101);
T4 = T_PFR2(101);
Ta4 = Ta_PFR2(101);

subplot(4,1,1);
plot(scenarioParams.VSpan, X_PFR1);
xlabel('Volume');
ylabel('conversion');
title('conversion pfr1 cocurrent');

subplot(4,1,2);
plot(scenarioParams.VSpan, T_PFR1, scenarioParams.VSpan, Ta_PFR1);
xlabel('Volume');
ylabel('Temperature');
legend('T','Ta');
title('temperature pfr1 cocurrent');

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