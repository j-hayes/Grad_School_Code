syms z
a = .1;
M = [5,10,50];
an = zeros(3,50);
aproximation = sym(zeros(3,50));
mm =1;
while mm <= 3
    n = 1;
    MM = M(mm);
    while n <= MM
       m1 = 1/a;
       m2 = -1/a;
       b = 1;
       slopeingUpPart = integral1(m1,b,n,.5) - integral1(m1,b,n,(0.5-a));
       slopingDownPart = integral1(m2,b,n,.5+a) - integral1(m2,b,n,(0.5));
       an(mm,n) = slopeingUpPart + slopingDownPart;   
       aproximation(mm,n) = an(mm,n)*sin(n*pi*z);
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


estimated = zeros(3,1000);
x_values = zeros(1000);
j = 1;
while j <= 3
    i = 1;
    while i < 1000
        x = (i-1)*.001;
        x_values(i) = x;
        if x < (.5 - a) || x > (.5 + a)
            estimated(j,i) = 0;
        else 
            aprx = aproximationFunction(j);
            estimated(j,i) = double(subs(aprx,x));
        end

        i=i+1;
    end
    j = j+1;
end
plot(x_values,estimated(1,:),x_values,estimated(2,:),x_values,estimated(3,:));
title('approximation of square function');  
legend('M = 5', 'M=10', 'M = 50')


function integral = integral1(m,b,n,z)
    integral = -1*m*z+b/(n*pi)*cos(m*pi*z) + m/(n*pi)^2*sin(n*pi*z);
end
