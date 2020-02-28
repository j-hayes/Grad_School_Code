syms C9H12 H2 CH4 C8H10 C7H8 C6H6 C6H5_2
syms R_C9H12 R_H2 R_CH4 R_C8H10 R_C7H8 R_C6H6 R_C6H5_2

AllSpecies = [H2; CH4; C9H12; C8H10; C7H8; C6H6; C6H5_2];
NetGenerationRates = [R_H2; R_CH4; R_C9H12; R_C8H10; R_C7H8; R_C6H6; R_C6H5_2];

%Atomic Matrix Col 1 => C Col2 =H
m = 2;%number of atomic species
[n,cols] = size(AllSpecies);
AtomicMatrix = [0 2; 1 4; 9 12; 8 10; 7 8; 6 6; 12 10];

[M, rankAtomicMatrix, numberOfIndependentReactionsFromAtomic] = GetMolecularMatrix(AtomicMatrix, AllSpecies);
stoichiometricMatrix = ...
    [-1 -1 -1 -1;
    1 1 1 2;
    -1 0 0 0;
    1 -1 0 0;
    0 1 -1 -2;
    0 0 1 0;
    0 0 0 1];
elementaryReactions = AllSpecies - M;
rankStoichiometricMatrix = rank(stoichiometricMatrix);
numberOfIndependentReactionsFromStoichiometric = rankStoichiometricMatrix; % naming convenience


% append missing reaction to stoichiometricMatrix
% otherReactionColumn = [12; -9; 1; 0; 0; 0; 0;];
% stoichiometricMatrix = [stoichiometricMatrix otherReactionColumn];

%check that relatrion holds should be zero equation 3.8
check1 = transpose(stoichiometricMatrix)*M;
check2 = transpose(stoichiometricMatrix)*AtomicMatrix;

if sum(check1) + sum(check2) > 0
    error = 'error these should have been zero'
    return
end

i =1;
AllRatesOfReactions = sym('s',[numberOfIndependentReactionsFromAtomic 1]);
while i<=numberOfIndependentReactionsFromAtomic
    AllRatesOfReactions(i) = sym(sprintf('r%d',i));
    i=i+1;
end

%procedure to build up C from equation 3.9 and identify independent
%reactions
rrefStoichiometricMatrix = rref(stoichiometricMatrix);
[rows, cols] = size(rrefStoichiometricMatrix);
i = 1;
cIndex = 1;
c = sym('c',[n 1]);
while i <= n
    c(i)=0;
    i = i+1;
end
ratesOfGenerationSpecies = sym('R',[p 1]);
i=1;
while i<=p
    ratesOfGenerationSpecies(i) = sym(sprintf('R%d',i));
    i=i+1;
end



i = 1;
while i <= cols && cIndex <= rankStoichiometricMatrix
    column = rrefStoichiometricMatrix(:,i);
    sumOfColumn = sum(column);
    if sumOfColumn == 1 %linearly Independent
        c(cIndex) = ratesOfGenerationSpecies(i);
        cIndex= cIndex+1;
    end    
    i=i+1;
end
rrefStoichMTranspose = transpose(rrefStoichiometricMatrix);
C = rrefStoichMTranspose*c;
indepentAtomicSpeciesRelations = C(1:(n-rankStoichiometricMatrix));
[p, rows] = size(C); % 

% build up R to identify the independent rates of formation 
rpIndex = 1;
i = 1;
Rp = sym('s',[p 1]);
while i <= p
    Rp(i)=0;
    i = i+1;
end


i =1;

while i <= p && rpIndex <= rankStoichiometricMatrix
    column = rrefStoichMTranspose(:,i);
    sumOfColumn = sum(column);
    if sumOfColumn == 1 %linearly Independent
        Rp(rpIndex) = AllRatesOfReactions(i);
        rpIndex= rpIndex+1;
    end    
    i=i+1;
end

RatesVector = transpose(rrefStoichMTranspose)*Rp; %R


independentRatesOfReactions = RatesVector(1:(rankStoichiometricMatrix));
SpeciesRates = stoichiometricMatrix*independentRatesOfReactions;

check3_11 = transpose(AtomicMatrix)*SpeciesRates;
 
if sum(check3_11) ~= 0
    error = 'error these should have been zero';
    return
end


%output for print
AtomicMatrix
rankAtomicMatrix
stoichiometricMatrix
numberOfIndependentReactionsFromStoichiometric
numberOfIndependentReactionsFromAtomic
elementaryReactions
AllSpecies
SpeciesRates


