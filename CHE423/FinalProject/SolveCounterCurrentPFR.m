function Output_PFR = SolveCounterCurrentPFR(scenarioParams,params,TaIn,Tin,Xin)
%SOLVECOUNTERCURRENTPFR Summary of this function goes here
    TaError = 1000;
    guessTa3 = TaIn+.1;%initial guess of a temp just barely higher than Ta4
    dT = .1;
    while TaError > .05 || isnan(TaError) 

        [VOut_2,Output_PFR]=ode45(@(V,X)ODE_PFR(V,X,params),scenarioParams.VSpan,[Xin;Tin;guessTa3]);
        TaIn_fromGuess = Output_PFR(end,3);
        TaError = abs((TaIn -TaIn_fromGuess)/TaIn);
        
        guessTa3 = guessTa3 + dT;
        if guessTa3 > 1000
            dT = -.1;
            guessTa3 = TaIn-dT;
        elseif guessTa3 < 100
            error('no solution to the counter current PFR found');
        end
        
    end

end

