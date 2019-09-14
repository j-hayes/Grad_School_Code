% adapted from ChmielewsiZhang table 2.6 and table 2.7
% problem 2.8

clear
% Continuous-time Model of Mass-Spring-Damper for 3 mass system given by
% figure 2.18
% part i) in attached paper and pen solution 

A=[0,0,0,1,0,0
   0,0,0,0,1,0
   0 ,0,0,0,0,1
   -.1,.1,0,-.05,.05,0
   .001,-.201,.2,.0005,-.0305,.03;
   0,2,-2,0,.3,-.3;
   ];
B=[0,0;
   0,0
   0,0
   1,0
   -.01,.01
   0,-.1];

G=[0
    0
    0
    0
    0
    0.1];
nx=6; 
nu=2;
nw=1;

%Conversion to Discrete-time
%part ii)
dt=0.5; 

M=[A B G; zeros(nu+nw,nx+nu+nw)];
M=expm(M*dt);
Ad=M(1:nx,1:nx);
Bd=M(1:nx,nx+1:nx+nu);
Gd=M(1:nx,nx+nu+1:nx+nu+nw);

%part iii  discrete-time model)
%Simulate Forced Process
numberOfIterations=100/dt;
time=zeros(1,numberOfIterations); 
valuesOfX=zeros(6,numberOfIterations); % 6 row values of x number of iterations colums representing x at each time interval


x0=[1;.1;.5;0;0;0]; 
valuesOfX(:,1)=x0;% set values at t = 0
for kk=1:numberOfIterations-1
time(kk+1)=dt*kk; 
uk=[0;0]; % u assumed zero for all time as assumed by problem
wk=0; %w assumed zero for all time as assumed by problem 
valuesOfX(:,kk+1)=Ad*valuesOfX(:,kk)+Bd*uk+Gd*wk;

end
plot(time,valuesOfX(1,:),'g--o',time,valuesOfX(2,:),'b--o',time,valuesOfX(3,:),'r--o',time,valuesOfX(4,:),'c--o',time,valuesOfX(5,:),'m--o',time,valuesOfX(6,:),'k--o');
legend('mass 1 position','mass 2 position','mass 3 position','velocity 1','velocity 2','velocity 3');
xlabel('Time (seconds) part iii of problem');
ylabel('State Variables (m or m/s)');

%place breakpoint here to see charts for part iii discrete time

%Continuous-time Simulation for part iii)
 s_steadyState=[0; 0; 0; 0 ;0 ;0]; %based on sample and hold positions all converge to 1.435 and velocities go to zero 
 % however the models charts matched when steady state set = 0; not sure
 % why this is working this way.
[t_lin,x_lin]=ode45('mass_spring_damper_ode',[0 100],x0);
[NN,dumb]=size(t_lin); 
z_lin=zeros(NN,6);
for ii=1:NN
[dxdt,zout]=mass_spring_damper_ode(t_lin(ii),x_lin(ii,:)');
z_lin(ii,:)=zout';
end
%Plots
plot(t_lin,x_lin(:,1)+s_steadyState(1),'g--o',t_lin,x_lin(:,2)+s_steadyState(2),'b--o',t_lin,x_lin(:,3)+s_steadyState(3),'r--o',t_lin,x_lin(:,4)+s_steadyState(4),'c--o',t_lin,x_lin(:,5)+s_steadyState(5),'m--o',t_lin,x_lin(:,6)+s_steadyState(6),'k--o');
title('Continous time model','FontSize',14,'FontName','Times New Roman');
xlabel('Time (seconds) part iii of problem');
ylabel('State Variables (m or m/s)');
legend('mass 1 position','mass 2 position','mass 3 position','velocity 1','velocity 2','velocity 3');

%place breakpoint here to see charts for part iii continuous time


%part iv discrete-time model)
x0_partv=[0;0;0;0;0;0]; 
valuesOfX_partv(:,1)=x0_partv;% set values at t = 0
for kk=1:numberOfIterations-1
time(kk+1)=dt*kk; 
uk=[0;0]; % u assumed zero for all time as assumed by problem
wk=sin(10*time(kk)); %w as ddescripted by the problem part v
valuesOfX_partv(:,kk+1)=Ad*valuesOfX_partv(:,kk)+Bd*uk+Gd*wk;

end
plot(time,valuesOfX_partv(1,:),'g--o',time,valuesOfX_partv(2,:),'b--o',time,valuesOfX_partv(3,:),'r--o',time,valuesOfX_partv(4,:),'c--o',time,valuesOfX_partv(5,:),'m--o',time,valuesOfX_partv(6,:),'k--o');
legend('mass 1 position','mass 2 position','mass 3 position','velocity 1','velocity 2','velocity 3');
xlabel('Time (seconds) (part v of problem)');
ylabel('State Variables (m or m/s)');

%part iv displayed here



