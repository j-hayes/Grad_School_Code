% adapted from textbook examples http://umich.edu/~elements/5e/live/chapter08/8-3/LEP-8-3.zip
clc
P = 24.6;
R = .082;
T = 500;
Ca0 = P/(R*T);
Fa0 = 10;
y0 = [Fa0;0;0;0;0;1;]; % Initial values for the dependent variables i.e. Ca,Cb,Cc

tspan = 0:.01:100;

k1c = 2;
k2d = .4;
k3e = 400;
Wf = 100;
alpha = .008;
K1c = .2;
kc = 1;
Ct0 = Ca0;
kb = 1;
Ft0 = 10;

params = [k1c;k2d;k3e;Wf;alpha;K1c;kc;Ct0;kb;Ft0;Fa0];
%part a
[wparta,outputs]=ode45(@(w,c)ODEfun(w,c,params),tspan,y0);
Fa = outputs(:,1);
Fb = outputs(:,2);
Fc = outputs(:,3);
Fd = outputs(:,4);
Fe = outputs(:,5);

y = outputs(:,6);

Ft = Fa + Fb + Fc + Fd + Fe;

Ca = Ct0*(Fa./Ft).*y;
Cb = Ct0*(Fb./Ft).*y;
Cc = Ct0*(Fc./Ft).*y;
Cd = Ct0*(Fd./Ft).*y;
Ce = Ct0*(Fe./Ft).*y;


subplot(2,1,1)
plot(wparta,Ca,wparta,Cb,wparta,Cc,wparta,Cd,wparta,Ce)
legend('C_A','C_B','C_C','C_D','C_E')
xlabel('time')
ylabel('C_i')
title('Concentration Profiles part a')


%part e
k1c = 4;
k2d = .4;
k3e = 300;
Wf = 100;
alpha = .008;
K1c = 2;
kc = 1;
Ct0 = Ca0;
kb = 10;
Ft0 = 10;
params = [k1c;k2d;k3e;Wf;alpha;K1c;kc;Ct0;kb;Ft0;Fa0];
[wparte,outputse]=ode45(@(w,c)ODEfun(w,c,params),tspan,y0);

Fa = outputse(:,1);
Fb = outputse(:,2);
Fc = outputse(:,3);
Fd = outputse(:,4);
Fe = outputse(:,5);

y = outputse(:,6);

Ft = Fa + Fb + Fc + Fd + Fe;

Ca = Ct0*(Fa./Ft).*y;
Cb = Ct0*(Fb./Ft).*y;
Cc = Ct0*(Fc./Ft).*y;
Cd = Ct0*(Fd./Ft).*y;
Ce = Ct0*(Fe./Ft).*y;

subplot(2,1,2)
plot(wparte,Ca,wparte,Cb,wparte,Cc,wparte,Cd,wparte,Ce)
legend('C_A','C_B','C_C','C_D','C_E')
xlabel('time')
ylabel('C_i')
title('Concentration Profiles part d')
