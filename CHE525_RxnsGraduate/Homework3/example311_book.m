syms C O2 CO CO2 N2
Species = [C; O2; CO; CO2; N2];

A = [1 0 0; 0 2 0; 1 1 0; 1 2 0; 0 0 2];
rankA = rank(A)
ATransp = transpose(A)
rankATransp = rank(ATransp)
rowEschATransp = rref(ATransp)

[cols,rows] = size(A);
s = sym('s',[rankA 1]);
i =1;
sIndex = 1;
while i <= cols && sIndex <= rankA
    column = rowEschATransp(:,i);
    sumOfColumn = sum(column);
    if sumOfColumn == 1
        s(sIndex) = Species(i); 
        sIndex= sIndex+1;
    end
    i = i+1;
end


M = transpose(rowEschATransp)*s
Reactions = Species - M