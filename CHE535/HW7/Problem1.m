clear all;

[alpha_part2, A_part2, b_part2, Tn_part2] = problem1(10,1,3);
[alpha_part5, A_part5, b_part5, Tn_part5] =problem1(0,1,3);
[alpha_part6, A_part6, b_part6, Tn_part6]= problem1(10,1,10);
[alpha_part7_low, A_part7_low, b_part7_low, Tn_part7_low]= problem1(10,.05,10);
[alpha_part7_high, A_part7_high, b_part7_high, Tn_part7_high]= problem1(10,5,10);


subplot(4,3,[1,3])
fplot(Tn_part2,[0,1]);
ylabel('T Kelvin')
xlabel('z')
title('problem 1 part 2 h=1;g=10;N=3');  


subplot(4,3,[4,6])
fplot(Tn_part5,[0,1]);
ylabel('T Kelvin')
xlabel('z')
title('problem 1 part 5 h=1;g=0;N=3');  

subplot(4,3,[7,9])
fplot(Tn_part6,[0,1]);
ylabel('T Kelvin')
xlabel('z')
title('problem 1 part 6 h=1;g=10;N=10');  



subplot(4,3,10)

fplot(Tn_part7_low,[0,1]);
title('problem 1 part 7 h=.05 g=10 N=10');
ylabel('T Kelvin')
xlabel('z')

subplot(4,3,11)
fplot(Tn_part6,[0,1]);
ylabel('T Kelvin')
xlabel('z')
title('problem 1 part 7 h=1 g=10 N=10');

subplot(4,3,12)
fplot(Tn_part7_high,[0,1]);
ylabel('T Kelvin')
xlabel('z')
title('problem 1 part 7 h=5 g=10 N=10');




function [alpha, A, b, Tn] = problem1(g,h, N)
syms z;
i = 1:1:N;
wi = sym((1-i).*pi);
lambda = -(wi.^2);
Tr = 303;

A = sym(zeros(N,N));
b = sym(zeros(N,1));
phi = sym(zeros(N,1));
phi(1) = 1*cos(0*z);
b(1) = (1/h)*(-1*getInnerProduct(g,phi(1)) + Tr*phi(1));

j = 1;
while j <= N
    if j > 1
        phi(j) = 2^(1/2)*cos((j-1)*pi*z);
        b(j) = (1/h)*(-1*getInnerProduct(g,phi(j)) + Tr*subs(phi(j),1));
    end
     j = j +1;
end
i =1;
while i <= N
j = 1;
    while j <= N 
        if i == j
            A(j,i) = lambda(i) + h*subs(phi(j),1);        
        elseif i == 1
            A(j,i) = h*subs(phi(j),1);          
        else            
            A(j,i) = h*2^(1/2)*subs(phi(j),1);
        end        
        j = j+1;
    end


i = i +1;
end



alpha = A\b; % x = (A^-1)b
Tn = sum(alpha.*phi);


end
function innerProduct = getInnerProduct(g, phi)
syms z
innerProduct = int(g*phi,[0 1]);
end

