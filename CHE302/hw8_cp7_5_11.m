format long % lets the console output have more decimal places shown

solvingFunction = @solveForNa;
x0 = [.01];
x = fsolve(solvingFunction,x0)

%solvingFunction([1.766*10^-4]);