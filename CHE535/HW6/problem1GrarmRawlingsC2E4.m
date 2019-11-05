clear all
syms t

f = 1/t;
phi = [t^0; t; t^2; t^3; t^4];
q = [sym(0);sym(0);sym(0);sym(0);sym(0)];
alpha = [sym(0);sym(0);sym(0);sym(0);sym(0)];

%part b gram schmit orthogonalization 
q(1) = phi(1);
i = 1;
while i <= 5
    j = 1;
    q(i) = phi(i);
    while j < i && i > 1
        Sij = (weightedInnerProduct(phi(i),q(j))/weightedInnerProduct(q(j),q(j)))*q(j);
        q(i) = q(i) - Sij;
        j = j+1;
    end
    alpha(i) = weightedInnerProduct(f, q(i));%part c calculate alphas
    i = i + 1;
end 


%apply alphas to create aproximation function
k = 1;
aproximations = [sym(0);sym(0);sym(0);sym(0);sym(0)];
while k <= 5 
    aproximations(k) = alpha(k)*q(k);
    k=k+1;
end
aproximationFunction = sum(aproximations)

%calculate errors
l=1;
errors = [];
while l < 500
    x = l*.01;
    actual(l) = 1/x;
    estimated(l) = double(subs(aproximationFunction,x));
    errors(l) = abs((actual(l) - estimated(l))/actual(l));
    x_values(l) = x;
    l=l+1;
end

subplot(2,1,1);
plot(x_values,actual,x_values,estimated);
title('approximation of 1/t');  
legend('actual','aproximation')

subplot(2,1,2)
plot(x_values, errors);
title('Errors');
legend('percent error')


function result = weightedInnerProduct(u,v)
    syms t
    w = t^2;
    expression = u*v*w;
    result = int(expression, 0,1);
end
