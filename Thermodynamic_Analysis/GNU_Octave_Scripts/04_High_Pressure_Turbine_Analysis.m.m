clear;
clc;
close all;

%% HIGH-PRESSURE TURBINE ANALYSIS

%% Inputs
Tt4 = 1400;          % K
Pt4 = 1824e3;        % Pa

Cp = 1005;           % J/kg-K
gamma = 1.4;

eta_t = 0.90;

mdot_core = 20;      % kg/s

%% Compressor work from Chapter 17.6
Wc = 398.73e3;       % J/kg

%% Turbine work
Wt = Wc;

%% Actual turbine exit temperature
Tt45 = Tt4 - Wt/Cp;

%% Ideal exit temperature
Tt45s = Tt4 - eta_t*(Tt4 - Tt45);

%% Turbine exit pressure
Pt45 = Pt4*(Tt45s/Tt4)^(gamma/(gamma-1));

%% Turbine Power
Pturbine = mdot_core*Wt;

%% Results

fprintf('\n');
fprintf('HIGH-PRESSURE TURBINE ANALYSIS\n');
fprintf('------------------------------------\n');

fprintf('Inlet Temperature : %.2f K\n',Tt4);
fprintf('Exit Temperature  : %.2f K\n',Tt45);

fprintf('Inlet Pressure    : %.2f kPa\n',Pt4/1000);
fprintf('Exit Pressure     : %.2f kPa\n',Pt45/1000);

fprintf('Specific Work     : %.2f kJ/kg\n',Wt/1000);

fprintf('Turbine Power     : %.2f MW\n',Pturbine/1e6);
