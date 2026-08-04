clear;
clc;
close all;

%% LOW-PRESSURE TURBINE ANALYSIS

% Inlet conditions from HPT analysis
Tt45 = 1003.25;       % K
Pt45 = 650.83e3;      % Pa

% Mass-flow conditions
mdot_core = 20.0;     % kg/s
mdot_gas  = 20.329;   % kg/s
BPR = 5.0;

% Assumed component specific works
Wfan = 50e3;          % J/kg of total fan airflow
WLPC = 70e3;          % J/kg of core airflow

% Gas properties and efficiencies
Cp = 1005;            % J/(kg K)
gamma = 1.4;
eta_t = 0.90;
eta_m = 0.99;

%% Fan and bypass mass flow

mdot_bypass = BPR * mdot_core;
mdot_fan = mdot_core + mdot_bypass;

%% Shaft-power requirements

Pfan = mdot_fan * Wfan;
PLPC = mdot_core * WLPC;

Pshaft = Pfan + PLPC;

% Turbine must provide slightly more power because of mechanical losses
PLPT = Pshaft / eta_m;

%% Required LPT specific work

WLPT = PLPT / mdot_gas;

%% Actual turbine exit temperature

Tt5 = Tt45 - WLPT / Cp;

%% Ideal turbine exit temperature

Tt5s = Tt45 - eta_t * (Tt45 - Tt5);

%% Turbine exit pressure

Pt5 = Pt45 * (Tt5s / Tt45)^(gamma / (gamma - 1));

%% Display results

fprintf('\n');
fprintf('LOW-PRESSURE TURBINE ANALYSIS\n');
fprintf('-------------------------------------\n');
fprintf('LPT inlet temperature  : %.2f K\n', Tt45);
fprintf('LPT exit temperature   : %.2f K\n', Tt5);
fprintf('LPT inlet pressure     : %.2f kPa\n', Pt45 / 1000);
fprintf('LPT exit pressure      : %.2f kPa\n', Pt5 / 1000);
fprintf('Bypass mass flow       : %.3f kg/s\n', mdot_bypass);
fprintf('Total fan mass flow    : %.3f kg/s\n', mdot_fan);
fprintf('Fan power requirement  : %.3f MW\n', Pfan / 1e6);
fprintf('LPC power requirement  : %.3f MW\n', PLPC / 1e6);
fprintf('LP-shaft power         : %.3f MW\n', Pshaft / 1e6);
fprintf('LPT power extraction   : %.3f MW\n', PLPT / 1e6);
fprintf('LPT specific work      : %.3f kJ/kg\n', WLPT / 1000);
