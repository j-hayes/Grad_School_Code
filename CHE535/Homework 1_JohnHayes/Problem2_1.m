% adapted from CODE from ChmielewsiZhang Chapter 2 Page 33

clear

h0 = 1; %assume initial tank height of 1m^2\
sSsop = 2;
hSsop = 2;
mSsop = sqrt(1.2) * .01;
pSsop = 1;

[tt2, xxode2] = ode23(@(t, x) surgeTank(t, x, hSsop, mSsop, pSsop), [0 300], h0);

plot(tt2, xxode2, '-^k', 'MarkerSize', 8)
legend('Linearized Solution')
ylabel('height of tank'), xlabel('time')

%Table 2.2: MATLAB code used in calculations for Example 2.6
function dsdt = surgeTank(t, s, sSsop, mSsop, pSsop)
    %%some variation in flow rate in p
    if t > 100 %steady state acheived 
        p = pSsop;%m/s 
        m = mSsop
    elseif t < 50 
        p = .95 * pSsop %m/s
        m = mSsop * .9;
    elseif t > 20
        p = 1.12 * pSsop; %m/s
        m = mSsop * 1.2;
    else
        p = .5 * pSsop; %m/s
        m = 1.5 * mSsop; %%
    end
    
    
    

    x = s(1);
    A = mSsop * (sSsop^(-1/2));
    B = -1 * sSsop^(1/2);
    G = 1;
    x = s - sSsop;
    u = m - mSsop;
    w = p - pSsop;
    dsdt = A * x + B * u + G * w;

end
