clc

tspan = 0:.1:21;
uMax = .8;
Ks = 4;
Ycs = .5;
Ysc = 2;
Ypc = .2;
Cc0 = .5;
Cs0 = 10;

params = [uMax;Ks;Ycs;Cc0;Cs0;Ypc];
%part a
[tpartE,outputpartE]=ode45(@(w,c)ODEfun(w,c,params),tspan,[Cc0;Cs0;0]);
Cs = outputpartE(:,1);
Cc =outputpartE(:,2);
Cp =outputpartE(:,3);

subplot(2,1,1)
plot(tpartE,Cc,tpartE,Cs, tpartE,Cp)
legend('Cc', 'Cs','Cp');
xlabel('time')
ylabel('concentration g/dm^3')
title('Concentration Profiles part a')



