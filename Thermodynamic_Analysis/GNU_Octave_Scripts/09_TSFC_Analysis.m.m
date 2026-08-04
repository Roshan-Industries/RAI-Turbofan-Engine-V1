clear;
clc;
close all;

%% THRUST-SPECIFIC FUEL CONSUMPTION ANALYSIS

% Inputs from previous sections
mdot_fuel = 0.329;       % kg/s
F_net = 36405.53;        % N

%% TSFC calculation

TSFC_SI = mdot_fuel / F_net;      % kg/(N s)

%% Unit conversions

TSFC_kg_kN_h = TSFC_SI * 1000 * 3600;
TSFC_mg_N_s = TSFC_SI * 1e6;

%% Display results

fprintf('\n');
fprintf('THRUST-SPECIFIC FUEL CONSUMPTION ANALYSIS\n');
fprintf('------------------------------------------------\n');
fprintf('Fuel mass-flow rate      : %.3f kg/s\n', mdot_fuel);
fprintf('Total net thrust         : %.2f N\n', F_net);
fprintf('Total net thrust         : %.3f kN\n', F_net / 1000);
fprintf('TSFC                     : %.8e kg/(N s)\n', TSFC_SI);
fprintf('TSFC                     : %.2f mg/(N s)\n', TSFC_mg_N_s);
fprintf('TSFC                     : %.2f kg/(kN h)\n', TSFC_kg_kN_h);
