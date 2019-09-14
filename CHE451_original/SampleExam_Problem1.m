import cubicEos.*
T = 298.15;
P = fzero(@(P)PR(T,P),.031) 
aasdf = 1;
% answer gives P = .9602
P1 = fzero(@(P)PR(T-1,P),1) 
P2 = fzero(@(P)PR(T+1,P),1) 

%exctracted volumes
Vv = 32045;
Vl =  22.5095;

deltaH = T*(Vv-Vl)*(P2-P1)/(2); %bar * cm^3/mol
deltaHByMass = deltaH/18.01528  %bar * cm^3/g
deltaHJoules = deltaHByMass / 10 % bar*cm^3 = 1/10 J

function err = PR(T,P)
    Tc=647.1; % Kelvin
    Pc=220.55; % bars
    w=0.345;
    Tr=T/Tc;
    Pr=P/Pc;
    e=1-sqrt(2);
    sg=1+sqrt(2);
    R=83.14; % bar*cm^3/mol/K
    
    alpha=(1+(0.37464+1.54226*w-0.26992*w^2)*(1-sqrt(Tr)))^2;
    a=0.45724*alpha*R^2*Tc^2/Pc;
    
    b=0.07780*R*Tc/Pc;
    beta=b*P/R/T;, q=a/b/R/T;, Zl=beta;, Zv=1;
    % The loops below are just to facilitate our work. Convergence to a solution is
    % achieved in only a few iterations (it can be done by hand). There is no
    % need to do 1000 loops
    for i=1:10
        Zl=beta+(Zl+e*beta)*(Zl+sg*beta)*(1+beta-Zl)/q/beta;
    end
    
    Zl=beta+(Zl+e*beta)*(Zl+sg*beta)*(1+beta-Zl)/q/beta;
    
    for i=1:10 
        Zv=1+beta-q*beta*(Zv-beta)/(Zv+e*beta)/(Zv+sg*beta);
    end
    Zv=1+beta-q*beta*(Zv-beta)/(Zv+e*beta)/(Zv+sg*beta);
    
    Iv=1/(sg-e)*log((Zv+sg*beta)/(Zv+e*beta));
    Il=1/(sg-e)*log((Zl+sg*beta)/(Zl+e*beta));
    L=Zl-1-log(Zl-beta)-q*Il;
    V=Zv-1-log(Zv-beta)-q*Iv;
    
    err = 1-L/V;
end

