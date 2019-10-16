experimentalXValues = transpose([0 .22 .44 .67 .89 1.11 1.33 1.56 1.75 2]);
experimentalYValues = transpose([2.36 2.49 2.67 3.82 4.87 6.28 8.23 9.47 12.01 15.26]);
PHI = zeros(9);
y_aproximated =  zeros(1,50);
xPolyNomial = linspace(0,2,50);

for n = 0:9
    A = ones(10, n+1);
    
    for j = 0:n
        A(:,j+1) = experimentalXValues.^(n-j);
    end
    a = inv(transpose(A)*A) * transpose(A)*experimentalYValues;
   
    for j = 1:50
        y_polyNomialParts = zeros(1,n+1);
        for i = 0:n
            y_polyNomialParts(i+1) = a(i+1)*xPolyNomial(j)^(n-i);
        end
        y_aproximated(j) = sum(y_polyNomialParts);
    end
    plot(experimentalXValues,experimentalYValues,'-k*',xPolyNomial, y_aproximated,'-k')

end


 % PHI(n) = sum(x_leastSquares);