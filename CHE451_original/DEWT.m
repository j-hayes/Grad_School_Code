% input variables
P=6;  % atm
y=[0.1;0.55;0.35];

% Other constants that are needed
R=82.06; % atm*cm^3/mol/K
A=[9.2033; 12.2786; 9.1690];  % Antoine's equation constants
B=[2697.55; 3803.08; 2731];   % P will  be in atmospheres
C=[48.78; 41.68; 47.11];      % and T in K
Tc = [507.6; 513.9; 508.2]; % critical temps
Pc = [29.85; 60.68; 46.40]; % critical pressures
w = [0.310; 0.645; 0.307];  % acentric factors
a=[0 300 700
  300 0 -150
700 -150 0]; % a(i,j) for Wilson's equation
V= [75; 20; 80]; % cm^3/mol
phi=[1;1;1];
g=[1;1;1];
% Calculate Tsats
Tsat=B./(A-log(P))-C;
% Estimate T based on Tsat's
T = Tsat'*y; % weighted average temperature (using vector multiplication
             % but it can be done as y(1)*Tsat(1) + y(2)*Tsat(2)+....
% First estimate of Psat
Psat = exp(A-B./(T-C));
% Let the arbitrarily select Pjsat be Psat(1)
% but it could be any other (2 or 3 for example)
PJSAT = P*sum(y.*phi./g.*Psat(1)./Psat); % Eqn 14.14
T = B(1)/(A(1)-log(PJSAT))-C(1); % Eqn 14.12
Psat = exp(A-B./(T-C)); % evaluate Psat with the updated value of T
[BB d]=virial(T, Tc, Pc, w); % new virial coefficients and deltas

%calculation of PHIs
for i=1:3
    %  double summation from eq'n 14.4
    s = 0;
    for j=1:3
        for k=1:3
        s=s+y(j)*y(k)*(2*d(j,i)-d(j,k));
        end
    end
    phi(i) = exp(P/R/T*(BB(i,i)+1/2*s));
end
% Calculate {x's}
x=y.*phi.*P./g./Psat; % Equation 14.9
% Evaluate activity coefficients
g=wilson(x, a, V, R*T); % input the expression for activity coefficients as a function
% of temperature and liquid phase composition (e.g. Wilson eq'n)
% evaluate PJSAT again with updated values
PJSAT = P*sum(y.*phi./g.*Psat(1)./Psat);
% evaluate a new value for T
T = B(1)/(A(1)-log(PJSAT))-C(1); % Equation 14.15

% begins second block of Figure 14.4
err1=1; % initialize the error value with a large number so that the
       % algorithm can do more than one iteration
while err1 > 1e-3 % tolerance value for the errors, err1 is epsilon in Fig 14.4
    Psat = exp(A-B./(T-C)); % evaluate Psat with the updated value of T
    [BB d]=virial(T, Tc, Pc, w); % new virial coefficients and deltas
    for i=1:3
    %  double summation from eq'n 14.4
    s = 0;
    for j=1:3
        for k=1:3
        s=s+y(j)*y(k)*(2*d(j,i)-d(j,k));
        end
    end
    phi(i) = exp(P/R/T*(BB(i,i)+1/2*s));
    end
    
% Beginning of third block in Fig 14.4
err2=1; % initiate with a large error so the while-end loop does more 
        % than one iteration
while err2 > 1e-3
    x=y.*phi.*P./g./Psat;
    x=x./sum(x); % normalize {x's}
    % new values of activity coefficients
    gnew=wilson(x, a, V, R*T);  % input the expression for activity coefficients as a function
% of temperature and liquid phase composition (e.g. Wilson eq'n)
err2 = max(abs(1-gnew./g));
    % check the max. error among all the gamma values
                          % this is in the fourth block
g=gnew; % new gammas become old gammas
end % if the difference between new and old gammas is small 
    % the loop ends here (block "Is each delta gamma_i < chi?
% begins fifth block
PJSAT = P*sum(y.*phi./g.*Psat(1)./Psat); % equation 14.14
Tnew = B(1)/(A(1)-log(PJSAT))-C(1);
err1=max(abs(1-Tnew/T)); % sixth block
T=Tnew;
end
T,x

