clear all
syms a b c d f g
% system of equations at steady state with constants plugged in and
% simplified
eq1_1 = 0 == (55 * f) / 8 - (75 * a) / 8 + 745;
eq2_1 = 0 == 5/2 - 1500 * b * exp(-2000000 / (1987 * d)) - (5 * b) / 2;
eq3_1 = 0 == 1500 * b * exp(-2000000 / (1987 * d)) - (5 * c) / 2;
eq4_1 = 0 == (5 * g) / 2 - (5 * d) / 2 - 300000 * b * exp(-2000000 / (1987 * d));
eq5_1 = 0 == (55 * a) / 8 + (5 * d) / 2 - (75 * f) / 8;
eq6_1 = g == a + 569/2;

%sub eq6 = g == a + 569/2 into eqn 5
eq1_2 = 0 == (55 * f) / 8 - (75 * a) / 8 + 745;
eq2_2 = 0 == 5/2 - 1500 * b * exp(-2000000 / (1987 * d)) - (5 * b) / 2;
eq3_2 = 0 == 1500 * b * exp(-2000000 / (1987 * d)) - (5 * c) / 2;
eq4_2 = 0 == (5 * (a + 569/2)) / 2 - (5 * d) / 2 - 300000 * b * exp(-2000000 / (1987 * d));
eq5_2 = 0 == (55 * a) / 8 + (5 * d) / 2 - (75 * f) / 8;

%solve eqn 1 for a in terms of f
aa = solve(eq1_2, [a])% a = ((11*f)/15 + 1192/15)
%substitute a = (11*f)/15 + 1192/15into equations
eq2_3 = 0 == 5/2 - 1500 * b * exp(-2000000 / (1987 * d)) - (5 * b) / 2;
eq3_3 = 0 == 1500 * b * exp(-2000000 / (1987 * d)) - (5 * c) / 2;
eq4_3 = 0 == (5 * (((11 * f) / 15 + 1192/15) + 569/2)) / 2 - (5 * d) / 2 - 300000 * b * exp(-2000000 / (1987 * d));
eq5_3 = 0 == (55 * ((11 * f) / 15 + 1192/15)) / 8 + (5 * d) / 2 - (75 * f) / 8;
%solve equation 5 for d in terms of f
dd = solve(eq5_3, [d])% d = ((26*f)/15 - 3278/15)

%substitute d = ((26*f)/15 - 3278/15) into equations
eq2_4 = 0 == 5/2 - 1500 * b * exp(-2000000 / (1987 * ((26 * f) / 15 - 3278/15))) - (5 * b) / 2;
eq3_4 = 0 == 1500 * b * exp(-2000000 / (1987 * ((26 * f) / 15 - 3278/15))) - (5 * c) / 2;
eq4_4 = 0 == (5 * (((11 * f) / 15 + 1192/15) + 569/2)) / 2 - (5 * ((26 * f) / 15 - 3278/15)) / 2 ...
    -300000 * b * exp(-2000000 / (1987 * ((26 * f) / 15 - 3278/15)));

%solve equation 2 for b in terms of f
bb = solve(eq4_1, [b])% b = 5/(2*(1500*exp(-2000000/((51662*f)/15 - 6513386/15)) + 5/2))

%substitute b = (5/(2*(1500*exp(-2000000/((51662*f)/15 - 6513386/15)) + 5/2)))  into equations
eq3_5 = 0 == 1500 * b * exp(-2000000 / (1987 * ((26 * f) / 15 - 3278/15))) - (5 * c) / 2;
eq4_5 = 0 == (5 * (((11 * f) / 15 + 1192/15) + 569/2)) / 2 - (5 * ((26 * f) / 15 - 3278/15)) / 2 ...
    -300000 * (5 / (2 * (1500 * exp(-2000000 / ((51662 * f) / 15 - 6513386/15)) + 5/2))) * exp(-2000000 / (1987 * ((26 * f) / 15 - 3278/15)));

%solve equation eq4_5 for f
ff = solve(eq4_5, [f])% f = 385.57606448902708549365954024068

%Sub f = 385.57606448902708549365954024068 into eq2_4 solve for b
eq2_4 = 0 == 5/2 - 1500 * b * exp(-2000000 / (1987 * ((26 * ff) / 15 - 3278/15))) - (5 * b) / 2;
bb = solve(eq2_4, [b])% b = 0.015380322445135436887717293872624

% sub f = 385.57606448902708549365954024068 into eq to solve for a
eq1_2 = 0 == (55 * ff) / 8 - (75 * a) / 8 + 745;
aa = solve(eq1_2, [a]) % aa = 362.22244729195319602868366284316

% sub a = 0.015380322445135436887717293872624 into eq_6_1 to solve for g
eq6_1 = g == aa + 569/2;
gg = solve(eq6_1,[g])

% sub values into eq2_1 to get d
eq2_1 = 0 == 5/2 - 1500 * bb * exp(-2000000 / (1987 * d)) - (5 * bb) / 2;
dd = solve(eq2_1,[d]) % dd = 449.79851178098028152234320308384

% sub values into eq3_1 to get c
eq3_1 = 0 == 1500 * bb * exp(-2000000 / (1987 * dd)) - (5 * c) / 2;
cc = solve(eq3_1,[c]) % cc = 0.98461967755486456311228270612738

sSSOP = double(transpose([aa,bb,cc,dd,ff])) % steady state calcs from book confirmed 
%%%%%%% note to self -- Dont touch the above its working


V1 = 4;
V3 = 4;
V4 = 4;
v0 = 10;
k = 1.5 * 10^3;
EE = 2 * 10^3;
R = 1.987;
ro = 1000;
Cp = 1;
T0 = 298;
dH = -2 * 10^5;
U = 550;
AA = 50;
QQ = 2.845 * 10^6;
CA0 = 1;

S = transpose([a, b, c, d, f]);

diffEq1 = v0 * (T0 - a) / V1 + U * AA * (f - a) * (ro * Cp * V1)^-1;
diffEq2 = v0 * (CA0 - b) / V3 - k * exp(-1 * EE / (R * d)) * b;
diffEq3 = -v0 * c / V3 + k * exp(-1 * EE / (R * d)) * b;
diffEq4 = v0 * (gg - d) / V3 + ((dH) * k * exp(-1 * EE / (R * d)) * b) / (ro * Cp);
diffEq5 = v0 * (d - f) / V3 - U * AA * (f - a) / (ro * Cp * V4);

F = transpose([diffEq1, diffEq2, diffEq3, diffEq4, diffEq5]);

% a = s(1) so dFds1 = dFda... etc
dFda(a, b, c, d, f)  = diff(F, a, 1);
dFdb(a, b, c, d, f)  = diff(F, b, 1);
dFdc(a, b, c, d, f)  = diff(F, c, 1);
dFdd(a, b, c, d, f)  = diff(F, d, 1);
dFdf(a, b, c, d, f)  = diff(F, f, 1);

A1 =dFda(aa, bb, cc, dd, ff)
A2 =dFdb(aa, bb, cc, dd, ff)
A3 =dFdc(aa, bb, cc, dd, ff)
A4 =dFdd(aa, bb, cc, dd, ff)
A5 =dFdf(aa, bb, cc, dd, ff)

A = double([A1, A2, A3, A4, A5])

% Differential Equations in the form with QQ (our manipulated
% variable)plugged in 
syms Q 

% T2 = T1 + Q/(v0*ro*Cp) -> T2 ==T1 + Q/(v0*ro*Cp)
% T1 = a(Q) = T2 - Q/(v0*ro*Cp) =  (gg - Q/(v0*ro*Cp))
% B = dFdm = dFdQ

diffEq1_ForQ = v0 * (T0 - (gg - Q/(v0*ro*Cp))) / V1 + U * AA * (f - (gg - Q/(v0*ro*Cp))) * (ro * Cp * V1)^-1;
diffEq2_ForQ = v0 * (CA0 - b) / V3 - k * exp(-1 * EE / (R * d)) * b;
diffEq3_ForQ = -v0 * c / V3 + k * exp(-1 * EE / (R * d)) * b;
diffEq4_ForQ = v0 * (gg - d) / V3 + ((dH) * k * exp(-1 * EE / (R * d)) * b) / (ro * Cp);
diffEq5_ForQ = v0 * (d - f) / V3 - U * AA * (f - (gg - Q/(v0*ro*Cp))) / (ro * Cp * V4);

F_ForQ = transpose([diffEq1_ForQ, diffEq2_ForQ, diffEq3_ForQ, diffEq4_ForQ, diffEq5_ForQ]);
dFdQ(a, b, c, d, f, Q)  = diff(F_ForQ, Q, 1);
B = double(dFdQ(aa, bb, cc, dd, ff, QQ))

% T2 = T1 + Q/(v0*ro*Cp) -> T2 ==T1 + Q/(v0*ro*Cp)
% T1 = a(Q) = T2 - Q/(v0*ro*Cp) =  (gg - Q/(v0*ro*Cp))
% C = dFdm = dFdQ
syms ca0
diffEq1_ForCA0 = v0 * (T0 - a) / V1 + U * AA * (f - a) * (ro * Cp * V1)^-1;
diffEq2_ForCA0 = v0 * (ca0 - b) / V3 - k * exp(-1 * EE / (R * d)) * b;
diffEq3_ForCA0 = -v0 * c / V3 + k * exp(-1 * EE / (R * d)) * b;
diffEq4_ForCA0 = v0 * (gg - d) / V3 + ((dH) * k * exp(-1 * EE / (R * d)) * b) / (ro * Cp);
diffEq5_ForCA0 = v0 * (d - f) / V3 - U * AA * (f - a) / (ro * Cp * V4);

F_ForCA0 = transpose([diffEq1_ForCA0, diffEq2_ForCA0, diffEq3_ForCA0, diffEq4_ForCA0, diffEq5_ForCA0]);

dFdCA0(a, b, c, d, f, ca0)  = diff(F_ForCA0, ca0, 1);
G = double(dFdCA0(aa, bb, cc, dd, ff, CA0))

g_economic = (100 * v0 * c) - (5*Q);
h = [g_economic]; %q = h output variables of interest

dhda(c, Q)  = diff(h, a, 1);
dhdb(c, Q)  = diff(h, b, 1);
dhdc(c, Q)  = diff(h, c, 1);
dhdd(c, Q)  = diff(h, d, 1);
dhdf(c, Q)  = diff(h, f, 1);

Dx1 =dhda(cc,QQ);
Dx2 =dhdb(cc,QQ);
Dx3 =dhdc(cc,QQ);
Dx4 =dhdd(cc,QQ);
Dx5 =dhdf(cc,QQ);

Dx = double([Dx1, Dx2, Dx3, Dx4, Dx5])

%m = Q
dhdm(c,Q)  = diff(h, Q, 1);
Du1 =dhdm(cc,QQ);
Du = double([Du1])
%p = CAO
dhdp(c,Q)  = diff(h, ca0, 1);
Dw1 =dhdp(cc,QQ);
Dw = double([Dw1])





%Part iv
g_economic_ss =  (100 * v0 * cc) - (5*QQ);
h_ss = [g_economic_ss];
[t_nlin,s_nlin]=ode45('endo_cstr_ode',[0 20],double(sSSOP));
[t_lin,x_lin]=ode45('endo_cstr_ode_lin',[0 20],sSSOP - sSSOP,1,A,B,G,Dx,Du,Dw,QQ,CA0);
[NN,dumb]=size(t_nlin); 
q_nlin=zeros(NN,2);

for ii=1:NN
[dsdt,qout]=endo_cstr_ode(t_nlin(ii),s_nlin(ii,:)');
q_nlin(ii,:)=qout';
end
[NN,dumb]=size(t_lin); z_lin=zeros(NN,2);
for ii=1:NN
[dxdt,zout]=endo_cstr_ode_lin(t_lin(ii),x_lin(ii,:)',1,A,B,G,Dx,Du,Dw,QQ,CA0);
z_lin(ii,:)=zout';
end

%Plots

plot(t_nlin,s_nlin(:,1),'k',t_lin,x_lin(:,1)+sSSOP(1),'k--');
title('Problem 2.13','FontSize',14,'FontName','Times New Roman');
ylabel('Field Current (A)','FontSize',14,'FontName','Times New Roman');
xlabel('Time (s)','FontSize',14,'FontName','Times New Roman')
legend('Nonlinear','Linear '); pause
plot(t_nlin,s_nlin(:,2),'k',t_lin,x_lin(:,2)+sSSOP(2),'k--')
title('Problem 2.13','FontSize',14,'FontName','Times New Roman');
ylabel('Armature Current (A)','FontSize',14,'FontName','Times New Roman');

% xlabel('Time (s)','FontSize',14,'FontName','Times New Roman')
% legend('Nonlinear','Linear '); pause
% plot(t_nlin,s_nlin(:,3),'k',t_lin,x_lin(:,3)+s_ss(3),'k--')
% title('Problem 2.13','FontSize',14,'FontName','Times New Roman');
% ylabel('Angular Speed (rad/s)','FontSize',14,'FontName','Times New Roman');
% xlabel('Time (s)','FontSize',14,'FontName','Times New Roman')
% legend('Nonlinear','Linear '); pause
% plot(t_nlin,q_nlin(:,1)/1000,'k',t_lin,(z_lin(:,1)+q_ss(1))/1000,'k--')
% title('Problem 2.13','FontSize',14,'FontName','Times New Roman');
% ylabel('Power Electrical (kW)','FontSize',14,'FontName','Times New Roman');
% xlabel('Time (s)','FontSize',14,'FontName','Times New Roman')
% legend('Nonlinear','Linear '); pause
% plot(t_nlin,q_nlin(:,2)/1000,'k',t_lin,(z_lin(:,2)+q_ss(2))/1000,'k--')
% title('Problem 2.13','FontSize',14,'FontName','Times New Roman');
% ylabel('Power Mechanical (kW)','FontSize',14,'FontName','Times New Roman');
% xlabel('Time (s)','FontSize',14,'FontName','Times New Roman')
% legend('Nonlinear','Linear '); pause
