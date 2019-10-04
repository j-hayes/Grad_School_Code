clc
tspan = [0 20]; % Range for the time of the reaction 
y0 = [2; 0; 0]; % Initial values for the dependent variables i.e. Ca,Cb,Cc
[w,y]=ode45(@ODEfun,tspan,y0);
z=size(y);
% Calculating values of selectivity
for i=1:z(1,1)
    if w(i,1)>0.0001
    Scd(i)=y(i,2)/y(i,3);
    else 
        Scd(i)=0;
    end
end
plot(w,Scd)
xlabel('time')
ylabel('S_B_/_C')
axis([0 20 0 10])
title('Selectivity Profile')