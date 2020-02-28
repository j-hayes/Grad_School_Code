
function [M, rankA, numberOfIndependentReactions] = GetMolecularMatrix(A, Species)

rankA = rank(A);
[numberOfSpecies,cols] = size(Species);
numberOfIndependentReactions =  numberOfSpecies - rankA;
ATransp = transpose(A);
rankATransp = rank(ATransp);
rowEschATransp = rref(ATransp);
[rows,cols] = size(ATransp);
s = sym('s',[rankA 1]);
i =1;
sIndex = 1;
while i < cols && sIndex <= rankA
    column = rowEschATransp(:,i);
    sumOfColumn = sum(column);
    if sumOfColumn == 1  %linearly Independent
        s(sIndex) = Species(i);
        sIndex= sIndex+1;
    end
    i = i+1;
end
M = transpose(rowEschATransp)*s;
end