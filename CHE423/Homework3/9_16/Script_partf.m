clc

tspan = 0:.01:10;
uMax = 1;
Ks = .25;
Ycs = .5;
Ysc = 1/ Ycs;
Cc0 = .1;
Cs0 = 20;
Cinf = 1;

params = [uMax;Ks;Ycs;Cc0;Cs0;Cinf];
%part a
[tpartF,outputpartF]=ode45(@(w,c)ODEfunPartf(w,c,params),tspan,Cs0);
Cs = outputpartF(:,1);
Cc = Cc0 + (Ycs.\(Cs0 - Cs)); 
rg = (uMax .* Cs .* Cc)./(Ks + Cs);
negRs = Ysc*rg;
rc = rg*Ycs;

subplot(2,1,1)
plot(tpartF,Cc,tpartF, Cs)
legend('Cc', 'Cs');
xlabel('time')
ylabel('concentration g/dm^3')
title('Concentration Profiles part f')

subplot(2,1,2)
plot(tpartF,rg,tpartF, negRs,tpartF, rc)
legend('rg', '-rs', 'rc');
xlabel('time')
ylabel('rates g/dm^3*h')
title('rates part f')


tspan = 0:.01:10;
uMax = 1;
Ks = .25;
Ycs = .5;
Ysc = 1/ Ycs;
Cc0 = .1;
Cs0 = 20;
Cinf = Ycs*Cs0 + Cc0;

params = [uMax;Ks;Ycs;Cc0;Cs0;Cinf];
%part a
[tpartF,outputpartF]=ode45(@(w,c)ODEfunPartf(w,c,params),tspan,Cs0);
Cs = outputpartF(:,1);
Cc = Cc0 + (Ycs.\(Cs0 - Cs)); 
rg = (uMax .* Cs .* Cc)./(Ks + Cs);
negRs = Ysc*rg;
rc = rg*Ycs;

subplot(2,1,1)
plot(tpartF,Cc,tpartF, Cs)
legend('Cc', 'Cs');
xlabel('time')
ylabel('concentration g/dm^3')
title('Concentration Profiles part f')

subplot(2,1,2)
plot(tpartF,rg,tpartF, negRs,tpartF, rc)
legend('rg', '-rs', 'rc');
xlabel('time')
ylabel('rates g/dm^3*h')
title('rates part f')


