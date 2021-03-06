
function [dxdt,zout]= motor_mod_ode_lin(t,x,Case)
AA=[-0.5 0 0; ...
-80.8 -0.25 -0.655; ...
46.3 0.262 -0.06];
BB=[ 0.02 0; 0 0.5; 0 0];
GG=[ 0; 0; 0.2];
Dx=[36 360 0; 0 0 -280];
Du=[1.44 254; 0 0];
Dw=[177];
u=[0; 0];
w=0;

if (Case == 1) %Case 1
if t > 10; u=[2; 0]; end
if t > 50; u=[-2; 0]; end

else %Case 2
if t > 10; u=[20; 0]; end
if t > 50; u=[-10; 0]; end
end
dxdt=AA*x+ BB*u+GG*w;
zout=Dx*x+Du*u+Dw*w;
end