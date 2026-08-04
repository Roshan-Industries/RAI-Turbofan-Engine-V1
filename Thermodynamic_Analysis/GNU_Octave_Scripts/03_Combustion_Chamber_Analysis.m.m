clear;
clc;
close all;

%% 17.7 Combustion Chamber Analysis

% Compressor exit conditions from Section 17.6
Tt3 = 726.74;          % Combustor inlet total temperature, K
Pt3 = 1920e3;          % Combustor inlet total pressure, Pa

% Combustor assumptions
Tt4 = 1400;            % Turbine inlet temperature, K
pressure_loss = 0.05;  % Combustor total-pressure loss
eta_b = 0.99;          % Combustion efficiency
LHV = 43e6;            % Fuel lower heating value, J/kg
Cp = 1005;              % Specific heat capacity, J/(kg K)

% Core airflow
mdot_core = 20;        % kg/s

%% Combustor exit pressure

Pt4 = Pt3 * (1 - pressure_loss);

%% Fuel-air ratio

numerator = Cp * (Tt4 - Tt3);
denominator = eta_b * LHV - Cp * Tt4;

f = numerator / denominator;

%% Fuel and turbine-gas mass flow

mdot_fuel = f * mdot_core;
mdot_gas = mdot_core + mdot_fuel;

%% Fuel thermal power

fuel_power = mdot_fuel * LHV;

%% Display results

fprintf("\n");
fprintf("COMBUSTION CHAMBER ANALYSIS\n");
fprintf("---------------------------\n");
fprintf("Inlet total temperature  : %.2f K\n", Tt3);
fprintf("Exit total temperature   : %.2f K\n", Tt4);
fprintf("Inlet total pressure     : %.2f kPa\n", Pt3 / 1000);
fprintf("Exit total pressure      : %.2f kPa\n", Pt4 / 1000);
fprintf("Combustor pressure loss  : %.2f %%\n", pressure_loss * 100);
fprintf("Fuel-air ratio           : %.5f\n", f);
fprintf("Core air mass flow       : %.3f kg/s\n", mdot_core);
fprintf("Fuel mass flow           : %.3f kg/s\n", mdot_fuel);
fprintf("Turbine gas mass flow    : %.3f kg/s\n", mdot_gas);
fprintf("Fuel thermal power       : %.3f MW\n", fuel_power / 1e6);
