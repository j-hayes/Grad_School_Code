scenarioParameters = ScenarioParameters;
Scenario1(scenarioParameters,1);
Scenario2(scenarioParameters,2);
Scenario3(scenarioParameters,3);

scenarioParametersOptimized1 = ScenarioParameters;
scenarioParametersOptimized1.T0 = 313.15;
scenarioParametersOptimized1.Ta0 = 283.15;
scenarioParametersOptimized1.mDotCp = .018;
Scenario1(scenarioParametersOptimized1,4);

scenarioParametersOptimized2 = ScenarioParameters;
scenarioParametersOptimized2.T0 = 293.15;
scenarioParametersOptimized2.Ca0 = 25;
Scenario2(scenarioParametersOptimized2,5);


scenarioParametersOptimized3 = ScenarioParameters;
scenarioParametersOptimized3.T0 = 293.15;
scenarioParametersOptimized3.Ta0 = 283.15;
scenarioParametersOptimized3.Ca0 = 18.7;
scenarioParametersOptimized1.mDotCp = .018;
Scenario3(scenarioParametersOptimized3,6);


