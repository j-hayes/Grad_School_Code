syms a b d f g

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

bb = solve(eq2_4, [b])% b = 5/(2*(1500*exp(-2000000/((51662*f)/15 - 6513386/15)) + 5/2))

%substitute b = (5/(2*(1500*exp(-2000000/((51662*f)/15 - 6513386/15)) + 5/2)))  into equations
eq3_5 = 0 == 1500 * b * exp(-2000000 / (1987 * ((26 * f) / 15 - 3278/15))) - (5 * c) / 2;
eq4_5 = 0 == (5 * (((11 * f) / 15 + 1192/15) + 569/2)) / 2 - (5 * ((26 * f) / 15 - 3278/15)) / 2 ...
    -300000 * (5 / (2 * (1500 * exp(-2000000 / ((51662 * f) / 15 - 6513386/15)) + 5/2))) * exp(-2000000 / (1987 * ((26 * f) / 15 - 3278/15)));
%solve equation 4 for b in terms of f
ff = solve(eq4, [f])% f = 385.57606448902708549365954024068

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





