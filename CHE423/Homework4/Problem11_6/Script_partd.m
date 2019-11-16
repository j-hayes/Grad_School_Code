clear all;

VSpan = 0:.1:500;
T0 = 1100;%K

P = 2;%atm;
R = .082;%atm *L/mol/k
CA0 = P/(R*T0);
CI0 = CA0; %same temp pressure assume ideal gas law
Kc0 = 2;
Fa0 = 10;

dHrx = -80000;%J/mol;
R = 8.314;%J/mol*K

ThetaI = 0:1:100;
Cpa = 170;
Cpi = 200;
X0 = 0;
V = [];
Conversion = zeros(5001,21);
i = 1;
while i <= 101
   thetaaaa = ThetaI(i);
   params = [CA0;CI0;thetaaaa;T0;Cpa;Cpi;dHrx;Fa0;Kc0;R];
   [Vout,Xoutput]=ode45(@(V,X)ODEfun_partd(V,X,params),VSpan,X0); 
   V = Vout;
   Conversion(:,i) = Xoutput;
   CA0111 = (CA0 + CI0)/(ThetaI(i) + 1);
i = i+1;
   
end
X_outlet =Conversion(5001,:);

X_NoInert = Conversion(:,1);
Fb_NoInert = Fa0*X_NoInert;
T_NoInert = (X_NoInert*(-dHrx) + (Cpa+ThetaI(1)*Cpi)*T0)/(Cpa+ThetaI(1)*Cpi);

X_ModInert = Conversion(:,2);
Fb_ModInert = Fa0*X_ModInert;
T_ModInert = (X_ModInert*(-dHrx) + (Cpa+ThetaI(2)*Cpi)*T0)/(Cpa+ThetaI(2)*Cpi);

X_LargeInert = Conversion(:,100);
Fb_LargeInert = Fa0*X_LargeInert;
T_LargeInert = (X_LargeInert*(-dHrx) + (Cpa+ThetaI(100)*Cpi)*T0)/(Cpa+ThetaI(100)*Cpi);

subplot(4,1,1)
plot(VSpan,X_NoInert,VSpan,X_ModInert,VSpan,X_LargeInert);
legend('No Inert', 'Moderate Inert', 'Large Inert');
xlabel('Volume');
ylabel('Conversion');
title('Conversion Vs Volume');

subplot(4,1,2)
plot(VSpan,T_NoInert,VSpan,T_ModInert,VSpan,T_LargeInert);
legend('No Inert', 'Moderate Inert', 'Large Inert');
xlabel('Volume');
ylabel('Temp K');
title('Temperature Vs Volume');

subplot(4,1,3)
plot(ThetaI, X_outlet);
legend('Outlet Conversion');
xlabel('Theta I');
ylabel('Conversion');
title('Conversion Vs Theta I');



subplot(4,1,4)
plot(VSpan,Fb_NoInert,VSpan,Fb_ModInert,VSpan,Fb_LargeInert);
legend('No Inert', 'Moderate Inert', 'Large Inert');
xlabel('Volume');
ylabel('Mol/min');
title('Fb Vs Volume');
