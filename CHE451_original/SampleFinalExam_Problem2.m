%DEW P(400, [0.15;0.45;0.4])

T=400;
y=[0.15;0.45;0.4];
R=82.06; % atm*cm^3/mol/K
A=[9.2033; 12.2786; 9.1690];
B=[2697.55; 3803.08; 2731];
C=[48.78; 41.68; 47.11];


gammas=[1;1;1];
phi=[1;1;1];
Psat=exp(A-B./(T-C));

BB=[-1360.1 -657 -1274.2
    -657 -1174.7 -621.8
    -1274.2 -621.8 -1191.9];

d=zeros(3,3);

for i=1:3
    for j=1:3
        d(i,j) = 2*BB(i,j) - BB(i,i) - BB(j,j);
    end
end
 
P=1/(sum(y.*phi./Psat./gammas));
x=y.*phi.*P./gammas./Psat;
gammas=exp([2.45*x(2)*(1-x(1))-1.42*x(3)*(1-x(1))-2.04*x(2)*x(3)
    2.45*x(1)*(1-x(2))-1.42*x(1)*x(3)+2.04*x(3)*(1-x(2))
    -2.45*x(1)*x(2)-1.42*x(1)*(1-x(3))+2.04*x(2)*(1-x(3))]);
P=1/(sum(y.*phi./Psat./gammas));
% P=sum(x.*gammas.*Psat./phi);
err=1;
while err > 1e-6
    for i=1:3
        s=0; %the double summation will be assigned to s25
        for j=1:3
            for k=1:3
                s=s+y(j)*y(k)*(2*d(j,i)-d(j,k));
            end
        end
        phi(i)=exp((BB(i,i)*(P-Psat(i))+1/2*P*s)/R/T);
    end
    
    err2=1;
    while err2 > 1e-6
        x=y.*phi.*P./gammas./Psat;
        x=x./sum(x);
        gnew=exp([2.45*x(2)*(1-x(1))-1.42*x(3)*(1-x(1))-2.04*x(2)*x(3)
            2.45*x(1)*(1-x(2))-1.42*x(1)*x(3)+2.04*x(3)*(1-x(2))
            -2.45*x(1)*x(2)-1.42*x(1)*(1-x(3))+2.04*x(2)*(1-x(3))]);
        err2=max(abs(1-gammas./gnew));
        gammas=gnew;
    end
    Pnew=1/(sum(y.*phi./Psat./gammas));
    err=max(abs(1-P/Pnew));
    P=Pnew;
end
P,x