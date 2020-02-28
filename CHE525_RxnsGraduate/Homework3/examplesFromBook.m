syms N H 
s = [N ; H]
A = [2 0; 0 2; 1 3;];
rankA = rank(A)
ATransp = transpose(A)
rankATransp = rank(ATransp)
rowEschATransp = rref(ATransp)
M = transpose(rowEschATransp)*s