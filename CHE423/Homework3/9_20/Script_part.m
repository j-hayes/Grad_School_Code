clc

clc

tspan = 0:.1:48;
C0 = 1;
u = 9/24;%convert to per hour
params = u;
%part a
[tPArtA,outputPartA]=ode45(@(t,c)ODEfun(t,c,params),tspan,C0);
C = outputPartA(:,1);

subplot(3,1,1)
plot(tPArtA,C)
legend('Cc/Cc0');
xlabel('time')
ylabel('Cc/Cc0')
title('Concentration part a')

%part b 
a =1;
timeOfEffectiveConcentration =0;
while(a < length(C)&& timeOfEffectiveConcentration == 0)
    if C(a) > 200/.5
        timeOfEffectiveConcentration = tPArtA(a);
    end
    a = a+1;
end
%part b graphically 
tspan = 0:.1:60;
C0 = .5;
u = 9/24;%convert to per hour
params = u;
[tPArtB,outputPartB]=ode45(@(t,c)ODEfun(t,c,params),tspan,C0);
CpartB = outputPartB(:,1);

subplot(4,1,2)
plot(tPArtB,CpartB)
legend('Cc');
xlabel('time')
ylabel('Cc')
title('Concentration part b')

%part c  
tspan = 0:.1:80;
C0 = .5;
u = 9/24;%convert to per hour
params = [u 200];
%part c
[tPArtC,outputPartC]=ode45(@(t,c)ODEfunpartc(t,c,params),tspan,C0);
CpartC = outputPartC(:,1);

subplot(4,1,3)
plot(tPArtC,CpartC)
legend('Cc');
xlabel('time')
ylabel('Cc')
title('Concentration part c')



%part d 

tspan = 6:.1:(60);% one day starting at 6am
C0 = 100;
u = 9/24;%convert to per hour
params = [u 200];
%part d
[tPArtD,outputPartD]=ode45(@(t,c)ODEfunpartd(t,c,params),tspan,C0);
CpartD = outputPartD(:,1);

subplot(4,1,4)
plot(tPArtD,CpartD )
legend('Cc');
xlabel('time')
ylabel('Cc')
title('Concentration part d')


%part g

tspan = 0:.1:(24);
C0 = .5;
I0 = .1;
u = 9/24;%convert to per hour
params = [u 200];
%part d
[tPArtG,outputPartG]=ode45(@(t,c)ODEfunpartg(t,c,params),tspan,[C0,I0]);
CpartG = outputPartG(:,1);
IpartG = outputPartG(:,2);
subplot(1,1,1)
plot(tPArtG,CpartG,tPArtG,IpartG )
legend('Cc', 'Cinvasive');
xlabel('time')
ylabel('Cc')
title('Concentration part g')


