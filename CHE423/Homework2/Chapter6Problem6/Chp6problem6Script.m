% adapted from textbook code example at url http://umich.edu/~elements/5e/live/chapter06/6-1/LEP-6-1.zip
clear all;
Vspan = [0 20];
F0 = [100; 0; 0]%initial values Fa Fb Fc

[v F]= ode45(@(v,f)Chapter6Problem6ODE(v,f,'membrane'),Vspan,F0);
[vPfr Fpfr] = ode45(@(v,f)Chapter6Problem6ODE(v,f,'pfr'),Vspan,F0);



X = (100 - F(:,1)) / 100;
Xpfr = (100 - Fpfr(:,1)) / 100;


%plot

% Top plot
subplot(2,2,1);
plot(v,F(:,1),v,F(:,2),v,F(:,3));
ylabel('F_j(mol/min)');
xlabel('V(dm^3)');
axis([0 20  0 100]);
legend('Fa','Fb','Fc')
title('Flow rates Membrane');
subplot(2,2,2);
plot(v,X);
ylabel('X Conversion)');
xlabel('V(dm^3)');
axis([0 20  0 1]);
title('Conversion Membrane');

subplot(2,2,3);
plot(vPfr,Fpfr(:,1),vPfr,Fpfr(:,2),vPfr,Fpfr(:,3));
ylabel('F_j(mol/min)');
xlabel('V(dm^3)');
axis([0 20  0 100]);
legend('Fa','Fb','Fc')
title('Flow rates Pfr');
subplot(2,2,4);
plot(vPfr,Xpfr);
ylabel('X Conversion)');
xlabel('V(dm^3)');
axis([0 20  0 1]);
title('Conversion Pfr');









