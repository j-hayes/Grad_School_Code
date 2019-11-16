clear all
syms z
alpha1 = 303;
sqrt2 = 2^(1/2);
fortysqrt2 = 40*sqrt2;
pisqrd = pi^2;
phi = [1; sqrt2*cos(pi*z);sqrt2*cos(2*pi*z);sqrt2*cos(3*pi*z)];
T = alpha1*phi(1);
T = T + fortysqrt2/pisqrd/(pi^2)*phi(2);
T = T + fortysqrt2/(4*pisqrd)/(3*pisqrd)*phi(3);
T = T + fortysqrt2/(9*pisqrd)/(9*pi)*phi(4);

i = 1;
z = zeros(1,101);
temp = zeros(1,101);
while i <= 101
    z(i) = (i-1)*.01;
    temp(i) = double(subs(T,z(i))); 
    i = i+1;
end
plot(z,temp);
xlabel('z')
ylabel('T (Kelvin)')

    
