clear all
syms z
a = .1;
M = [5 , 10, 50,150];
an = zeros(3,50);
aproximation = sym(zeros(3,50));
mm =1;
m1 = 1/a;
m2 = -1/a;
b1 = 1-1/(2*a);
b2 = 1+1/(2*a);
% this could be optimized to not do duplicate calculations but I'm not
% worrying about it for now
while mm <= length(M)
    n = 1;
    MM = M(mm);
    while n <= MM      
       slopeingUpPart = integral1(m1,b1,n,.5) - integral1(m1,b1,n,(0.5-a));
       slopingDownPart = integral1(m2,b2,n,.5+a) - integral1(m2,b2,n,(0.5));
       an(mm,n) = slopeingUpPart + slopingDownPart;   
       aproximation(mm,n) = (2^(1/2))*an(mm,n)*sin(n*pi*z);%times two because the function is normalized with 
       n = n +1;
    end
    mm = mm +1;
end
% 
% 
aproximationFunction = sum(aproximation, 2);

estimated = zeros(3,100);
x_values = zeros(1,100);
j = 1;
while j <= length(M)
    i = 1;
    while i <= 100
        x = (i-1)*.01;
        x_values(i) = x;
        aprx = aproximationFunction(j);
        estimated(j,i) =double(subs(aprx,x)); 
        i=i+1;
    end
    j = j+1;
end
plot(x_values,estimated(1,:),x_values,estimated(2,:),x_values,estimated(3,:),x_values,estimated(4,:));
title('approximation of square function');  
legend('M = 5', 'M = 10', 'M = 50','M = 150')


function integral = integral1(m,b,n,z)
    integral = (2^(1/2))*((-1*(m*z+b)*cos(n*pi*z))/(n*pi) + (m*sin(n*pi*z))/(n*pi)^2);
end
