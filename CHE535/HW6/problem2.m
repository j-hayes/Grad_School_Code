clear all
syms z
a = .1;
M = [5,10,50];
an = zeros(3,50);
aproximation = sym(zeros(3,50));
mm =1;
m1 = 1/a;
m2 = -1/a;
b1 = 1-1/(2*a);
b2 = 1+1/(2*a);
% this could be optimized to not do duplicate calculations but I'm not
% worrying about it for now
while mm <= 3
    n = 1;
    MM = M(mm);
    while n <= MM      
       slopeingUpPart = integral1(m1,b1,n,.5) - integral1(m1,b1,n,(0.5-a));
       slopingDownPart = integral1(m2,b2,n,.5+a) - integral1(m2,b2,n,(0.5));
       an(mm,n) = slopeingUpPart + slopingDownPart;   
       aproximation(mm,n) = 2*an(mm,n)*sin(n*pi*z);
       n = n +1;
    end
    mm = mm +1;
end
% 
% 
aproximationFunction = sum(aproximation, 2);
% 
% fplot(aproximationFunction, [0 1]);
% title('approximation of triangle function');  


estimated = zeros(3,100);
x_values = zeros(1,100);
j = 1;
while j <= 3
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
plot(x_values,estimated(1,:),x_values,estimated(2,:),x_values,estimated(3,:));
title('approximation of square function');  
legend('M = 5', 'M = 10', 'M = 50')


function integral = integral1(m,b,n,z)
    integral = (-1*(m*z+b)*cos(n*pi*z))/(n*pi) + (m*sin(n*pi*z))/(n*pi)^2;
end
