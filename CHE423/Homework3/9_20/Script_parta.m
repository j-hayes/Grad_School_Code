clc

tspan = 0:.1:48;


C0 = 1;
u = 9/24;
params = u;
%part a
[tPArtA,outputPartA]=ode45(@(w,c)ODEfun(w,c,params),tspan,C0);
C = outputPartA(:,1);

subplot(2,1,1)
plot(tPArtA,C)
legend('Cc/Cc0');
xlabel('time')
ylabel('Cc/Cc0')
title('Concentration part a')


