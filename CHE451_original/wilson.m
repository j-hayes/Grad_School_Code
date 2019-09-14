%code provided by Dr. Perez-Luna Unmodified

function g = wilson(x, a, V, RT)
N=max(size(V)); % number of components
for i=1:N
    for j=1:N
        if i ~= j
            L(i,j)=V(j)/V(i)*exp(-a(i,j)/RT);
        end
    end
end
s1=0;
s2=0;
s3=0;
for i=1:N
    for k=1:N        
        for j=1:N
            s1=s1+x(j)*L(i,j);
            s2 = s2 + x(j)*L(k,j);
        end
        s3 = x(k)*L(k,i);
    end
    lg(i) = 1-log(s1)-s3/s2;
end
g=exp(lg)';
