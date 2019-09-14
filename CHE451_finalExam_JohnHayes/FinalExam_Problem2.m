%Adapted from code provided by Dr. Perez-Luna
%Author John Hayes
%Algorithm following figure 14.1 page 548 from textbook
%BUBL P(313.15,{.1,.35,.55})
%indexes 1 = water, 2 = methanol, 3 = acetone

%box 1
T=313.15;
TInCelcius = 45;
R=83.14; % bar*cm^3/mol/K
x=[0.1;0.35;0.55];
V = [18.07;40.73;74.05]; % cm^3/mol  volumes from table 12.5
a = [ 1 496.55 1448.01
    107.38 1 583.11
    -161.88 196.75 1]; %wilson's equation parameters
a = a.*(.239006/10); %  .239006 cal/mol = 10 bar cm^3/mol;
A=[16.3872; 16.5785; 14.3145];
B=[3885.96; 3638.27; 2756.22];
C=[230.17; 239.500; 228.060];

Psat=exp(A-B./(TInCelcius+C))/100;%antoine equation => bar

Pc = [220.55;80.97;47.01];% bar
Tc = [647.1;512.6;508.2];%K
accentricityFactor = [.345;.564;.307];

Tr = T./Tc;
B0 = .083 - .422./(Tr.^1.6);
B1 = .139 - .0172./(Tr.^4.2);
B = B0 + accentricityFactor.*B1;

BB = zeros(3,3);
for i=1:3
    for j=1:3
        BB(i,j) = -sqrt(B(i)*B(j));%made this negative to fall in line with example bb values all being negative and notes from class that virial coeff. are negative
    end
end

d = calculateDeltas(BB);
phi=[1;1;1];
g = calculateGammas(x, a, V, R,T);
P = getP(x,g,Psat,phi);
%end box 1
err=1;
%loop of box 2 - 4
while err > 1e-6
    %box 3
    y = getY(x,g,Psat,phi,P);
    phi = getPhi(BB,P,Psat,d,y,R,T);
    %end box 3
    %box 4
    newP = getP(x,g,Psat,phi);
    %end box 4
    err = abs(1-P/newP);
    P = newP;
end
%end loop box 2-4
%box 5 print results
message = 'P in bars'
P
ywater = y(1,1)
ymethanol = y(2,1)
yaccetone = y(3,1)
%end box 5

function phi = getPhi(BB,P,Psat,d,y,R,T)
%equation 14.6
phi =[0;0;0];
for i=1:3
    s=0; %the double summation will be assigned to s
    for j=1:3
        for k=1:3
            s=s+y(j)*y(k)*(2*d(j,i)-d(j,k));
        end
    end
     phi(i)=exp((BB(i,i)*(P-Psat(i))+1/2*P*s)/R/T);
end
end
function y = getY(x,g,Psat,phi,P)
y = (x.*g.*Psat)./(phi.*P); %eq. 14.8
y = y./sum(y);%normalize so value sum (y) = 1
end

function P = getP(x,g,Psat,phi)
P = sum((x.*g.*Psat)./phi); % eq 14.10
end

function g = calculateGammas(x, a, V, R,T)
g=wilson(x, a, V, R*T);
end

function d = calculateDeltas(BB)
% calculation of delta values used to estimate fugacity coefficients
% eq 14.4 page 546
d = zeros(3,3);
for i=1:3
    for j=1:3
        if i ~= j
            d(i,j) = 2*BB(i,j) - BB(i,i) - BB(j,j);
        end
    end
end
end

