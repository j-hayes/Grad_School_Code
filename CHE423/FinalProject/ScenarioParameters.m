classdef ScenarioParameters  
      properties
        inchToMeter
        D1
        D2
        D3 
        D4 
        L 
        V_PFR_inner
        V_PFR_outer 
        V_Jacket 
        r_torus
        R_torus
        VCSTR 
        a 
        U
        Ua
        X0
        Ca0
        Cb0
        volumetricFlowRateFeed 
        Fa0
        Cps 
        mDotCp 
        specificHeatCoolant 
        molecularWeightCoolant 
        calPerkJ
        gramPerKg
        Cpcool
        T0_k 
        T0_Kc 
        T0 
        Ta0 
        k0 
        Kc0 
        dHrxn
        E
        R 
        VSpan

    end
    
    methods
          function obj = ScenarioParameters()           
            obj.inchToMeter = 0.0254;
            obj.D1 = 1*obj.inchToMeter;%m
            obj.D2 = 1.333*obj.inchToMeter;%m 1 INCH SCEDULE 40 PIPE
            obj.D3 = 2*obj.inchToMeter;
            obj.D4 = 2.154*obj.inchToMeter; %SURROUNDED BY 2 INCH SHEDULE 40 PIPE;
            obj.L = 3;%m

            obj.V_PFR_inner = obj.L*pi*obj.D1^2/4;
            obj.V_PFR_outer = obj.L*pi*obj.D2^2/4;
            obj.V_Jacket = (obj.L*pi*obj.D1^2/4) - obj.V_PFR_outer;
            obj.r_torus = (obj.D1/2);
            obj.R_torus = obj.D1 + 2*(obj.D4-obj.D1) + .1; % inner pipe + everything else + small gap for airflow
            obj.VCSTR = (pi*(obj.r_torus^2)*(2*pi*obj.R_torus))/2;%volume of torus/2 

            obj.a = obj.D2/obj.D2^2;%m^2

            obj.U = 178.76; %W/m^2 *K
            obj.Ua = obj.U*obj.a;% (J/m^3 s K)

            obj.X0 = 0;
            obj.Ca0 = 14.5; % mol/m^3
            obj.Cb0 = obj.Ca0;
            obj.volumetricFlowRateFeed = .0037;%m^3/s
            obj.Fa0 = obj.Ca0*obj.volumetricFlowRateFeed;
            obj.Cps = 30;%cal/m
            obj.mDotCp = .018; % mol/s
            obj.specificHeatCoolant = 1.685;%KJ/kg;
            obj.molecularWeightCoolant = 190;%g/mol
            obj.calPerkJ = (1/.004184);
            obj.gramPerKg =  (1/1000);
            obj.Cpcool = obj.specificHeatCoolant*obj.gramPerKg*obj.molecularWeightCoolant*obj.calPerkJ;

            obj.T0_k = 300; %  Kelvin initial temperature for the k1 &pass this in as a parameter 
            obj.T0_Kc = 450; % Kelvin initial temperature for the Kc1 &pass this in as a parameter
            obj.T0 = 273.15 + 30;
            obj.Ta0 = 273.15 + 20;
            obj.k0 = .01;
            obj.Kc0 = 10;
            obj.dHrxn = 6000;
            obj.E = 10000;
            obj.R = 1.987;%cal/(mol*K)
            obj.VSpan = 0:(obj.V_PFR_inner/100):obj.V_PFR_inner; 
        end
    end
end

