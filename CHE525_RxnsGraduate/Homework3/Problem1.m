syms CH4 H2 C2H4 C2H6 C3H6 C3H8 C4H8 C4H10
AllSpecies = [CH4; H2; C2H4; C2H6; C3H6; C3H8; C4H8; C4H10];

%Atomic Matrix Col 1 => C Col2 =H
AtomicMatrix = [1 4; 0 2; 2 4; 2 6; 3 6; 3 8; 4 8; 4 10];

[M, rankA, numberOfIndependentReactions] = GetMolecularMatrix(AtomicMatrix, AllSpecies);
Reactions = AllSpecies - M;

   


%output for print
M
rankA
numberOfIndependentReactions
Reactions
