clear all;

Ta=350;
UA=100;
V=2000;
H1b=-5000;
H2c=10000;
H3b=-50000;
k1a=10^-3;
k2a=(1/3)*10^-3;
k3c=.6*10^-3;
Cpa=10;
Cpb=10;
Cpc=50;
Cpd=80;
Cpe=50;

i=1;
T(i)=450;
Ca(i)=1;
Cb(i)=0.5;
Cc(i)=0.2;
Cd(i)=0;
Ce(i)=0;

t(i)=0;
dt= .1;
tf=1000;

while t(i) <= tf 

    r1a=-k1a*Ca(i)*Cb(i)^2;
    r2a=-k2a*Ca(i)*Cc(i);
    r3c=-k3c*Cb(i)*Cc(i);
    
    dCadt= r1a+r2a;
    dCa= dCadt*dt;
    
    dCbdt= 2*r1a+(1/3)*r3c;
    dCb= dCbdt*dt;
    
    dCcdt= -r1a+(3/2)*r2a+r3c;
    dCc= dCcdt*dt;
    
    dCddt= -(1/2)*r2a;
    dCd= dCddt*dt;
    
    dCedt= -(1/3)*r3c;
    dCe= dCedt*dt;
    
    dTdt= (V*(2*r1a*-H1b+(3/2)*r2a*-H2c+(1/3)*r3c*-H3b)-UA*(T(i)-Ta))/(V*(Ca(i)*Cpa+Cb(i)*Cpb+Cc(i)*Cpc+Cd(i)*Cpd+Ce(i)*Cpe));
    dT= dTdt*dt;
    
    Ca(i+1)= Ca(i)+ dCa;
    Cb(i+1)= Cb(i)+ dCb;
    Cc(i+1)= Cc(i)+ dCc;
    Cd(i+1)= Cd(i)+ dCd;
    Ce(i+1)= Ce(i)+ dCe;
    T(i+1)= T(i)+dT;
    t(i+1)=t(i)+dt;
    i=i+1;
end
    
subplot(2,1,1)
plot(t, Ca,t, Cb,t, Cc,t, Cd,t,Ce)
legend('Ca','Cb','Cc','Cd','Ce')
xlabel('time seconds')
ylabel('Concentration')

subplot(2,1,2)
plot(t,T)
xlabel('time seconds')
ylabel('Temperature(K)')

