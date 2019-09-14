format long % lets the console output have more decimal places shown

solvingFunction = @solvePressureDifference;
x0 = [3];
x = fsolve(solvingFunction,x0)