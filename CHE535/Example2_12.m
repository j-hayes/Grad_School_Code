
clear
% Continuous-time Model of Mass-Spring-Damper
A=[0 1;-3 -2]; B=[0; 1]; G=[0; 1]; nx=2; nu=1; nw=1;
%Conversion to Discrete-time
dt=0.5; Euler=1;
if (Euler==1)
Ad=eye(nx)+dt*A; Bd=dt*B; Gd=dt*G;
else
M=[A B G; zeros(nu+nw,nx+nu+nw)];
M=expm(M*dt);
Ad=M(1:nx,1:nx);
Bd=M(1:nx,nx+1:nx+nu);
Gd=M(1:nx,nx+nu+1:nx+nu+nw);
end
%Simulate Forced Process
NNN=15/dt; ttt=zeros(1,NNN); xxx=zeros(2,NNN);
x0=[1; 0]; xxx(:,1)=x0;
for kk=1:NNN-1
ttt(kk+1)=dt*kk; uk=0; wk=0;
if (ttt(kk) >= 5) uk=1; end
if (ttt(kk) >= 10) wk=-2; end
xxx(:,kk+1)=Ad*xxx(:,kk)+Bd*uk+Gd*wk;
end
plot(ttt,xxx(1,:),'-k*',ttt,xxx(2,:),'-ko')
legend(' Mass Position',' Mass Velocity')
xlabel('Time (seconds)')
ylabel('State Variables (m or m/s)')