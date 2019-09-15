
function [dxdt,zout]= endo_cstr_ode_lin(t,x,dummyvar,A,B,G,Dx,Du,Dw, Q_SSOP,CA0_SSOP)


QQ=0;
CA0=0;

%simulate
if t <= 0
CA0 = 1;
QQ = 2.845 * 10^6;
elseif t < 10
CA0 = 1.2;
QQ = 2.7 * 10^6;
elseif t < 20
CA0 = 1.2;
QQ = 3.1*10^6;
end
% u = m - mssop
u = [(QQ - Q_SSOP)];
%w = p - p_ssop
w = [(CA0 - CA0_SSOP)];

dxdt=A*x+B*u+G*w;
zout=Dx*x+Du*u+Dw*w;
end