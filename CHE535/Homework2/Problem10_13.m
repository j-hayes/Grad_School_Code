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

sSSOP = transpose([aa,bb,cc,dd,ff,gg]) %
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

A = [A1, A2, A3, A4, A5]

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
B = dFdQ(aa, bb, cc, dd, ff, QQ)

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
C = dFdCA0(aa, bb, cc, dd, ff, CA0)

%Part iv

