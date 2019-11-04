clear all
syms x k Pe

lambda = -k^2*pi-Pe^2/4;
phi = exp(Pe*x/2)*sin(k*pi*x)


innerProduct = weightedInnerProduct(lambda,phi)
%verify that the eigen functions are orthoignal with respect to w = exp(-Pe x);



function result = weightedInnerProduct(u,v,Pe)
    syms x k Pe
    w = exp(-Pe*x);
    expression = u*v*w;
    result = int(expression, 0,1);
end
