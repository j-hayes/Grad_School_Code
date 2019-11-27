clear all;
syms z;

[alpha_part2, alphaDot_part2, A_part2, b_part2, Tn_steadyState_part2, phi_part2,range_part2] = problem2(10,1,3);
[alpha_part4, alphaDot_part4, A_part4, b_part4, Tn_steadyState_part4, phi_part4,range_part4] = problem2(10,1,10);

% simulation using Explicit Euler method dxdt = Ax + bu; u = 1
dt = .001; % this is really really slow, I noticed as N increases dt has to decrease to give an accurate readout;
% there is obviously a better way to solve dxdt = Ax + bu in matlab but I didn't know
% it off the top of my head when writing this. 
numberOfSimulations = 8500*2;
alpha_simulation = zeros(3, numberOfSimulations);
alpha_simulation_part4 = zeros(10, numberOfSimulations);

Ad = vpa(eye(3) + dt*A_part2);
Bd = vpa(dt*b_part2);

Ad_part4 = vpa(eye(10) + dt*A_part4);
Bd_part4 = vpa(dt*b_part4);

i =1;
alpha_simulation(:,1) = [303;0;0];
alpha_simulation_part4(:,1) = [303;0;0;0;0;0;0;0;0;0];
while i <= numberOfSimulations
    alphas = Ad*alpha_simulation(:,i) + Bd;
    alpha_simulation(:,i+1) = alphas;
    
     alphas_part4 = Ad_part4*alpha_simulation_part4(:,i) + Bd_part4;
     alpha_simulation_part4(:,i+1) = alphas_part4;
    
    i = i+1;
end
Tn_part2 = sum(alpha_simulation.*phi_part2(1:3));
Tn_part4 = sum(alpha_simulation_part4.*phi_part4);


subplot(4,1,1)
fplot(Tn_steadyState_part2,[0,1]);
ylabel('T Kelvin')
xlabel('z')
title('problem 2 part 2 steady state h=1;g=10;N=3');  

subplot(4,1,2)
fplot(Tn_part2(1),[0,1]);
ylabel('T Kelvin')
xlabel('z')
title('problem 2 part 2 t=0 h=1;g=10;N=3');  

subplot(4,1,3)
fplot(Tn_part2(1000),[0,1]);
title('problem 2 part 2 t=1 h=1;g=10;N=3');  
ylabel('T Kelvin')
xlabel('z')

subplot(4,1,4)
fplot(Tn_part2(numberOfSimulations),[0,1]);
ylabel('T Kelvin')
xlabel('z')
title('problem 2 part 2 t=8.5 h=1;g=10;N=3');  
%break


subplot(4,1,1)
fplot(Tn_steadyState_part4,[0,1]);
ylabel('T Kelvin')
xlabel('z')
title('problem 2 part 4 steady state h=1;g=10;N=3');  

subplot(4,1,2)
fplot(Tn_part4(1),[0,1]);
ylabel('T Kelvin')
xlabel('z')
title('problem 2 part 4 t=0 h=1;g=10;N=3');  

subplot(4,1,3)
fplot(Tn_part4(1000),[0,1]);
title('problem 2 part 4 t=1 h=1;g=10;N=3');  
ylabel('T Kelvin')
xlabel('z')

subplot(4,1,4)
fplot(Tn_part4(numberOfSimulations),[0,1]);
title('problem 2 part 4 t=8.5 h=1;g=10;N=3');  
ylabel('T Kelvin')
xlabel('z')


function [alpha, alphaDot, A, b, Tn_steadyState,phi, range] = problem2(g,h, N)
syms z;
i = 1:1:N;
wi = sym((1-i).*pi);
lambda = -(wi.^2);
Tr = 303;
h = sym(h);
A = sym(zeros(N,N));
b = sym(zeros(N,1));
phi = sym(zeros(N,1));
phi(1) = 1*cos(0*z);
b(1) = getInnerProduct(g,phi(1)) + Tr*h;
alphaDot = sym(zeros(N,1));
alpha = sym(zeros(N,1));

j = 1;
while j <= N
    if j > 1
        phi(j) = 2^(1/2)*cos((j-1)*pi*z);
        b(j) = getInnerProduct(g,phi(j)) + Tr*h;
    end
     j = j +1;
end
i =1;
while i <= N
j = 1;
    while j <= N 
        if i == j
            A(j,i) = lambda(i) - h; 
        else            
            A(j,i) = -h;
        end        
        j = j+1;
    end


i = i +1;
end

range = colspace(A);
alphaSteadyState = A\(-1*b);
Tn_steadyState = sum(alphaSteadyState.*phi);

end
function innerProduct = getInnerProduct(g, phi)
syms z
innerProduct = int(g*phi,[0 1]);
end

