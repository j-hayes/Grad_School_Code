experimentalTValues = transpose([300 325 350 375 400 425 450 475 500]);
experimentalkValues = transpose([1.82 1.89 2.02 2.14 2.12 2.17 2.15 2.21 2.26]);

%part a) setup model
logExperimentalKValues = log(experimentalkValues);
y_aproximated_forPlot =  zeros(1,plot_x_count);
y_aproximated = zeros(10,1);
A = ones(9, 2);
A(:,2) = -1./experimentalTValues;
%part b) calculate least squares values of x 
X_ls = inv(transpose(A)*A) * transpose(A)*logExperimentalKValues;

%part c) is the solution unique ie is nullspace of a empty 
nullSpace = null(A);

%part d plot
b_approximated = A*X_ls;
k_approximated = exp(b_approximated);

plot(experimentalTValues,experimentalkValues,'-k*',experimentalTValues, k_approximated,'-k')
title('Least Squares')
legend('Expiremental Data', 'Least Squares aproximation');
xlabel('T')
ylabel('k')
saveas(gcf,'Least_Squares_arrhenius.png')

% is it a good fit?
errors = (experimentalkValues - k_approximated)./experimentalkValues;

