% adapted from ChmielewsiZhang table 2.6 
% differential equation dt/dx = ax+bu; where a = ?2, b = 10, u(t) = e^?2t and the initial condition is x(0) = 5
% problem 2.2 and 2.3

clear
%analytical solution

%  part i) see attached paper and pen solution
% part ii) 
xAnalytical = analyticalSolution(.5);
% part iii -> v) 
problem2_2(.25);
 %place a breakpoint here to see the charts for sample rate of dt = .5
disp("accurate but not that accurate 0 < t <3");
% part vi)
problem2_2(.1) ;
%place a breakpoint here to see the charts for sample rate of dt = .1
disp('accurate enough for most values'); 

function problem2_2(dt)


% Continuous-time model
A=[-2]; B=[10]; G=[0]; 
nx=1; nu=1; nw=1; % 1 dimensional ??

%Conversion to Discrete-time
%euler method
Ad_Eul=eye(nx)+dt*A; 
Bd_Eul=dt*B;
Gd_Eul=dt*G;
%sample and hold
M=[A B G; zeros(nu+nw,nx+nu+nw)];
M=expm(M*dt);
Ad_SH=M(1:nx,1:nx);
Bd_SH=M(1:nx,nx+1:nx+nu);
Gd_SH=M(1:nx,nx+nu+1:nx+nu+nw);

%Simulate Process
numberOfIterations=30/dt; 
t=zeros(1,numberOfIterations); 
valuesOfX__SH=zeros(1,numberOfIterations);
valuesOfX_Eul =  zeros(1,numberOfIterations);
x0=5; 
valuesOfX_SH(1)=x0;
valuesOfX_Eul(1)=x0;

valuesOfXAnalytical(:,1)=x0;
x0=[5];

for k=1:numberOfIterations-1
t(k+1)=dt*k; %increment time

valuesOfXAnalytical(k+1) = analyticalSolution(t(k+1));
x_k_Eul = valuesOfX_Eul(k);
x_k_SH = valuesOfX_SH(k);

value_Eul = xKplus1Euler(Ad_Eul,x_k_Eul,Bd_Eul, t(k));

valuesOfX_Eul(:,k+1)= value_Eul;
valuesOfX_SH(:,k+1)=Ad_SH*x_k_SH +Bd_SH*uOft(t(k));

if(t(k+1)==.5)
display('value at t = .5');
value_Eul
end


end
plot(t,valuesOfX_Eul,'c--o',t,valuesOfX_SH,'b--o',t,valuesOfXAnalytical,'g--o')
legend('Euler','Sample&Hold','Analytical')
xlabel('Time (seconds)')
ylabel('State Value (X)')
end 

function x = xKplus1Euler(Ad_Eul,x_k_Eul,Bd_Eul, t)
x = Ad_Eul*x_k_Eul +Bd_Eul*uOft(t);
end

function u = uOft(t)
u = exp(-2*t);
end

function x = analyticalSolution(t)
x = 5*exp(-2*t)*(2*t+1);
end