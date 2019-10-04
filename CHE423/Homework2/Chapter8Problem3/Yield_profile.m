clc
tspan = [0 20]; % Range for the time of the reaction 
y0 = [2; 0; 0]; % Initial values for the dependent variables i.e. Ca,Cb,Cc
[w,y]=ode45(@ODEfun,tspan,y0);
z=size(y);
Cao=2;
% Calculating values of Yield
for i=1:z(1,1)
 Yield(i)=y(i,2)/(Cao-y(i,1));
end
y(1,2)
plot(w,Yield)
xlabel('time')
ylabel('Y_B')
axis([0 20 0 1])
title('Yield Profile')