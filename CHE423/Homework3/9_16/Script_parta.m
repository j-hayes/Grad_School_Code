clc

tspan = 0:.01:5;
uMax = 1;
Ks = .25;
Ycs = .5;
Ysc = 1/ Ycs;
Cc0 = .1;
Cs0 = 20;

params = [uMax;Ks;Ycs;Cc0;Cs0];
%part a
[tPArtA,outputPartA]=ode45(@(w,c)ODEfun(w,c,params),tspan,Cs0);
Cs = outputPartA(:,1);
Cc = Cc0 + (Ycs.\(Cs0 - Cs)); 
rg = (uMax .* Cs .* Cc)./(Ks + Cs);
negRs = Ysc*rg;
negRc = rg*Ycs;

subplot(2,1,1)
plot(tPArtA,Cc,tPArtA, Cs)
legend('Cc', 'Cs');
xlabel('time')
ylabel('concentration g/dm^3')
title('Concentration Profiles part a')

subplot(2,1,2)
plot(tPArtA,rg,tPArtA, negRs,tPArtA, negRc)
legend('rg', '-rs', '-rc');
xlabel('time')
ylabel('rates g/dm^3*h')
title('rates part a')


