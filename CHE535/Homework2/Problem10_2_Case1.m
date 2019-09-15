clear all
% Motor Parameters
Lf=50; %H
Rf=25; %ohms
La=2; %H
Ra=0.5; %ohms
Kv=0.91; %V/(A rad/s)
J=5; %Nm
B=0.3; %J/(rad/s)

%Inputs at Steady-State
Vf=36; %V
Va=360; %V
TL=-280; %Nm=J


%Steady-state Calcs
if_ss= Vf/Rf;
linstate=inv([Ra Kv*if_ss;-Kv*if_ss B])*[Va;TL];
ia_ss=linstate(1); w_ss=linstate(2);
s_ss=[if_ss; ia_ss; w_ss]
q_ss=[if_ss*Vf+ia_ss*Va; w_ss*TL]

[t_nlin,s_nlin]=ode45('motor_mod_ode',[0 100],s_ss,1);
[t_lin,x_lin]=ode45('motor_mod_ode_lin',[0 100],s_ss-s_ss,1);
[NN,dumb]=size(t_nlin); 
q_nlin=zeros(NN,2);

for ii=1:NN
[dsdt,qout]=motor_mod_ode(t_nlin(ii),s_nlin(ii,:)',1); 
q_nlin(ii,:)=qout';
end
[NN,dumb]=size(t_lin); z_lin=zeros(NN,2);
for ii=1:NN
[dxdt,zout]=motor_mod_ode_lin(t_lin(ii),x_lin(ii,:)',1); 
z_lin(ii,:)=zout';
end
%Plots

plot(t_nlin,s_nlin(:,1),'k',t_lin,x_lin(:,1)+s_ss(1),'k--');
title('Case 1','FontSize',14,'FontName','Times New Roman');
ylabel('Field Current (A)','FontSize',14,'FontName','Times New Roman');
xlabel('Time (s)','FontSize',14,'FontName','Times New Roman')
legend('Nonlinear','Linear '); pause
plot(t_nlin,s_nlin(:,2),'k',t_lin,x_lin(:,2)+s_ss(2),'k--')
title('Case 1','FontSize',14,'FontName','Times New Roman');
ylabel('Armature Current (A)','FontSize',14,'FontName','Times New Roman');

xlabel('Time (s)','FontSize',14,'FontName','Times New Roman')
legend('Nonlinear','Linear '); pause
plot(t_nlin,s_nlin(:,3),'k',t_lin,x_lin(:,3)+s_ss(3),'k--')
title('Case 1','FontSize',14,'FontName','Times New Roman');
ylabel('Angular Speed (rad/s)','FontSize',14,'FontName','Times New Roman');
xlabel('Time (s)','FontSize',14,'FontName','Times New Roman')
legend('Nonlinear','Linear '); pause
plot(t_nlin,q_nlin(:,1)/1000,'k',t_lin,(z_lin(:,1)+q_ss(1))/1000,'k--')
title('Case 1','FontSize',14,'FontName','Times New Roman');
ylabel('Power Electrical (kW)','FontSize',14,'FontName','Times New Roman');
xlabel('Time (s)','FontSize',14,'FontName','Times New Roman')
legend('Nonlinear','Linear '); pause
plot(t_nlin,q_nlin(:,2)/1000,'k',t_lin,(z_lin(:,2)+q_ss(2))/1000,'k--')
title('Case 1','FontSize',14,'FontName','Times New Roman');
ylabel('Power Mechanical (kW)','FontSize',14,'FontName','Times New Roman');
xlabel('Time (s)','FontSize',14,'FontName','Times New Roman')
legend('Nonlinear','Linear '); pause


% Linear Continuous-time Model
AA=[-0.5 0 0; ...
-80.8 -0.25 -0.655; ...
46.3 0.262 -0.06];
BB=[ 0.02 0; 0 0.5; 0 0]; GG=[ 0; 0; 0.2];
Dx=[36 360 0; 0 0 -280]; Du=[1.44 254; 0 0]; Dw=[177];
% Discretization
dt=5; AAd=expm(AA*dt);
sum=zeros(3); Ndt=2000; ddt=dt/Ndt;
for ii=1:Ndt; sum=sum+expm(AA*ii*ddt); end
BBd=sum*BB*ddt; GGd=sum*GG*ddt;
% Disctete-time Simulation
NNN=round(100/dt); t_disc=zeros(1,NNN); x_disc=zeros(3,NNN); z_disc=zeros(2,NNN);
uu=[0; 0]; ww=0;
for ii=1:NNN-1
t_disc(ii+1)=ii*dt;
Case=1; t=t_disc(ii);
if (Case == 1) %Case 1
if t >= 10; uu=[2; 0]; end
if t >= 50; uu=[-2; 0]; end
else %Case 1
if t >= 10; uu=[20; 0]; end
if t >= 50; uu=[-10; 0]; end
end
x_disc(:,ii+1)=AAd*x_disc(:,ii)+BBd*uu+GGd*ww;
z_disc(:,ii)=Dx*x_disc(:,ii)+Du*uu+Dw*ww;
end
z_disc(:,NNN)=z_disc(:,NNN-1);
%Continuous-time Simulation
[t_lin,x_lin]=ode45('motor_mod_ode_lin',[0 100],s_ss-s_ss,1);
[NN,dumb]=size(t_lin); z_lin=zeros(NN,2);
for ii=1:NN
[dxdt,zout]=motor_mod_ode_lin(t_lin(ii),x_lin(ii,:)',1); z_lin(ii,:)=zout';
end
%Plots
plot(t_disc,x_disc(1,:)+s_ss(1),'k*:',t_lin,x_lin(:,1)+s_ss(1),'k');
title('Case 1','FontSize',14,'FontName','Times New Roman');
ylabel('Field Current (A)','FontSize',14,'FontName','Times New Roman');
xlabel('Time (s)','FontSize',14,'FontName','Times New Roman')
legend('Discrete-time','Continuous-time'); pause
plot(t_disc,x_disc(2,:)+s_ss(2),'k*:',t_lin,x_lin(:,2)+s_ss(2),'k')
title('Case 1','FontSize',14,'FontName','Times New Roman');
ylabel('Armature Current (A)','FontSize',14,'FontName','Times New Roman');
xlabel('Time (s)','FontSize',14,'FontName','Times New Roman')
legend('Discrete-time','Continuous-time'); pause
plot(t_disc,x_disc(3,:)+s_ss(3),'k*:',t_lin,x_lin(:,3)+s_ss(3),'k')
title('Case 1','FontSize',14,'FontName','Times New Roman');
ylabel('Angular Speed (rad/s)','FontSize',14,'FontName','Times New Roman');
xlabel('Time (s)','FontSize',14,'FontName','Times New Roman')
legend('Discrete-time','Continuous-time'); pause
plot(t_disc,(z_disc(1,:)+q_ss(1))/1000,'k*:',t_lin,...
(z_lin(:,1)+q_ss(1))/1000,'k')
title('Case 1','FontSize',14,'FontName','Times New Roman');
ylabel('Power Electrical (kW)','FontSize',14,'FontName','Times New Roman');
xlabel('Time (s)','FontSize',14,'FontName','Times New Roman')
legend('Discrete-time','Continuous-time'); pause
plot(t_disc,(z_disc(2,:)+q_ss(2))/1000,'k*:',t_lin,...
(z_lin(:,2)+q_ss(2))/1000,'k')
title('Case 1','FontSize',14,'FontName','Times New Roman');
ylabel('Power Mechanical (kW)','FontSize',14,'FontName','Times New Roman');
xlabel('Time (s)','FontSize',14,'FontName','Times New Roman')
legend('Discrete-time','Continuous-time'); pause


