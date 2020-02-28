fplot(@(T) cvv(T), [0,20]);
function out = cvv(T)

N = 1;
k=1;
omega = 1;
p =100;
lambda = .001;
h = lambda*p;
hbar = h/(2*3.314159);
eps = hbar*omega;
const = 3*N*k*(eps/(k*T))^2;
fNum = exp(eps/(k*T));
fDenom = (exp(eps/(k*T))-1)^2;

threekn = 3*N*k;
out = const*fNum/fDenom;

end