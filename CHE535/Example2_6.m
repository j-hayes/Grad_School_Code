% CODE from ChmielewsiZhang Chapter 2 Page 33

clear
V=3;k=0.1;CAinbar=1;CAbar=0.3;
nubar=2*k*CAbar^2*V/(CAinbar-CAbar); x0=0.2;
% Calculate solution with nonliner ODE
linearize='n';
[tt1,xxode1]=ode23(@(t,x) cstr(t,x,linearize,V,k,CAbar,nubar,CAinbar),...
    [0 150],x0);
% Calculate solution with linearized ODE
linearize='y';
[tt2,xxode2]=ode23(@(t,x) cstr(t,x,linearize,V,k,CAbar,nubar,CAinbar),...
    [0 150],x0);
%xxode=zzode(:,1); yyode=zzode(:,2);
plot(tt1,xxode1,'-*b',tt2,xxode2,'-^k','MarkerSize',8)
legend('Nonlinear Solution','Linearized Solution')
ylabel('Concentration of A'), xlabel('time')

%Table 2.2: MATLAB code used in calculations for Example 2.6
function dsdt = cstr(t,s,linearize,V,k,CAbar,nubar,CAinbar)
% This function should be in a file named 'cstr.m'
CA=s(1); nu=nubar; CAin=CAinbar;
if t > 50 CAin = 0.5, end
if t > 100 nu=0.15, end
if linearize=='y'
    A=-nubar/V-4*k*CAbar, B=(CAinbar-CAbar)/V, G=nubar/V,
    x=CA-CAbar; u=nu-nubar; w=CAin-CAinbar;
    dsdt=A*x+B*u+G*w;
else
    dsdt=CAin*nu/V-CA*nu/V-2*k*CA^2;
end
end
