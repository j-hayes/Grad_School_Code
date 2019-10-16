experimentalXValues = transpose([0 .22 .44 .67 .89 1.11 1.33 1.56 1.75 2]);
experimentalYValues = transpose([2.36 2.49 2.67 3.82 4.87 6.28 8.23 9.47 12.01 15.26]);
PHI = zeros(10,1);
plot_x_count = 75;

y_aproximated_forPlot =  zeros(1,plot_x_count);
xPolyNomial = linspace(-.25,2.25,plot_x_count);
y_aproximated = zeros(10,1);

for n = 0:9
    A = ones(10, n+1);
    
    for j = 0:n
        A(:,j+1) = experimentalXValues.^(n-j);
    end
    a = inv(transpose(A)*A) * transpose(A)*experimentalYValues;
    
    for j = 1:10
        y_polyNomialParts = zeros(1,n+1);
        for i = 0:n
            y_polyNomialParts(i+1) = a(i+1)*experimentalXValues(j)^(n-i);
        end
        y_aproximated(j) = sum(y_polyNomialParts);
    end
    
    PHI(n+1) = sum((experimentalYValues - y_aproximated).^2);
    
    
    for j = 1:plot_x_count % calculate a bunch for a nicer plot
        y_polyNomialParts = zeros(1,n+1);
        for i = 0:n
            y_polyNomialParts(i+1) = a(i+1)*xPolyNomial(j)^(n-i);
        end
        y_aproximated_forPlot(j) = sum(y_polyNomialParts);
    end
    plot(experimentalXValues,experimentalYValues,'-k*',xPolyNomial, y_aproximated_forPlot,'-k')
    title(sprintf('Least Squares n =%d',n))
    legend('Expiremental Data', 'Least Squares aproximation');
    xlabel('X')
    ylabel('Y')
    saveas(gcf,sprintf('Least_Squares_nequal%d.png',n));
end

plot(linspace(0,9,10),PHI,'*')
title('PHI vs n');
xlabel('PHI_n')
ylabel('n')
saveas(gcf,'phivsn.png');