% adapted from textbook examples http://umich.edu/~elements/5e/live/chapter08/8-3/LEP-8-3.zip
aaa = false;
clc
tspan = [0 15]; % Range for the time of the reaction 
y0 = [1.6; 0; 0]; % Initial values for the dependent variables i.e. Ca,Cb,Cc
k = [0.4; 0.01; .3; .005];

%part a
[wIrriversible,yIrriversible]=ode45(@(t,y)ODEfun(t,y,'none', k),tspan,y0);
%part b
[wFirstReversible,yFirstReversible]=ode45(@(t,y)ODEfun(t,y,'first',k),tspan,y0);
%part c
[wBothReversible,yBothReversible]=ode45(@(t,y)ODEfun(t,y,'both',k),tspan,y0);



subplot(3,1,1);
plot(wIrriversible,yIrriversible(:,1),wIrriversible,yIrriversible(:,2),wIrriversible,yIrriversible(:,3))
legend('C_A','C_B','C_C')
xlabel('time')
ylabel('C_i')
title('Concentration Profiles irreversible')
subplot(3,1,2);
plot(wFirstReversible,yFirstReversible(:,1),wFirstReversible,yFirstReversible(:,2),wFirstReversible,yFirstReversible(:,3))
legend('C_A','C_B','C_C')
xlabel('time')
ylabel('C_i')
title('Concentration Profiles first reversible')
subplot(3,1,3);
plot(wBothReversible,yBothReversible(:,1),wBothReversible,yBothReversible(:,2),wBothReversible,yBothReversible(:,3))
legend('C_A','C_B','C_C')
xlabel('time')
ylabel('C_i')
title('Concentration Profiles both reversible')

%part e 1
tspan = [0 15];
ke1 = [101;.05;0;0];
[wparte1,yparte1]=ode45(@(t,y)ODEfun(t,y,'both',ke1),tspan,y0);
%part e 2
ke2 = [0.4;0.01;0;1]; 
[wparte2,yparte2]=ode45(@(t,y)ODEfun(t,y,'both',ke2),tspan,y0);
%part e 3
ke3 = [0.4; 0.01;.3;.25];
[wparte3,yparte3]=ode45(@(t,y)ODEfun(t,y,'both',ke3),tspan,y0);

subplot(3,1,1);
plot(wparte1,yparte1(:,1),wparte1,yparte1(:,2),wparte1,yparte1(:,3))
legend('C_A','C_B','C_C')
xlabel('time')
ylabel('C_i')
title('Concentration part e part 1')
subplot(3,1,2);
plot(wparte2,yparte2(:,1),wparte2,yparte2(:,2),wparte2,yparte2(:,3))
legend('C_A','C_B','C_C')
xlabel('time')
ylabel('C_i')
title('Concentration part e 2')
subplot(3,1,3);
plot(wparte3,yparte3(:,1),wparte3,yparte3(:,2),wparte3,yparte3(:,3))
legend('C_A','C_B','C_C')
xlabel('time')
ylabel('C_i')
title('Concentration part e 3')
