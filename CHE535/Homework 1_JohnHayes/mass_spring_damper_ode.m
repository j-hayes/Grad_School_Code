%Table 2.5: Linear model for Example 2.8
function [dxdt,zout]= mass_spring_damper_ode(t,x)


A=[0,0,0,1,0,0
   0,0,0,0,1,0
   0 ,0,0,0,0,1
   -.1,.1,0,-.05,.05,0
   .001,-.201,.2,.0005,-.0305,.03;
   0,2,-2,0,.3,-.3;
   ];
B=[0,0;
   0,0
   0,0
   1,0
   -.01,.01
   0,-.1];

G=[0
    0
    0
    0
    0
    0.1];

% Linear Continuous-time Model
Dx = zeros(6);
Dx(1,1) = 1;
Dx(2,2) = 1;
Dx(3,3) = 1;

Du = zeros(6,2);
Du(5,1) = 1;
Du(6,2) = 1;
Dw = zeros(6,1);
u=[0; 0]; %problem statement u always = 0
w=0; % problem statement w always = 0


dxdt=A*x+ B*u+G*w;
zout=Dx*x+Du*u+Dw*w;
end