classdef cubicEos < handle
    %generic cubic equation of state implementation
    %  genericly solve for Pressure and store other variables such as
    % Zl and Zv
    %Adapted from sample code given by Dr. Perez-Luna
    
    properties
        P;
        R;
        T;
        Tc;
        Pc;
        Tr;
        Pr;
        accentricFactor;
        epsilon;
        omega;
        psi;
        Zc;
        sigma;
        b;
        alpha;
        a;
        beta;
        q;
        Zl;
        Zv;
        Vv;
        Vl;
        L;
        V;
        Iv;
        Il;
        cubicEquationName;
        err = [];
    end
    
    methods
        function obj = cubicEos(R,T,P,Tc,Pc,accentricFactor,cubicEquationName)
            %CUBICEOS Construct an instance of this class
            obj.R = R;
            obj.T = T;
            obj.Pc = Pc;
            obj.Tc = Tc;
            obj.Tr = T/Tc;
            obj.Pr = P/Pc;
            obj.accentricFactor = accentricFactor;
            obj.cubicEquationName = cubicEquationName;
            if strcmp(cubicEquationName,'peng robinson') == 1
                obj.alpha=(1+(0.37464+1.54226*accentricFactor-0.26992*accentricFactor^2)*(1-sqrt(obj.Tr)))^2;
                obj.sigma = 1+sqrt(2);
                obj.epsilon = 1-sqrt(2);                
                obj.omega = 0.07780;
                obj.psi = 0.45724;  
             elseif strcmp(cubicEquationName,'SRK') == 1
                obj.alpha=(1+(0.480+1.574*accentricFactor-0.176*accentricFactor^2)*(1-sqrt(obj.Tr)))^2;
                obj.sigma = 1;
                obj.epsilon =0;             
                obj.omega = 0.08664;
                obj.psi = 0.42748;  
            elseif strcmp(cubicEquationName,'van der waals') == 1
                obj.alpha=1;
                obj.sigma = 0;
                obj.epsilon =0;                
                obj.omega = 1/8;
                obj.psi = 27/64;                     
            end       
            obj.a=obj.psi*obj.alpha*obj.R^2*obj.Tc^2/obj.Pc;
            obj.b = obj.omega*obj.R*obj.Tc/obj.Pc;         
        end
        
        function err = calculateVaporPressureError(obj,P)
            %reset variables that need to be reset each iteration of check
            obj.P = P;
            obj.Pr = P/obj.Pc;
            
            obj.beta=obj.b*P/obj.R/obj.T;
            obj.q=obj.a/obj.b/obj.R/obj.T;
            
            obj.Zl=obj.beta;%initial gess for liquid compressibility
            obj.Zv=1;%ideal gas as initial vapor compressibility
            
            
            % The loops below are just to facilitate our work. Convergence to a solution is
            % achieved in only a few iterations (it can be done by hand). There is no
            % need to do 1000 loops
            for i=1:10
                obj.Zl=obj.beta+(obj.Zl+(obj.epsilon*obj.beta))*(obj.Zl+(obj.sigma*obj.beta))*(1+obj.beta-obj.Zl)/(obj.q*obj.beta);
            end           
            
            for i=1:10
                obj.Zv=1+obj.beta-obj.q*obj.beta*(obj.Zv-obj.beta)/(obj.Zv+obj.epsilon*obj.beta)/(obj.Zv+obj.sigma*obj.beta);
            end
            
            if strcmp(obj.cubicEquationName,'van der waals') == 1
                obj.Iv = obj.beta/obj.Zv; %page 396 and 218 Ii = Betai/Zi
                obj.Il = obj.beta/obj.Zl;
            else
                obj.Iv=1/(obj.sigma-obj.epsilon)*log((obj.Zv+obj.sigma*obj.beta)/(obj.Zv+obj.epsilon*obj.beta));
                obj.Il=1/(obj.sigma-obj.epsilon)*log((obj.Zl+obj.sigma*obj.beta)/(obj.Zl+obj.epsilon*obj.beta));
            end
            
            obj.L=obj.Zl-1-log(obj.Zl-obj.beta)-obj.q*obj.Il;
            obj.V=obj.Zv-1-log(obj.Zv-obj.beta)-obj.q*obj.Iv;
            err = 1-(obj.L/obj.V);
            %Volumes V = ZnRT/P => cm^3/mol
            
            obj.Vv = obj.Zv*obj.R*obj.T/P; % cm^3/mol
            obj.Vl = obj.Zl*obj.R*obj.T/P;
            
           
            newError = string(strcat("P: ", num2str(P), " err: ", num2str(err)));
            obj.err = [obj.err, newError] ;
        end
    end
end

