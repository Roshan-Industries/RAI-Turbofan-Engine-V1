clear;
clc;
close all;

%% NET THRUST ANALYSIS

F_core = 7931.14;          % N
F_bypass = 28474.39;       % N

mdot_core_air = 20.0;      % kg/s
mdot_bypass = 100.0;       % kg/s
mdot_total_air = mdot_core_air + mdot_bypass;

%% Total net thrust

F_net = F_core + F_bypass;

%% Thrust distribution

core_percentage = ...
    (F_core / F_net) * 100;

bypass_percentage = ...
    (F_bypass / F_net) * 100;

%% Specific thrust

specific_thrust = ...
    F_net / mdot_total_air;

%% Display results

fprintf('\n');
fprintf('NET THRUST ANALYSIS\n');
fprintf('---------------------------------\n');
fprintf('Core thrust             : %.2f N\n', F_core);
fprintf('Bypass thrust           : %.2f N\n', F_bypass);
fprintf('Total net thrust        : %.2f N\n', F_net);
fprintf('Total net thrust        : %.3f kN\n', F_net / 1000);
fprintf('Core thrust percentage  : %.2f %%\n', core_percentage);
fprintf('Bypass thrust percentage: %.2f %%\n', bypass_percentage);
fprintf('Specific thrust         : %.2f N/(kg/s)\n', ...
    specific_thrust);
