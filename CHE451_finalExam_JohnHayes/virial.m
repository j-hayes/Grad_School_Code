function [BB d] = virial(T, Tc, Pc, w)
Tr=T./Tc;
B0=0.083-0.422./Tr.^1.6;
B1=0.139-0.172./Tr.^4.2;
Bhat = B0+w.*B1;
B=Bhat.*Tc./Pc;
for i=1:max(size(Tc))
    for j=1:max(size(Tc))
        BB(i,j)=-sqrt(B(i)*B(j));
    end
end
% calculation for delta(i,j) values
for i=1:3
    for j=1:3
        d(i,j) = 2*BB(i,j) - BB(i,i) - BB(j,j);
    end
end
end