function [dsdt,qout]= endo_cstr_ode(t,s,Case)
    % Motor Parameters
    Lf=50; %H
    Rf=25; %ohms
    La=2; %H
    Ra=0.5; %ohms
    Kv=0.91; %V/(A rad/s)
    J=5; %Nm
    B=0.3; %J/(rad/s)
    %Inputs at Steady-State
    m1=36; %V
    m2=360; %V
    p=-280; %Nm=J
    
    if (Case == 1) %Case 1
    if t > 10; m1=38; end
    if t > 50; m1=34; end
    else % %Case 2
    if t > 10; m1=56; end
    if t > 50; m1=26; end
    end
    ds1dt=( - Rf*s(1) + m1 )/Lf;
    ds2dt=( - Ra*s(2) - Kv*s(3)*s(1) + m2 )/La;
    ds3dt=( - B*s(3) + Kv*s(1)*s(2) + p )/J;
    dsdt=[ds1dt;ds2dt;ds3dt];
    qout=[s(1)*m1+s(2)*m2; s(3)*p];
    end
    