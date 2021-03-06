% adapted from textbook examples http://umich.edu/~elements/5e/live/chapter08/8-3/LEP-8-3.zip
clc
tspan = 0:.1:10000; % Range for the time of the reaction 
y0 = [.02; 0; 0]; % Initial values for the dependent variables i.e. Ca,Cb,Cc
k = [.00108;.0019;.00159];
%part a
[tparta,Cparta]=ode45(@(t,c)ODEfun(t,c,k),tspan,y0);
kpartb_1 = [.00264;.0033;.0031];
%part b 1
[tpartb_1,Cpartb_1]=ode45(@(t,c)ODEfun(t,c,kpartb_1),tspan,y0);

kpartb_2 = [.00042;.0004;.00078];
%part b 2
[tpartb_2,Cpartb_2]=ode45(@(t,c)ODEfun(t,c,kpartb_2),tspan,y0);


subplot(3,1,1);
plot(tparta,Cparta(:,1),tparta,Cparta(:,2),tparta,Cparta(:,3))
axis([0 1500  0 .02]);
legend('C_A','C_R','C_S')
xlabel('time')
ylabel('C_i')
title('Concentration Profiles part a')

subplot(3,1,2);
plot(tpartb_1,Cpartb_1(:,1),tpartb_1,Cpartb_1(:,2),tpartb_1,Cpartb_1(:,3))
axis([0 1500  0 .02]);
legend('C_A','C_R','C_S')
xlabel('time')
ylabel('C_i')
title('Concentration Profiles part b-1 430 C')

subplot(3,1,3);
plot(tpartb_2,Cpartb_2(:,1),tpartb_2,Cpartb_2(:,2),tpartb_2,Cpartb_2(:,3))
legend('C_A','C_R','C_S')
axis([0 10000  0 .02]);
xlabel('time')
ylabel('C_i')
title('Concentration Profiles part b-2 390 C')

% part c
tspan =  0:.1:1200; % Range for the time of the reaction 
y0 = [.02; 0; 0]; % Initial values for the dependent variables i.e. Ca,Cb,Cc
k_partc = [.00108;.0019;.00159];
%part a
[tpartc,Cpartc]=ode45(@(t,c)ODEfun(t,c,k_partc),tspan,y0);

Ca_partc = Cpartc(12001,1);
Cr_partc = Cpartc(12001,2);
Cs_partc = Cpartc(12001,3);


